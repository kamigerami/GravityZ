//
//  Player.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-20.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//
import UIKit
import SpriteKit


class Player: SKSpriteNode {
    
    struct CollisionCategories{
        static let Player: UInt32 = 0x1 << 1
        static let EdgeBody: UInt32 = 0x1 << 4
    }
    
 
    
      init() {
        let texture1 = SKTexture(imageNamed: "player1")
        super.init(texture: texture1, color: SKColor.clearColor(), size: texture1.size())
        
        let texture2 = SKTexture(imageNamed: "player2")
        
        var animation = SKAction.animateWithTextures([texture1, texture2], timePerFrame: 0.1)
        var makeAnimation = SKAction.repeatActionForever(animation)
        
        self.runAction(makeAnimation)
      
        self.physicsBody =
            SKPhysicsBody(texture: self.texture,size:self.size)
        //self.physicsBody?.dynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.categoryBitMask = CollisionCategories.Player
        self.physicsBody?.collisionBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.allowsRotation = true
      
        
    }
    
  
    private var invincible = false
    private var lives:Int = 3 {
        didSet {
            if(lives < 0){
                kill()
            }else{
                respawn()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func die (){
        if(invincible == false){
            lives -= 1
        }
    }
    
    func kill(){
        let gameOverScene = StartGameScene(size: self.scene!.size)
        gameOverScene.scaleMode = self.scene!.scaleMode
        let transitionType = SKTransition.flipHorizontalWithDuration(0.5)
        self.scene!.view!.presentScene(gameOverScene,transition: transitionType)
    }
    
    func respawn(){
        invincible = true
        let fadeOutAction = SKAction.fadeOutWithDuration(0.4)
        let fadeInAction = SKAction.fadeInWithDuration(0.4)
        let fadeOutIn = SKAction.sequence([fadeOutAction,fadeInAction])
        let fadeOutInAction = SKAction.repeatAction(fadeOutIn, count: 5)
        let setInvicibleFalse = SKAction.runBlock(){
            self.invincible = false
        }
        runAction(SKAction.sequence([fadeOutInAction,setInvicibleFalse]))
        
    }
    
    func fireBullet(scene: SKScene){
        
    }
}