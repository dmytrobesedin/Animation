//
//  ViewController.swift
//  Animation
//
//  Created by Дмитрий Беседин on 6/22/20.
//  Copyright © 2020 DmytroBesedin. All rights reserved.
//

import UIKit

   class ViewController: UIViewController {
    var squareViews = UIView()
    var animator = UIDynamicAnimator()
    var pushBehavior = UIPushBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
         createGesterRecorgnizer()
               createSquerView()
               createAnimationAndBehaviors()
    }
    // Method
       func createSquerView()  {
           squareViews = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
           squareViews.backgroundColor = UIColor.green
           squareViews.center = view.center
           view.addSubview(squareViews)
       }
       func createGesterRecorgnizer()  {
           let tapGesterRecorgnizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           view.addGestureRecognizer(tapGesterRecorgnizer)
       }
       
       // stolknovenie i tolchok view
       
       func createAnimationAndBehaviors()  {
           animator = UIDynamicAnimator(referenceView: view)
           // create stolknovenie
           let collision = UICollisionBehavior(items: [squareViews])
           collision.translatesReferenceBoundsIntoBoundary = true
           pushBehavior = UIPushBehavior(items: [squareViews], mode: .continuous)
           animator.addBehavior(collision)
           animator.addBehavior(pushBehavior)
       }
       @objc func handleTap(paramTap: UITapGestureRecognizer)  {
           // poluchaem view
           let tapPoint: CGPoint = paramTap.location(in: view)
           let squareViewCenterPoint: CGPoint = squareViews.center
           // arc tangens 2((p1.x -p2.x).(p1.y - p2.y)
           let deltaX: CGFloat = tapPoint.x - squareViewCenterPoint.x
           let deltaY: CGFloat = tapPoint.y - squareViewCenterPoint.y
           let angel: CGFloat = atan2(deltaY,deltaX)
           pushBehavior.angle = angel
           
           let  distanceBettwenPints: CGFloat = sqrt(pow(tapPoint.x - squareViewCenterPoint.x, 2.0) + pow(tapPoint.y - squareViewCenterPoint.y, 2.0))
           pushBehavior.magnitude = distanceBettwenPints / 200
           
       }

}

