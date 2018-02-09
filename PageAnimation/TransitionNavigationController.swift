//
//  TransitionNavigationController.swift
//  PageAnimation
//
//  Created by 蜂谷庸正 on 2018/02/09.
//  Copyright © 2018年 Tsunemasa Hachiya. All rights reserved.
//

import UIKit

class TransitionNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func navigationController(_ navigationController: UINavigationController,
                                animationControllerFor operation: UINavigationControllerOperation,
                                from fromVC: UIViewController,
                                to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transitionController = CustomTransitionController()
        
        switch operation {
        case .push:
            transitionController.isForward = true
            return transitionController
        case .pop:
            transitionController.isForward = false
            return transitionController
        default:
            break
        }
        
        return nil
    }

}
