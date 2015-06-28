//
//  ObstacleGenerator.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-27.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import Foundation
import SpriteKit

class ObstacleGenerator: SKSpriteNode {
  
  
  var generationTimer: NSTimer?
  var walls = [Obstacles]()
  var wallTrackers = [Obstacles]()
  
  func startGeneratingWallsEvery(seconds: NSTimeInterval) {
    generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
    
  }
  
  func stopGenerating() {
    generationTimer?.invalidate()
  }
  
  func generateWall() {
    var scale: CGFloat
    let rand = arc4random_uniform(2)
    if rand == 0 {
      scale = -1.0
    } else {
      scale = 1.0
    }
    
    var wall = Obstacles()

    let rand_xy = CGFloat(arc4random_uniform(50) + arc4random_uniform(25))
    wall.position.x = size.width/2 + wall.size.width/2 + rand_xy
    wall.position.y = scale * (kfgHeight/2 + wall.size.height/2)
    walls.append(wall)
    wallTrackers.append(wall)
    addChild(wall)
  }
  
  func stopWalls() {
    stopGenerating()
    for wall in walls {
      wall.stopMoving()
    }
  }
  
}
