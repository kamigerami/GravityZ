//
//  Obstacles.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-27.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacles: SKSpriteNode {
  
  
  
  var rand_x = CGFloat(arc4random_uniform(35) + 20)
  var rand_y = CGFloat(arc4random_uniform(65) + 30)
  var WALL_WIDTH: CGFloat!
  var WALL_HEIGHT: CGFloat!
  let WALL_COLOR_ONE = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 46.0/255.0, alpha: 1.0)
  let WALL_COLOR_TWO = UIColor(red: 36.0/255.0, green: 36.0/255.0, blue: 36.0/255.0, alpha: 1.0)
  
  
  
  
  
  init() {
    
    
    WALL_WIDTH = rand_x
    WALL_HEIGHT = rand_y
    let size = CGSizeMake(WALL_WIDTH, WALL_HEIGHT)
    super.init(texture: nil, color: WALL_COLOR_TWO, size: size)
    
    loadPhysicsBodyWithSize(size)
    startMoving()
    
    
    
    
    
  }

  
  func loadPhysicsBodyWithSize(size: CGSize) {
    physicsBody = SKPhysicsBody(rectangleOfSize: size)
    physicsBody?.categoryBitMask = GameScene.ColliderType.OBSTACLE.rawValue
    physicsBody?.contactTestBitMask = GameScene.ColliderType.PLAYER.rawValue
    physicsBody?.affectedByGravity = false
  }
 
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func startMoving() {
    let moveLeft = SKAction.moveByX(-kDefaultXToMovePerSecond, y: 0, duration: 1)
    runAction(SKAction.repeatActionForever(moveLeft))
  }
  
  func stopMoving() {
    removeAllActions()
  }
  
  
  
  
  
}
  