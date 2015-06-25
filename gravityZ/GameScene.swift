//
//  GameScene.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-19.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let maxLevels = 3
    let motionManager: CMMotionManager = CMMotionManager()
    var accelerationX: CGFloat = 0.5
    
    var isStarted = false
    var contactWithGround = false
    
    
    var World: SKNode!
    var Camera: SKNode!
    
    var bg: backGround!

    var player: Player!
    var PLAYER: UInt32!
    
    
    var fg: Ground!
    var GROUND: UInt32!
    
    let starField = SKEmitterNode(fileNamed: "StarField")


    
    enum ColliderType:UInt32 {
        case PLAYER = 1
        case GROUND = 2
    }
    
    
    
    override func didMoveToView(view: SKView) {
    // add BG
        
        // create and add blue-fish.png image to screen
        
        
        
        addPhysicsWorld()
        addMovingBackground()
        addMovingGround()
        addPlayer()
        doSwipes()
        
    }
    /// swipe gestures

    
    func doSwipes() {
        
        /* Setup your scene here */
        
        
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
        swipeUp.direction = .Up
        self.view!.addGestureRecognizer(swipeUp)
        
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedDown:"))
        swipeDown.direction = .Down
        self.view!.addGestureRecognizer(swipeDown)
        
        
        
    }
    
    func gravitySwitch() {
        
        if player.isNotUpsideDown {
            println("changing gravitational pull")
            self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
            player.flip()
            
        } else {
            print("player is NOT upsidedown?:\(player.isNotUpsideDown)")
            player.flip()
            self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 9.8)
        }

        
        
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        gravitySwitch()
     }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
                gravitySwitch()
    }
    
    //
    
    
    func addStarField() {
        
        
        // starField
        
        starField.position = CGPointMake(size.width/2,size.height)
        starField.zPosition = 5
        addChild(starField)

        
        
        
    }
    func addPhysicsWorld() {
        
        
        // world and camera
        
        self.physicsWorld.contactDelegate = self
       // self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.World = SKNode()
        self.World.name = "World"
        addChild(World)
        self.Camera = SKNode()
        self.Camera.name = "Camera"
        self.World.addChild(Camera)
        
        // background
        
        //self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        // add the rest of foreground / background here //
        self.backgroundColor = UIColor.grayColor()
        
        

        
    }
    
    func addPlayer() {
        // Player
        
        // instantiating the Player with the size arguments
        player = Player(size: CGSizeMake(frame.size.height, frame.size.height))
        
        player.zPosition = 1
        
        player.position = CGPointMake(70, fg.position.y + fg.frame.size.height/2 + player.frame.size.height/2)
        
        // set physics
        
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.frame.size)
        player.physicsBody?.dynamic = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody!.categoryBitMask = ColliderType.PLAYER.rawValue
        player.physicsBody!.contactTestBitMask = ColliderType.GROUND.rawValue
        player.physicsBody!.collisionBitMask = ColliderType.GROUND.rawValue
        
        addChild(player)
        
        player.breath()

        
        
    }
    
    func addMovingGround() {
        fg = Ground(size: CGSizeMake(view!.frame.width, kfgHeight))
        fg.position = CGPointMake(0, view!.frame.size.height/2)
        
        addChild(fg)
    }
    
    func addMovingBackground() {
        bg = backGround(size: CGSizeMake(view!.frame.width, kfgHeight))
        bg.position = CGPointMake(0, -kfgHeight * 2 )
        bg.zPosition = -15
        addChild(bg)
        
        
    }
    func centerOnNode(node: SKNode) {
        
        let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)
        
        node.parent!.runAction(SKAction.moveTo(CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y), duration: 1))

    }
    
    override func didFinishUpdate() {
        
        Camera.position = CGPoint(x: player.position.x, y: player.position.y)
        
        self.centerOnNode(Camera!)
        
    }

    func didBeginContact(contact: SKPhysicsContact) {
            contactWithGround = true
    }
   

    
    func start() {
        isStarted = true
        player.stop()
        player.startRunning()
        addStarField()
        fg.start()

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if !isStarted {
            start()
        } else {
            player.stop()
              }
        

    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if isStarted {
            player.stop()
            if contactWithGround {
                contactWithGround = false
                if !player.isNotUpsideDown {
                    player.jump()
                } else {
                    player.gravityJump()
                }
            }

        }
    
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */



    }
            

}
