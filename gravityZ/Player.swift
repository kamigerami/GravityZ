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
    
    var aniMate: () = ()
    
          
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