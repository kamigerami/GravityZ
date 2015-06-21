//
//  GameScene.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-19.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import SpriteKit
import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    let maxLevels = 3
    let motionManager: CMMotionManager = CMMotionManager()
    var accelerationX: CGFloat = 0.5
    
    var bg = SKSpriteNode()
    
    var fg = SKSpriteNode()
    
    var World: SKNode!
    var Camera: SKNode!

    var player: Player!
    

    let starField = SKEmitterNode(fileNamed: "StarField")
    
    
    
    
    override func didMoveToView(view: SKView) {
        
     
        
        // world and camera
        
        self.physicsWorld.contactDelegate = self
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.World = SKNode()
        self.World.name = "World"
        addChild(World)
        self.Camera = SKNode()
        self.Camera.name = "Camera"
        self.World.addChild(Camera)
        
        // background
        
            self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
        
            var bgTexture = SKTexture(imageNamed: "bg_far")
            var moveBG = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 4)
            var replaceBG = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
            var moveBGForever = SKAction.repeatActionForever(SKAction.sequence([moveBG,replaceBG]))

            backgroundColor = SKColor.blackColor()

        
       
        for var i : CGFloat = 0; i < 4; i++ {
            
            
              bg = SKSpriteNode(texture: bgTexture)
                bg.position = CGPoint(x: bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
              bg.size.height = self.frame.height
          
              bg.runAction(moveBGForever)
              World.addChild(bg)
            
            // ground level
            fg = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: self.frame.width * i, height: fg.size.height))
            fg.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
            fg.position = CGPoint(x: self.frame.width / i, y: self.frame.height / i - 70)
            World.addChild(fg)
            
        }
        
       // starField
        
            starField.position = CGPointMake(size.width/2,size.height)
            starField.zPosition = 5
            World.addChild(starField)
       
      // Player
       
        // instantiating the Player with the size arguments
        player = Player(size: CGSizeMake(frame.size.height, frame.size.height))
        
        player.zPosition = 1
        
        player.position = CGPointMake(size.width / 4 + player.size.width - 200 , fg.position.y / 4 - player.size.height * 1.5 - 20 )
        
        World.addChild(player)
        

        
        

        
    }
   
    func centerOnNode(node: SKNode) {
        
        let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)
        
        node.parent!.runAction(SKAction.moveTo(CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y), duration: 1))

    }
    
    override func didFinishUpdate() {
        
        Camera.position = CGPoint(x: player.position.x, y: player.position.y)
        
        self.centerOnNode(Camera!)
        
    }

    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // preventing double jump mid air
        
        if player.position.y <= fg.position.y * -2 {
            player.physicsBody?.velocity = CGVectorMake(0,0)
            player.physicsBody?.applyImpulse(CGVectorMake(0,15))
        }
        
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {

    
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */



    }
            
  
        
    
    func setupAccelerometer(){
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {
            (accelerometerData: CMAccelerometerData!, error: NSError!) in
            let acceleration = accelerometerData.acceleration
            self.accelerationX = CGFloat(acceleration.x)
        })
    }
}


