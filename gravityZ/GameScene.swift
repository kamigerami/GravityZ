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
    var isStarted = false

    
    
    var bg = SKSpriteNode()
    
    var fg = SKSpriteNode()
    
    var World: SKNode!
    var Camera: SKNode!

    var player: Player!
    
    var ground: GroundMovement!

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
            // add the rest of foreground / background here //
        
        
       // starField
        
            starField.position = CGPointMake(size.width/2,size.height)
            starField.zPosition = 5
       
      // Player
       
        // instantiating the Player with the size arguments
        player = Player(size: CGSizeMake(frame.size.height, frame.size.height))
        
        player.zPosition = 1
        
        player.position = CGPointMake(size.width / 4 + player.size.width - 200 , fg.position.y / 4 - player.size.height * 1.5 - 12 )
        
        player.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        player.physicsBody?.dynamic = true
        player.physicsBody?.allowsRotation = false
        
        World.addChild(player)
        player.breath()


        
        

        
    }
   
    func centerOnNode(node: SKNode) {
        
        let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)
        
        node.parent!.runAction(SKAction.moveTo(CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y), duration: 1))

    }
    
    override func didFinishUpdate() {
        
        Camera.position = CGPoint(x: player.position.x, y: player.position.y)
        
        self.centerOnNode(Camera!)
        
    }

    func start() {
        isStarted = true
        player.stop()
        player.startRunning()
        World.addChild(starField)

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if !isStarted {
            start()
        } else {
            player.stop()
            player.jump()
     
        }
        
        // preventing double jump mid air
       // if player.position.y <= fg.position.y * -2 {
        /*
        player.physicsBody?.velocity = CGVectorMake(0,0)
        player.physicsBody?.applyImpulse(CGVectorMake(0,155))
        */
        //}

    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    
            player.stop()
  
    
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */



    }
            

}
