//
//  StartGameScene.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-19.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import UIKit
import SpriteKit
class StartGameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        let startGameButton = SKSpriteNode(imageNamed: "taptostartbutton")
        startGameButton.position = CGPointMake(size.width/2, size.height/2 - 100)
        startGameButton.name = "startgame"
        addChild(startGameButton)
        backgroundColor = SKColor.blackColor()
    
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        
        if (touchedNode.name == "startgame") {
            let gameOverScene = GameScene(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.doorsOpenVerticalWithDuration(1.5)
            view?.presentScene(gameOverScene,transition: transitionType)
            
            
            
        }
    }

}
