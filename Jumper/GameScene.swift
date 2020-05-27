//
//  GameScene.swift
//  Jumper
//
//  Created by Jeffrey  on 5/26/20.
//  Copyright © 2020 BMCC. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    lazy var analogJoystick: TLAnalogJoystick = {
        let js = TLAnalogJoystick(withDiameter: 300)
        js.baseImage = UIImage(named: "jSubstrate")
        js.position = CGPoint(x: self.frame.size.width * -0.5 + js.radius + 45, y: self.frame.size.height * -0.5 + js.radius + 45)
        js.zPosition = 100
        
        return js

    }()
    
    
    
    let velocityMultiplier: CGFloat = 0.12
    
    var player: SKSpriteNode?
   
    
    override func didMove(to view: SKView) {
       setUpJoyStick()
        
       player = self.childNode(withName: "player") as? SKSpriteNode
        
        
        }

    func setUpJoyStick(){
         addChild(analogJoystick)
        
      
        
          analogJoystick.on(.move) { [unowned self] joystick in
                guard let playerNode = self.childNode(withName: "player") else {
                    return
                }
                
                let pVelocity = joystick.velocity;
                let speed = CGFloat(0.12)
                
                playerNode.position = CGPoint(x: playerNode.position.x + (pVelocity.x * speed), y: playerNode.position.y + (pVelocity.y * speed))
            }
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
         let jumpBtn = self.childNode(withName: "jump")
        
        if let touch = touches.first {
            if jumpBtn!.contains(touch.location(in: self)){
                handleJumpButtonClick()
            }
        }
    }
    
    func handleJumpButtonClick() {
        player?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
    }
    
    override func update(_ currentTime: TimeInterval) {
   
    }
}
