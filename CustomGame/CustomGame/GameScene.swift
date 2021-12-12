//
//  GameScene.swift
//  CustomGame
//
//  Created by Aoife McManus on 12/9/21.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var wheel:SKSpriteNode!
    /*move code for spinning wheel body here*/
    func spin(){
        wheel.physicsBody?.angularDamping = 0.4
        wheel.physicsBody?.angularVelocity = .pi * 4
        
    }
    @IBAction func spinWheel(_ sender:UIButton){
        DispatchQueue.global().async {
            self.spin()
        }
        while true{
            if(wheel.physicsBody?.isResting==false){
                break
            }
        }
        DispatchQueue.global().async{
            while true{
                if(self.wheel.physicsBody!.angularVelocity<0.01){
                    break
                }
            }
            print("Stopped")
        }
    }
    
    override func didMove(to view: SKView) {
        
        let wheelTexture=SKTexture.init(imageNamed:"Image")
        wheel=SKSpriteNode(texture:wheelTexture)
        
        wheel.position=CGPoint(x: 0, y: 0)
        wheel.size.width=500
        wheel.size.height=500
        self.addChild(wheel)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: view.frame.midX-25, y:view.frame.midY-25, width: 50, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = .black
        view.addSubview(button)
        button.setTitle("Spin!", for: .normal)
        button.addTarget(self, action: #selector(spinWheel(_:)), for: .touchUpInside)
        
        let img=UIImage.init(named:"Image-1")
        view.addSubview(UIImageView(image: img))
        
        
        let wheelBody=SKPhysicsBody(circleOfRadius: max(wheel.size.width / 2, wheel.size.height / 2))
        wheelBody.affectedByGravity=false
        wheelBody.allowsRotation=true
        
        wheel.physicsBody=wheelBody
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
