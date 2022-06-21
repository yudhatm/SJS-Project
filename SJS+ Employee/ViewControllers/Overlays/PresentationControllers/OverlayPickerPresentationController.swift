//
//  OverlayTableViewPresentationController.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 29/04/22.
//

import Foundation
import UIKit

class OverlayPickerPresentationController: UIPresentationController {
    let blurEffectView: UIVisualEffectView!
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
//        if itemCount > 15 {
//            return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.25),
//                   size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height * 0.75))
//        } else {
//            return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.5),
//                   size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height * 0.5))
//        }
        
        return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * ViewSize.halfScreen),
                      size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height * ViewSize.halfScreen))
    }
    
    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0.7
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 22)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    @objc func dismissController(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}

