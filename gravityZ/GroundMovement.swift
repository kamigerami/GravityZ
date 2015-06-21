//
//  GroundMovement.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-21.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import Foundation
import SpriteKit

class GroundMovement: SKSpriteNode {
    
    
    var bgTexture: SKTexture!
    
    var bg: SKSpriteNode!
    
    var fg: SKSpriteNode!
    
    
    
    
    init(size: CGSize) {

        super.init(texture: SKTexture(imageNamed: "bg_far"), color: UIColor.clearColor(), size: CGSizeMake(size.width * 4, size.height))

        var moveBG = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 4)
        var replaceBG = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        var moveBGForever = SKAction.repeatActionForever(SKAction.sequence([moveBG,replaceBG]))
        
    
    
        for var i : CGFloat = 0; i < 4; i++ {
    
    
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
            bg.size.height = self.frame.height
    
            bg.runAction(moveBGForever)
            
            addChild(bg)
    
            // ground level
            fg = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: self.frame.width * i, height: fg.size.height))
            fg.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
            
            fg.position = CGPoint(x: self.frame.width / i, y: self.frame.height / i - 70)
            
            addChild(fg)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
