//
//  GameScene.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-19.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  let maxLevels = 3
  let motionManager: CMMotionManager = CMMotionManager()
  var accelerationX: CGFloat = 0.5
  
  var isStarted = false
  var isGameOver = false
  var contactWithGround = false
  
  
  var World: SKNode!
  var Camera: SKNode!
  
  var bg: backGround!
  
  var player: Player!
  var PLAYER: UInt32!
  
  
  var fg: Ground!
  var GROUND: UInt32!
  
  let starField = SKEmitterNode(fileNamed: "StarField")
  
  var obstacles: Obstacles!
  var obstacleGenerator: ObstacleGenerator!
  
  
  
  enum ColliderType:UInt32 {
    case PLAYER = 1
    case GROUND = 2
    case OBSTACLE = 4
  }
  
 
  
  
  override func didMoveToView(view: SKView) {
    // add BG
    
    // create and add blue-fish.png image to screen
    
    
    addPhysicsWorld()
    addMovingBackground()
    addMovingGround()
    addPlayer()
    doSwipes()
    addObstacleGenerator()
    
    
  }
  /// swipe gestures
  
  
  func doSwipes() {
    
    /* Setup your scene here */
    
    
    
    let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
    swipeUp.direction = .Up
    self.view!.addGestureRecognizer(swipeUp)
    
    
    let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedDown:"))
    swipeDown.direction = .Down
    self.view!.addGestureRecognizer(swipeDown)
    
    
    
  }
  
  func gravitySwitch() {
    
    if player.isNotUpsideDown {
      self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
      player.flip()
      
    } else {
      player.flip()
      self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 9.8)
    }
    
    
    
  }
  
  func swipedUp(sender:UISwipeGestureRecognizer){
    gravitySwitch()
  }
  
  func swipedDown(sender:UISwipeGestureRecognizer){
    gravitySwitch()
  }
  
  //
  
  
  func addStarField() {
    
    
    // starField
    
    starField.position = CGPointMake(size.width/2,size.height)
    starField.zPosition = 5
    addChild(starField)
    
    
  }
  
  func removeStarField() {
      starField.removeAllActions()
    
  }
  func addPhysicsWorld() {
    
    
    // world and camera
    
    self.physicsWorld.contactDelegate = self
    // self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    self.World = SKNode()
    self.World.name = "World"
    addChild(World)
    self.Camera = SKNode()
    self.Camera.name = "Camera"
    self.World.addChild(Camera)
    
    // background
    
    //self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
    // add the rest of foreground / background here //
    self.backgroundColor = UIColor.grayColor()
    
    
    
    
  }
  
  func addPlayer() {
    // Player
    
    // instantiating the Player with the size arguments
    player = Player(size: CGSizeMake(frame.size.height, frame.size.height))
    
    player.zPosition = 1
    
    player.position = CGPointMake(frame.size.width/2, fg.position.y + fg.frame.size.height/2 + player.frame.size.height/2)
    
    
    addChild(player)
    
    player.breath()
    
    
    
  }
  
  
  
  func addObstacleGenerator() {
    obstacleGenerator = ObstacleGenerator(color: UIColor.clearColor(), size: view!.frame.size)
    obstacleGenerator.position = view!.center
    addChild(obstacleGenerator)
  }
  
  func addMovingGround() {
    fg = Ground(size: CGSizeMake(view!.frame.width, kfgHeight))
    fg.position = CGPointMake(0, view!.frame.size.height/2)
    
    addChild(fg)
  }
  
  func addMovingBackground() {
    bg = backGround(size: CGSizeMake(view!.frame.width, kfgHeight))
    bg.position = CGPointMake(0, -kfgHeight * 2 )
    bg.zPosition = -15
    addChild(bg)
    
    
  }
  func centerOnNode(node: SKNode) {
    
    let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)
    
    node.parent!.runAction(SKAction.moveTo(CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y), duration: 1))
    
  }
  
  override func didFinishUpdate() {
    
    Camera.position = CGPoint(x: player.position.x, y: player.position.y)
    
    self.centerOnNode(Camera!)
    
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    
    
    
    if (contact.bodyA.categoryBitMask == ColliderType.PLAYER.rawValue &&
      contact.bodyB.categoryBitMask == ColliderType.OBSTACLE.rawValue) {
        
        // collision between player and obstacle
        // MARK: - SKPhysicsContactDelegate
        if !isGameOver {
          gameOver()
          player.facial_sad()
        }
        
        
    }
    
    if (contact.bodyA.categoryBitMask == ColliderType.PLAYER.rawValue && contact.bodyB.categoryBitMask == ColliderType.GROUND.rawValue) {
      // player is touching the ground
      
    }
    
  }
  
  
  
  func start() {
    isStarted = true
    player.startRunning()
    player.facial_mad()
    addStarField()
    fg.start()
    obstacleGenerator.startGeneratingWallsEvery(1)
    
    
  }
  func gameOver() {
    isGameOver = true
    
    // stop everything
    player.fall()
    obstacleGenerator.stopWalls()
    fg.stop()
    player.stop()
    removeStarField()
    
    
    // create game over label
    let gameOverLabel = SKLabelNode(text: "Game Over!")
    gameOverLabel.fontColor = UIColor.whiteColor()
    gameOverLabel.fontName = "Chalkduster"
    gameOverLabel.position.x = view!.center.x
    gameOverLabel.position.y = view!.center.y + 40
    gameOverLabel.fontSize = 22.0
    gameOverLabel.zPosition = 10
    addChild(gameOverLabel)
    gameOverLabel.runAction(blinkAnimation())
    
    
    // save current points label value
    /*  let pointsLabel = childNodeWithName("pointsLabel") as! MLPointsLabel
    let highscoreLabel = childNodeWithName("highscoreLabel") as! MLPointsLabel
    
    if highscoreLabel.number < pointsLabel.number {
    highscoreLabel.setTo(pointsLabel.number)
    
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setInteger(highscoreLabel.number, forKey: "highscore")
    } */
  }
  
  func restart() {
    obstacleGenerator.stopGenerating()
    
    let newScene = GameScene(size: view!.bounds.size)
    newScene.scaleMode = .AspectFill
    
    view!.presentScene(newScene)
  }
  
  // MARK: - Animations
  func blinkAnimation() -> SKAction {
    let duration = 0.4
    let fadeOut = SKAction.fadeAlphaTo(0.0, duration: duration)
    let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
    let blink = SKAction.sequence([fadeOut, fadeIn])
    return SKAction.repeatActionForever(blink)
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    if isGameOver {
        restart()
    } else if !isStarted {
      start()
    }
    
  }
  
  
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    if isStarted {
      if player.position.y <= 230 && player.position.y >= 145 {
        if !player.isNotUpsideDown {
          player.jump()
        } else {
          player.gravityJump()
        }
      }
      
    }
    
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
    
    if obstacleGenerator.wallTrackers.count > 0 {
      
      let wall = obstacleGenerator.wallTrackers[0] as Obstacles
      
      let wallLocation = obstacleGenerator.convertPoint(wall.position, toNode: self)
      if wallLocation.x < player.position.x {
        obstacleGenerator.wallTrackers.removeAtIndex(0)
        
        //  let pointsLabel = childNodeWithName("pointsLabel") as! PointsLabel
        //  pointsLabel.increment()
        
      }
    }
    
    
  }
  
  
}
