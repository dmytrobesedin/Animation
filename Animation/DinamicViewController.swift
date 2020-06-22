//
//  DinamicViewController.swift
//  Animation
//
//  Created by Дмитрий Беседин on 6/22/20.
//  Copyright © 2020 DmytroBesedin. All rights reserved.
//

import UIKit

class DinamicViewController: UIViewController {

        var squareViews = [UIDynamicItem]()
        var animator = UIDynamicAnimator()
        

        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
        }
        override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(true)
               // create view
               let numberOfViews = 2
               squareViews.reserveCapacity(numberOfViews)
               var color = [UIColor.red,UIColor.blue]
               var currentCenterPoint: CGPoint = view.center
               let eachViewSize = CGSize(width: 50, height: 50)
               
               for counter in 0..<numberOfViews{
                   let newView = UIView(frame: CGRect(x: 0, y: 0, width: eachViewSize.width, height: eachViewSize.height))
                   newView.backgroundColor = color[counter]
                   newView.center = currentCenterPoint // create 2 UiView at self.view
                   currentCenterPoint.y += eachViewSize.height + 10 // 1 view > 2 view at 10 pt on Y
                   self.view.addSubview(newView)
                   squareViews.append(newView)
               }
                animator = UIDynamicAnimator(referenceView: view)
                
                // create gravity
                let gravity = UIGravityBehavior(items: squareViews)
                animator.addBehavior(gravity)
                
            // realize push
                let collision = UICollisionBehavior(items: squareViews)
            collision.translatesReferenceBoundsIntoBoundary = true // true - nignyanya granitsa ne budet propuskat' obekt
                collision.addBoundary(withIdentifier: "bottomBoundary" as NSCopying, from: CGPoint(x: 0, y: view.bounds.size.height - 100), to: CGPoint(x: view.bounds.size.width , y: view.bounds.size.height -  100 ))
                
                collision.collisionDelegate = self
                animator.addBehavior(collision)
        }

        
    }
    extension DinamicViewController: UICollisionBehaviorDelegate {
     
        func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
            let indetifier = identifier as? String
            let kBottomBoundaty = "bottomBoundary"
            if indetifier == kBottomBoundaty{
                UIView.animate(withDuration: 1.0, animations: {
                    let view  = item as? UIView
                    view?.backgroundColor  = UIColor.magenta
                    view?.alpha = 0.0
                    view?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                }, completion: { (finished) in
                    let view = item as? UIView
                    behavior.removeItem(item)
                    view?.removeFromSuperview()
                })
                UIView.animate(withDuration: 1.0, animations: {
                   
                })
            }
            
        }

}
