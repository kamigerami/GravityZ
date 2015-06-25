//
//  backGround.swift
//  gravityZ
//
//  Created by Kamjar Gerami on 2015-06-25.
//  Copyright (c) 2015 Kamjar Gerami. All rights reserved.
//

import UIKit
import SpriteKit

class backGround: SKSpriteNode {
   
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(size.width, size.height))
    
    //declare ground picture. If Your putting this image over the top of another image (use a png file).
    var groundImage = SKTexture(imageNamed: "bg_single_1536x3840")
    
    //make your SKActions that will move the image across the screen. this one goes from right to left.
    var moveBackground = SKAction.moveByX(-groundImage.size().width, y: 0, duration: NSTimeInterval(0.01 * groundImage.size().width))
    
    //This resets the image to begin again on the right side.
    var resetBackGround = SKAction.moveByX(groundImage.size().width, y: 0, duration: 0.0)
    
    //this moves the image run forever and put the action in the correct sequence.
    var moveBackgoundForever = SKAction.repeatActionForever(SKAction.sequence([moveBackground, resetBackGround]))
    
    //then run a for loop to make the images line up end to end.
    for var i:CGFloat = 0; i<2 + self.frame.size.width / (groundImage.size().width); ++i {
    var sprite = SKSpriteNode(texture: groundImage)
    sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2)
    sprite.runAction(moveBackgoundForever)
    self.addChild(sprite)
    }
        
//once this is done repeat for a forground or other items but them run at a different speed.

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}