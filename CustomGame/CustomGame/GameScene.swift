//
//  GameScene.swift
//  CustomGame
//
//  Created by Aoife McManus on 12/9/21.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene, UITextFieldDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var wheel:SKSpriteNode!
    var question:UILabel!
    var answer:UITextField!
    var correctAnswer:String!
    
    func spin(){
        wheel.physicsBody?.angularDamping = 0.45
        wheel.physicsBody?.angularVelocity = .pi * 6
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
            DispatchQueue.main.async{
                self.question.alpha=0
                self.answer.alpha=0
            }
            while true{
                if(self.wheel.physicsBody!.angularVelocity<0.05){
                    break
                }
            }
            DispatchQueue.main.async{
                self.generateQuestions()
            }
        }
    }
    func nextQuestion(){
        UIView.animate(withDuration: 1.5){
            self.question.alpha=0
            self.answer.alpha=0
        }
    }
    func textFieldShouldReturn(_ textField:UITextField)->Bool{
        switch textField{
        case self.answer:
            if(self.answer.text==self.correctAnswer){
                textField.resignFirstResponder()
                nextQuestion()
            }
            else{
                self.answer.text=""
            }
            break
        default:
            break
        }
        return true
    }

    func generateQuestions(){
        //exit(0)
        let questions=["How many residential communities are location on Binghamton University campus?","When was Binghamton University established?", "How many different colleges/schools make up Binghamton University?", "Who was the engineering school at Binghamton University named after?", "What was Binghamton University originally called?"]
        
        let QandA=["How many residential communities are location on Binghamton University campus?":"7","When was Binghamton University established?":"1946", "How many different colleges/schools make up Binghamton University?":"6", "Who was the engineering school at Binghamton University named after?":"Thomas J. Watson","What was Binghamton University originally called?":"Harpur College"]
        let qIndex=Int.random(in: 0..<questions.count)
        
        let q=questions[qIndex]
        correctAnswer=QandA[q]
        question.text=q
        question.textAlignment = .center
        question.font=question.font.withSize(14)
        question.lineBreakMode = .byWordWrapping
        question.numberOfLines = 4
        //answer.isHidden=false
        self.answer.text=""
        answer.alpha=1
        question.alpha=1
        
        //answer.back
    }
    
    override func didMove(to view: SKView) {
        let wheelTexture=SKTexture.init(imageNamed:"Image")
        wheel=SKSpriteNode(texture:wheelTexture)
        
        wheel.position=CGPoint(x: 0, y: 0)
        wheel.size.width=500
        wheel.size.height=500
        self.addChild(wheel)
        
        question=UILabel(frame:CGRect(x: view.frame.midX-140, y: 20, width: 280, height: 100))
        question.textColor = .black
        question.text=""
        
        view.addSubview(question)
        
        answer=UITextField(frame:CGRect(x: view.frame.midX-140, y: view.frame.maxY-90, width: 280, height: 30))
        answer.placeholder="Type answer here"
        answer.font=UIFont.systemFont(ofSize: 14)
        answer.borderStyle=UITextField.BorderStyle.roundedRect
        answer.delegate=self
        answer.alpha=0
        view.addSubview(answer)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: view.frame.midX-35, y:view.frame.midY-35, width: 70, height: 70)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = .black
        view.addSubview(button)
        button.setTitle("Spin!", for: .normal)
        button.addTarget(self, action: #selector(spinWheel(_:)), for: .touchUpInside)
        
        let img=UIImage.init(named:"Image-1")
        let imgView=UIImageView(image:img)
        imgView.frame=CGRect(x: view.frame.midX-10, y: 130, width: 20, height: 20)
        view.addSubview(imgView)
        
        
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
