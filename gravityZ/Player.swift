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
  
  var left_eyeBrows: SKSpriteNode!
  var right_eyeBrows: SKSpriteNode!
  
  var leftEye: SKSpriteNode!
  var rightEye: SKSpriteNode!
  
  var pupil: SKSpriteNode!
  
  var mouth: SKSpriteNode!
  
  var isNotUpsideDown = false
  var gravityOn = false
  
  
  var World = GameScene()
  
  
  
  init(size: CGSize) {
    
    // the frame of which the rest of the body is a part of
    
    super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(size.height/8, size.height/6))
    
    load_Appearance()
    addPlayerPhysicsBody(size)
    
    
  }
  
  func load_Appearance() {
    
    // The body
    
    body = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height - 4))
    body.position = CGPointMake(0, 2)
    
    addChild(body)
    
    // the facial features
    
    let skinColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 153.0/255.0, alpha: 1.0)
    
    let face = SKSpriteNode(color: skinColor, size: CGSizeMake(self.frame.size.width, self.frame.size.height/3))
    face.position = CGPointMake(0, 6)
    
    body.addChild(face)
    
    
    let banDana = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(body.size.width, 4))
    banDana.position = CGPointMake(0, face.size.height + 1)
    
    body.addChild(banDana)
    
    let banDana_tied = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(8, 2))
    banDana_tied.position = CGPointMake(-banDana.size.width/2 - 5, 0)
    
    let angle = 15 * kDegreesToRadians
    
    let banDana_rotate = SKAction.rotateByAngle(angle, duration: 0.5)
    let banDana_rotate_reverse = SKAction.rotateByAngle(-angle, duration: 0.5)
    
    var banDana_sequence = SKAction.sequence([banDana_rotate, banDana_rotate_reverse])
    banDana_tied.runAction(SKAction.repeatActionForever(banDana_sequence))
    
    banDana.addChild(banDana_tied)
    // eyes
    
    let eyeColor = UIColor.whiteColor()
    leftEye = SKSpriteNode(color: eyeColor, size: CGSizeMake(6, 6))
    rightEye = leftEye.copy() as! SKSpriteNode
    
    pupil = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(3,3))
    pupil.position = CGPointMake(2, 0)
    
    leftEye.addChild(pupil)
    rightEye.addChild(pupil.copy() as! SKSpriteNode)
    
    leftEye.position = CGPointMake(4, 0)
    
    face.addChild(leftEye)
    
    rightEye.position = CGPointMake(22, 0)
    
    face.addChild(rightEye)
    
    // eyebrows
    
    left_eyeBrows = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(10, 2))
    left_eyeBrows.position = CGPointMake(0, leftEye.size.height/2 + 2)
    
    right_eyeBrows = left_eyeBrows.copy() as! SKSpriteNode
    right_eyeBrows.position = CGPointMake(2, rightEye.size.height/2 + 2)
    
    leftEye.addChild(left_eyeBrows)
    rightEye.addChild(right_eyeBrows)
    
    
    // mouth
    
    mouth = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(10, 2))
    mouth.position = CGPointMake(left_eyeBrows.position.x + right_eyeBrows.position.x + 10, -7)
    
    face.addChild(mouth)
    
    
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
  
  func facial_sad() {
    left_eyeBrows.size = CGSizeMake(8, 2)
    right_eyeBrows.size = CGSizeMake(8, 2)
    left_eyeBrows.zRotation = CGFloat(M_PI/4)
    right_eyeBrows.zRotation = CGFloat(100)
    left_eyeBrows.position = CGPointMake(0, leftEye.size.height/2 + 1)
    right_eyeBrows.position = CGPointMake(2, rightEye.size.height/2 + 1)
    
  }
  
  
  func facial_mad() {
    let angle = 35 * kDegreesToRadians
    left_eyeBrows.size = CGSizeMake(7, 2)
    right_eyeBrows.size = CGSizeMake(7, 2)
    left_eyeBrows.zRotation = CGFloat(-angle)
    right_eyeBrows.zRotation = CGFloat(angle)
    left_eyeBrows.position = CGPointMake(4, leftEye.size.height/2 + 2)
    right_eyeBrows.position = CGPointMake(-2, rightEye.size.height/2 + 2)
    
    
  }
  
  
  func addPlayerPhysicsBody(CGSize) {
    
    // set physics
    
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.dynamic = true
    physicsBody?.allowsRotation = false
    
    physicsBody!.categoryBitMask = GameScene.ColliderType.PLAYER.rawValue
    
    physicsBody!.contactTestBitMask = GameScene.ColliderType.GROUND.rawValue | GameScene.ColliderType.OBSTACLE.rawValue
    
    physicsBody!.collisionBitMask = GameScene.ColliderType.OBSTACLE.rawValue | GameScene.ColliderType.GROUND.rawValue
    
    
    
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
  
  func fall() {
    physicsBody?.affectedByGravity = true
    physicsBody?.applyImpulse(CGVectorMake(-5, 30))
    
    let rotateBack = SKAction.rotateByAngle(CGFloat(M_PI) / 2, duration: 0.4)
    runAction(rotateBack)
  }
  
  func breath() {
    
    let breathOut = SKAction.moveByX(0.0, y: -2.0, duration: 1)
    let breathIn = SKAction.moveByX(0.0, y: 2.0 , duration: 1)
    
    let breath = SKAction.sequence([breathOut, breathIn])
    body.runAction(SKAction.repeatActionForever(breath))
    
  }
  
  func stop() {
    body.removeAllActions()
    left_leg.removeAllActions()
    right_leg.removeAllActions()
  }
  
}
