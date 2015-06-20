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
    let player:Player = Player()
    let maxLevels = 3
    let motionManager: CMMotionManager = CMMotionManager()
    var accelerationX: CGFloat = 0.0
    
    func setupPlayer(){
        player.position = CGPoint(x:player.size.width/2 + 20 , y:player.size.height/2 + 10)
        addChild(player)
    }
    
    override func didMoveToView(view: SKView) {
            self.physicsWorld.gravity = CGVectorMake(0, 0)
            self.physicsWorld.contactDelegate = self
            self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
            self.physicsBody?.categoryBitMask = Player.CollisionCategories.EdgeBody

            let starField = SKEmitterNode(fileNamed: "StarField")
            starField.position = CGPointMake(size.width/2,size.height)
            starField.zPosition = -1000
        
            addChild(starField)
        
            backgroundColor = SKColor.blackColor()
        
            setupPlayer()
            setupAccelerometer()

        
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
      
        
        
        
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
    
    override func didSimulatePhysics() {
        player.physicsBody?.velocity = CGVector(dx: accelerationX * 600, dy: 0)
    }
    
  
    
}
