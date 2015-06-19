//
//  GameScene.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-19.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let player:Player = Player()
    
    func setupPlayer(){
        player.position = CGPoint(x:CGRectGetMidX(self.frame), y:player.size.height/2 + 10)
        addChild(player)
    }
    
    override func didMoveToView(view: SKView) {
        
            backgroundColor = SKColor.blackColor()
        
            setupPlayer()
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
      
        
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */

    }
}