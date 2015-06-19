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
    
    
    init() {
        let texture = SKTexture(imageNamed: "player1")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func animate(){
        var playerTextures:[SKTexture] = []
        for i in 1...2 {
            playerTextures.append(SKTexture(imageNamed: "player\(i)"))
        }
        let playerAnimation = SKAction.repeatActionForever( SKAction.animateWithTextures(playerTextures, timePerFrame: 0.1))
        self.runAction(playerAnimation)
    }
    
    
    func die (){
        
    }
    
    func kill(){
        
    }
    
    func respawn(){
        
    }
    
    func fireBullet(scene: SKScene){
        
    }
}