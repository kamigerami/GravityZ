//
//  Player.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-21.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//
import Foundation
import SpriteKit



class Player: SKSpriteNode {

    var body: SKSpriteNode!
    var arm: SKSpriteNode!
    var left_foot: SKSpriteNode!
    var right_foot: SKSpriteNode!
    
    
    init(size: CGSize) {
        
        // the frame of which the rest of the body is a part of
        
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(size.height/8, size.height/6))
     
        // The body
        
        body = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height - 4))
        body.position = CGPointMake(0, 2)
        
        addChild(body)
        
        // the facial features
        
        let skinColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        
        let face = SKSpriteNode(color: skinColor, size: CGSizeMake(self.frame.size.width, self.frame.size.height/3))
            face.position = CGPointMake(0, 6)
        
        body.addChild(face)
        
        
        // eyes
        
        let eyeColor = UIColor.whiteColor()
        let leftEye = SKSpriteNode(color: eyeColor, size: CGSizeMake(6, 6))
        let rightEye = leftEye.copy() as! SKSpriteNode
        
        let pupil = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(3,3))
            pupil.position = CGPointMake(2, 0)
        
        leftEye.addChild(pupil)
        rightEye.addChild(pupil.copy() as! SKSpriteNode)
        
        leftEye.position = CGPointMake(4, 0)
        
        face.addChild(leftEye)
        
        rightEye.position = CGPointMake(22, 0)
        
        face.addChild(rightEye)
        
        // eyebrows
        
        let eyeBrows = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(10, 2))
        eyeBrows.position = CGPointMake(0, leftEye.size.height/2 + 2)
        
        leftEye.addChild(eyeBrows)
        rightEye.addChild(eyeBrows.copy() as! SKSpriteNode)
        
        // the arms
        let armColor =  UIColor(red: 44.0/255.0, green: 44.0/255.0, blue: 44.0/255.0, alpha: 1.0)
        arm = SKSpriteNode(color: armColor, size: CGSizeMake(8, 14))
        arm.anchorPoint = CGPointMake(0.5,0.9)
        arm.position = CGPointMake(-11, -6)
        body.addChild(arm)
        
        let hand = SKSpriteNode(color: skinColor, size: CGSizeMake(arm.size.width, 5))
        hand.position = CGPointMake(0.0, -arm.size.height * 0.9 + hand.size.height/2)
        
        arm.addChild(hand)
        
        
        // the legs
        left_foot = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(body.size.width/4, body.size.height/8))
        left_foot.position = CGPointMake(leftEye.position.x - left_foot.size.width + 2, -body.size.height/2 + left_foot.size.height/2 - 4)
        
        addChild(left_foot)
        
        right_foot = left_foot.copy() as! SKSpriteNode
        right_foot.position.x = left_foot.position.x + 18
        
        
        addChild(right_foot)
        

        
        }
    
     // animations 
    
    func breath() {
        
        let breathOut = SKAction.moveByX(0.0, y: -2.0, duration: 1)
        let breathIn = SKAction.moveByX(0.0, y: 2.0 , duration: 1)
        
        let breath = SKAction.sequence([breathOut, breathIn])
        body.runAction(SKAction.repeatActionForever(breath))
        
    }
    
    func stop() {
        body.removeAllActions()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
