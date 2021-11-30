//
//  ViewController.swift
//  CustomGame
//
//  Created by Aoife McManus on 11/29/21.
//

import UIKit

class ViewController: UIViewController {
    func makeWheel(){
        var path:UIBezierPath!
        path=UIBezierPath()
        
        let radius = 100.0
        path.move(to:CGPoint(x: 0, y: radius))
        
        /*Add circle plot*/
        for i in stride(from:0.0, to:400.0, by:0.01){
            var x:Double!
            var y:Double!
            if(i<100){
                x=i
                y=sqrt(pow(radius, 2)-pow(x, 2))
                
            }
            else if(i<200){
                let r=i.truncatingRemainder(dividingBy: radius)
                x=radius-r
                y=sqrt(pow(radius, 2)-pow(x, 2)) * -1
                
            }
            else if(i<300){
                let r=i.truncatingRemainder(dividingBy: radius)
                x = r * -1
                y=sqrt(pow(radius, 2)-pow(x, 2)) * -1
                print(x!, y!)
                 
            }
            else{
                let r=i.truncatingRemainder(dividingBy: radius)
                x = (radius * -1)+r
                y = sqrt(pow(radius, 2)-pow(x, 2))
            }
            path.addLine(to:CGPoint(x:x, y:y))
        }
        /*Split up circle*/
        
        path.move(to:CGPoint(x:0, y:radius * -1))
        path.addLine(to:CGPoint(x:0, y:radius))
        
        path.move(to:CGPoint(x:radius * -1, y:0))
        path.addLine(to:CGPoint(x:radius, y:0))
        
        let halfPoint=sqrt(pow(radius,2)/2)
        
        path.move(to:CGPoint(x: halfPoint * -1, y: halfPoint))
        path.addLine(to:CGPoint(x: halfPoint, y: halfPoint * -1))
        
        path.move(to:CGPoint(x: halfPoint * -1, y: halfPoint * -1))
        path.addLine(to:CGPoint(x: halfPoint, y: halfPoint))
        
        let shapeLayer = CAShapeLayer()
        
        let width=CGFloat(200);
        let height=CGFloat(200);
        let x=self.view.frame.midX;
        let y=self.view.frame.midY;
        let rect=CGRect(x: x, y: y, width: width, height: height)
        
        shapeLayer.frame = rect;
        
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        shapeLayer.lineWidth = 2
        
        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 5;
        shapeLayer.add(animation, forKey: "MyAnimation")
    }
    
    //weak var shapeLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeWheel()
        
    }


}

