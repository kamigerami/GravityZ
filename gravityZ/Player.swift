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
    var left_leg: SKSpriteNode!
    var right_leg: SKSpriteNode!
    
    var isNotUpsideDown = false
    var gravityOn = false
    
    
    var World = GameScene()
    

    
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
        arm.position = CGPointMake(-12, -12)
        body.addChild(arm)
        
        let hand = SKSpriteNode(color: skinColor, size: CGSizeMake(arm.size.width, 5))
        hand.position = CGPointMake(0.0, -arm.size.height * 0.9 + hand.size.height/2)
        
        arm.addChild(hand)
        
        
        // the legs
        
        // left leg
        
        left_leg = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(body.size.width/4, body.size.height/8 + 2))
        left_leg.position = CGPointMake(leftEye.position.x - left_leg.size.width + 2, -body.size.height/2 + left_leg.size.height/2 - 8)
        
        addChild(left_leg)
        
        // right leg
        right_leg = left_leg.copy() as! SKSpriteNode
        right_leg.position.x = left_leg.position.x + 18
        
        
        addChild(right_leg)
        
        
        // left foot
        
        let left_foot = SKSpriteNode(color: skinColor, size: CGSizeMake(left_leg.size.width, left_leg.size.height/4))
        left_foot.position = CGPointMake(0,-4)
        
        left_leg.addChild(left_foot)
        
        // right foot
        
        let right_foot = left_foot.copy() as! SKSpriteNode
        
        right_leg.addChild(right_foot)
        
        }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // animations
    
    func startRunning() {
        let rotateBack = SKAction.rotateByAngle(-CGFloat(M_PI)/2.0, duration: 0.1)
        arm.runAction(rotateBack)
        
        performOneRunCycle()
    }
    
    func performOneRunCycle() {
        let up = SKAction.moveByX(0, y: 2, duration: 0.1)
        let down = SKAction.moveByX(0, y: -2, duration: 0.1)
        
        left_leg.runAction(up, completion: { () -> Void in
            self.left_leg.runAction(down)
            self.right_leg.runAction(up, completion: { () -> Void in
                self.right_leg.runAction(down, completion:  { () -> Void in
                    self.performOneRunCycle()
                    
                })
            })
        })
    }
    
    func jump() {
        let rotateBack = SKAction.rotateByAngle(CGFloat(M_PI)/2.0, duration: 0.1)
        let rotateReverse = SKAction.rotateByAngle(-CGFloat(M_PI)/2.0, duration: 0.1)
        
        let down = SKAction.moveByX(0, y: -5, duration: 0.05)
        let up  = SKAction.moveByX(0, y: 5, duration: 0.05)
        body.runAction(SKAction.sequence([down,up]))
        arm.runAction(SKAction.sequence([rotateBack, rotateReverse]))
        body.position.y = 0
        self.physicsBody?.velocity = CGVectorMake(0,0)
        self.physicsBody?.applyImpulse(CGVectorMake(0,75))

    }
    
    func gravityJump() {
        let rotateBack = SKAction.rotateByAngle(CGFloat(M_PI)/2.0, duration: 0.1)
        let rotateReverse = SKAction.rotateByAngle(-CGFloat(M_PI)/2.0, duration: 0.1)
        
        let down = SKAction.moveByX(0, y: -5, duration: 0.05)
        let up  = SKAction.moveByX(0, y: 5, duration: 0.05)
        body.runAction(SKAction.sequence([down,up]))
        arm.runAction(SKAction.sequence([rotateBack, rotateReverse]))
        body.position.y = 0
        self.physicsBody?.velocity = CGVectorMake(0,0)
        self.physicsBody?.applyImpulse(CGVectorMake(0,-75))
        
        
    }
    
    func flip() {
        isNotUpsideDown = !isNotUpsideDown
        
        var scale: CGFloat!
          if isNotUpsideDown {
              scale = -1.0
          } else {
              scale = 1.0
    
          }
        
        
        let translate = SKAction.moveByX(0, y: scale*(size.height + kfgHeight), duration: 0.1)
        let flip = SKAction.scaleYTo(scale, duration: 0.1)
        
        runAction(translate)
        runAction(flip)
    }
    
    func breath() {
        
        let breathOut = SKAction.moveByX(0.0, y: -2.0, duration: 1)
        let breathIn = SKAction.moveByX(0.0, y: 2.0 , duration: 1)
        
        let breath = SKAction.sequence([breathOut, breathIn])
        body.runAction(SKAction.repeatActionForever(breath))
        
    }
    
    func stop() {
        body.removeAllActions()
    }
    
}
