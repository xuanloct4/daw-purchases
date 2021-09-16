//
//  ViewController.swift
//  daw-purchases
//
//  Created by Tran Loc on 08/09/2021.
//  Copyright © 2021 Tran Loc. All rights reserved.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialRipple

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBAction func onTap(_ sender:Any) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let materialCurve = MDCAnimationTimingFunction.deceleration
//        let timingFunction = CAMediaTimingFunction.mdc_function(withType: materialCurve)
//
//        let animation = CABasicAnimation(keyPath:"transform.translation.x")
//        animation.timingFunction = timingFunction
        
        
//        let animation = CABasicAnimation()
//        animation.keyPath = "position.x"
//        animation.fromValue = 77
//        animation.toValue = 455
//        animation.duration = 1
//        animation.fillMode = .forwards
//        animation.isRemovedOnCompletion = false
//        animation.beginTime = CACurrentMediaTime() + 0.5
//        button.layer.add(animation,forKey: "basic")
//        button.layer.position = CGPoint.init(x:250, y: 61)
        
//        let animation = CAKeyframeAnimation()
//        animation.keyPath = "position.x"
//        animation.values = [0, 10, -10, 10, 0]
//        animation.keyTimes = [0, NSNumber(value: 1 / 6.0), NSNumber(value: 3 / 6.0), NSNumber(value: 5 / 6.0), 1]
//        animation.duration = 0.8
//        animation.isAdditive = true
//        button.layer.add(animation, forKey:"shake")
        
        
        
        
//        let boundingRect = CGRect.init(x: -150, y: -150, width: 300, height: 300)
//        let animation = CAKeyframeAnimation()
//        animation.keyPath = "position"
//        animation.path = CGPath.init(ellipseIn: boundingRect, transform:nil)
//        animation.duration = 4
//        animation.isAdditive = true
//        animation.repeatCount = .infinity
//        animation.calculationMode = .paced
//        animation.rotationMode = .rotateAuto
//        button.layer.add(animation, forKey:"orbit")
        
        
        
//        let animation = CABasicAnimation()
//        animation.keyPath = "position.x"
//        animation.fromValue = 10
//        animation.toValue = 320
//        animation.duration = 1
//        animation.timingFunction = CAMediaTimingFunction.init(controlPoints:0.5,0,0.9,0.7)
////        animation.timingFunction = CAMediaTimingFunction.mdc_function(withType: MDCAnimationTimingFunction.deceleration)
//        button.layer.add(animation, forKey:"timing")
//        button.layer.position = CGPoint.init(x:150, y: 50)
        

//        let animation = RBBTweenAnimation()
//        animation.keyPath = "position.y"
//        animation.fromValue = 50
//        animation.toValue = 150
//        animation.duration = 1
//        animation.easing = RBBEasingFunctionEaseOutBounce
//        button.layer.add(animation, forKey:"timing")
        
//        let myButton = UIButton(type: .system)
//        myButton.frame = CGRect.init(x: 10, y: 10, width: 250, height: 100)
//        myButton.backgroundColor = UIColor.cyan
//        myButton.setTitle("Tap Me", for: .normal)
//        let rippleTouchController = MDCRippleTouchController()
//        rippleTouchController.addRipple(to: myButton)
//        view.addSubview(myButton)
       
//
//        self.button.transform = CGAffineTransform(scaleX: 0, y: 0)
//        UIView.animate(withDuration: 3) {
//            self.button.transform = .identity
//        }
        
//        button.transform = CGAffineTransform(scaleX: 0, y: 0)
//        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//            self.button.transform = .identity
//        }, completion: nil)
        
        
//        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
//        borderColorAnimation.fromValue = UIColor.red.cgColor
//        borderColorAnimation.toValue = UIColor.blue.cgColor
//        let borderWidthAnimation = CABasicAnimation(keyPath: "borderWidth")
//        borderWidthAnimation.fromValue = 0.5
//        borderWidthAnimation.toValue = 1.5
//        
//        
//        let zPosition = CABasicAnimation()
//        zPosition.keyPath = "zPosition"
//        zPosition.fromValue = -1
//        zPosition.toValue = 1
//        zPosition.duration = 1.2
//
//        let rotation = CAKeyframeAnimation()
//        rotation.keyPath = "transform.rotation"
//        rotation.values = [ 0, NSNumber(value: 0.14), NSNumber(value: 0)]
//        rotation.duration = 1.2
//        rotation.timingFunctions = [CAMediaTimingFunction.init(name: .easeInEaseOut),
//                                    CAMediaTimingFunction.init(name: .easeInEaseOut)]
//
//        let position = CAKeyframeAnimation()
//        position.keyPath = "position"
//        position.values = [NSValue.init(cgPoint:CGPoint.zero),
//                           NSValue.init(cgPoint:CGPoint.init(x: 110, y: -20)),
//                           NSValue.init(cgPoint:CGPoint.zero)]
//        position.timingFunctions = [CAMediaTimingFunction.init(name: .easeInEaseOut),
//                                    CAMediaTimingFunction.init(name: .easeInEaseOut)]
//        position.isAdditive = true
//        position.duration = 1.2
//
//        let groupAn = CAAnimationGroup()
//        groupAn.duration = 1.2
//        groupAn.beginTime = CACurrentMediaTime() + 0.5
////        groupAn.autoreverses = true
////        groupAn.repeatCount = .infinity
//        groupAn.animations = [zPosition, rotation, position, borderColorAnimation, borderWidthAnimation]
//        
//        
//        button.layer.add(groupAn, forKey:"shuffle")
//        button.layer.zPosition = 1
        
        
        
        
     
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
