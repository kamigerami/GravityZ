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
    var fg = SKSpriteNode()



    let starField = SKEmitterNode(fileNamed: "StarField")
    
    override func didMoveToView(view: SKView) {
        
        
        // background
        
     
        
            self.physicsWorld.gravity = CGVectorMake(0, -20)
            self.physicsWorld.contactDelegate = self
            self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)

        
            var bgTexture = SKTexture(imageNamed: "bg_far")
            var moveBG = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 4)
            var replaceBG = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
            var moveBGForever = SKAction.repeatActionForever(SKAction.sequence([moveBG,replaceBG]))

        
        for var i : CGFloat = 0; i < 4; i++ {
            
            
              bg = SKSpriteNode(texture: bgTexture)
                bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
              bg.size.height = self.frame.height
          
              bg.runAction(moveBGForever)
              self.addChild(bg)
            }
        
        // foreground
        fg = SKSpriteNode(color: UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 0.5), size: CGSize(width: bg.size.width * 2, height: 100))
        fg.position = CGPointMake(0, -self.frame.size.height/4 + fg.frame.size.height)
        fg.zPosition = 5
        
        fg.physicsBody = SKPhysicsBody(rectangleOfSize: fg.size)
        fg.physicsBody?.dynamic = false
        
        addChild(fg)
        
            
            
       // starField
        
            starField.position = CGPointMake(size.width/2,size.height)
            starField.zPosition = 5
            addChild(starField)
       
      // Player
        
        
            player = SKSpriteNode(color: UIColor(white: 1.0, alpha: 0.9), size: CGSize(width: self.frame.height/25, height: self.frame.height/25))
        
            // place player in middle x position and on top of foreground.size
            player.position = CGPoint(x: self.frame.size.width / 2, y: fg.size.height + player.size.height)
            player.zPosition = 10
        
        
        player.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(player.frame.size.width, player.frame.size.height))
            player.physicsBody?.dynamic = true
            player.physicsBody?.allowsRotation = false
        
            self.addChild(player)
        
        
    
        
      // accelerometer
      setupAccelerometer()

        
    }
   
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // preventing double jump mid air
        player.color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.9)
        if player.position.y <= fg.size.height + player.size.height{
            player.physicsBody?.velocity = CGVectorMake(0,0)
            player.physicsBody?.applyImpulse(CGVectorMake(0,10))
        }
        
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        player.color = UIColor(white: 1.0, alpha: 0.9
        )

    
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
