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
    
    var selected: [UITouch: SKNode] = [:]
    
    
   /* func setupPlayer(){
        
        struct CollisionCategories{
            static let Player: UInt32 = 0x1 << 1
            static let EdgeBody: UInt32 = 0x1 << 4
        }
        
        var player = SKSpriteNode()
        
            let texture1 = SKTexture(imageNamed: "player1")
        
            let texture2 = SKTexture(imageNamed: "player2")
            
            var animation = SKAction.animateWithTextures([texture1, texture2], timePerFrame: 0.1)
            var makeAnimation = SKAction.repeatActionForever(animation)
            
            self.runAction(makeAnimation)
        
            
            player.physicsBody =
            SKPhysicsBody(texture: player.texture,size:player.size)
            //self.physicsBody?.dynamic = true
            player.physicsBody?.usesPreciseCollisionDetection = true
            player.physicsBody?.collisionBitMask = 0x0
            player.physicsBody?.categoryBitMask = CollisionCategories.Player
            player.physicsBody?.collisionBitMask = CollisionCategories.EdgeBody
            player.physicsBody?.allowsRotation = true
            

        player.position = CGPoint(x:player.size.width/2 + 20 , y:player.size.height/2 + 10)
        addChild(player)
        
        
    }*/
    
    override func didMoveToView(view: SKView) {
        
        
        // background
            var bg = SKSpriteNode()
        
        
        
            self.physicsWorld.gravity = CGVectorMake(0, -20)
            self.physicsWorld.contactDelegate = self
            self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)

        
            var bgTexture = SKTexture(imageNamed: "bg_far")
            var moveBG = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 7)
            var replaceBG = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
            var moveBGForever = SKAction.repeatActionForever(SKAction.sequence([moveBG,replaceBG]))

        
        for var i : CGFloat = 0; i < 4; i++ {
            
            
              bg = SKSpriteNode(texture: bgTexture)
                bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
              bg.size.height = self.frame.height
          
              bg.runAction(moveBGForever)
              self.addChild(bg)
            }
        
        
        
       // starField
        
            let starField = SKEmitterNode(fileNamed: "StarField")
            starField.position = CGPointMake(size.width/2,size.height)
            starField.zPosition = 5
            addChild(starField)
       
      // Player
        
        
        
        
        
      // accelerometer
      setupAccelerometer()

        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
      
        selected = [:]
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self) //1
           
             selected[touch as! UITouch] = nodeAtPoint(location)
            
            print(selected)
            
            // logic for the movement
            
            // touching half top of screen
    
        
        }
        

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
