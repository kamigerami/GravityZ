//
//  Ground.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-22.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import Foundation
import SpriteKit

class Ground: SKSpriteNode {
    
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 46.0/255.0, alpha: 1.0)
    let COLOR_TWO = UIColor(red: 36.0/255.0, green: 36.0/255.0, blue: 36.0/255.0, alpha: 1.0)
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(size.width*2, size.height))
        anchorPoint = CGPointMake(0, 0.5)
        
        for var i = 0; i < NUMBER_OF_SEGMENTS; i++ {
            var segmentColor: UIColor!
            if i % 2 == 0 {
                segmentColor = COLOR_ONE
            } else {
                segmentColor = COLOR_TWO
            }
            
            let segment = SKSpriteNode(color: segmentColor, size: CGSizeMake(self.size.width / CGFloat(NUMBER_OF_SEGMENTS), self.size.height))
            segment.anchorPoint = CGPointMake(0.0, 0.5)
            segment.position = CGPointMake(CGFloat(i)*segment.size.width, 0)
            addChild(segment)
            
            segment.physicsBody = SKPhysicsBody(rectangleOfSize: segment.frame.size)
            segment.physicsBody?.dynamic = false
            segment.physicsBody!.categoryBitMask = GameScene.ColliderType.GROUND.rawValue
            segment.physicsBody!.contactTestBitMask = GameScene.ColliderType.PLAYER.rawValue
            segment.physicsBody!.collisionBitMask = GameScene.ColliderType.PLAYER.rawValue
  
        }
      
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func start() {
        let adjustedDuration = NSTimeInterval(frame.size.width/100)
        
        let moveLeft = SKAction.moveByX(-frame.size.width/2, y: 0, duration: adjustedDuration)
        let resetPosition = SKAction.moveByX(frame.size.width/2, y: 0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft, resetPosition])
        
        runAction(SKAction.repeatActionForever(moveSequence))
    }
    
    func stop() {
        removeAllActions()
    }
}