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
    var player = SKSpriteNode()
    var player_left_eye = SKSpriteNode()
    var player_right_eye = SKSpriteNode()
    
    var fg = SKSpriteNode()
    
    var World: SKNode!
    var Camera: SKNode!



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
            fg = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: self.frame.width * i, height: player.size.height))
            fg.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
            fg.position = CGPoint(x: self.frame.width / i, y: self.frame.height / i - 70)
            World.addChild(fg)
            
        }
        
       // starField
        
            starField.position = CGPointMake(size.width/2,size.height)
            starField.zPosition = 5
            World.addChild(starField)
       
      // Player
        
        
            player = SKSpriteNode(color: UIColor(white: 1.0, alpha: 0.9), size: CGSize(width: self.frame.height/15, height: self.frame.height/15))
        
            // place player in middle x position and on top of foreground.size
            player.position = CGPoint(x: CGRectGetMidX(self.frame), y: player.size.height)
            player.zPosition = 10
        
        
        player.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(player.frame.size.width, player.frame.size.height))
            player.physicsBody?.dynamic = true
            player.physicsBody?.allowsRotation = false
        
            World.addChild(player)
        
            player_left_eye = SKSpriteNode(color: UIColor(red: 0.140, green: 0.130, blue: 0.130, alpha: 1.0), size: CGSize(width: self.frame.height/55, height: self.frame.height/55))
            player_right_eye = SKSpriteNode(color: UIColor(red: 0.140, green: 0.130, blue: 0.130, alpha: 1.0), size: CGSize(width: self.frame.height/55, height: self.frame.height/55))
        
            player_left_eye.position = CGPointMake(5, 5)
            player_right_eye.position = CGPointMake(-5, 5)

            player.addChild(player_left_eye)
            player.addChild(player_right_eye)

        
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
        
        player.color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.9)
        if player.position.y <= fg.position.y * -2 {
            player.physicsBody?.velocity = CGVectorMake(0,0)
            player.physicsBody?.applyImpulse(CGVectorMake(0,15))
        }
        
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
       // player.color = UIColor(white: 1.0, alpha: 0.9)

    
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if player.position.y <= fg.position.y * -2 {
            player.color = UIColor(white: 1.0, alpha: 0.9)
  

        } else {
            player.color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.9)
   
            


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

    
  
    
    }
