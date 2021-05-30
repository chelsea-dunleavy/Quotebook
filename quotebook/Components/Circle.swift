//
//  Circle.swift
//  quotebook
//
//  Created by Shyam Kumar on 5/29/21.
//

import UIKit

class Circle: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var width: CGFloat = 100
    var height: CGFloat = 100
    var color: UIColor = Colors.purple
    
    var shape: CAShapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: width, height: height))
        shape.frame = self.bounds
        shape.path = path.cgPath
        shape.fillColor = color.cgColor
        layer.addSublayer(shape)
    }
    
    func animateCircle() {
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.6
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        layer.add(scaleAnimation, forKey: "scale")
    }
    
    func scaleDown() {
        CATransaction.begin()
        
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.6
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 0
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        CATransaction.setCompletionBlock({[weak self] in
            self?.alpha = 0
        })
        
        layer.add(scaleAnimation, forKey: "scaleDown")
        CATransaction.commit()
    }
    
    func scaleUp() {
        CATransaction.begin()
        
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.6
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        layer.add(scaleAnimation, forKey: "scaleUp")
        
        CATransaction.commit()
        
        UIView.animate(withDuration: 0.6, animations: {
            self.alpha = 1
        })
    }

}
