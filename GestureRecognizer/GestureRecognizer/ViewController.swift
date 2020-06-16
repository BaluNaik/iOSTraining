//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Balu Naik on 6/15/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tapGesture.numberOfTapsRequired = 2
        label.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapAction() {
        let alertController = UIAlertController(title: "Action", message: "Label Action Test!!!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction);
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    // MARK: - Action
    
    @IBAction func handlePanAction(_ sender: UIPanGestureRecognizer) {
        
         let translation = sender.translation(in: view)
         
         guard let gestureView = sender.view else {
         
         return
         }
         
         gestureView.center = CGPoint(
         x: gestureView.center.x + translation.x,
         y: gestureView.center.y + translation.y)
         
         sender.setTranslation(.zero, in: view)
         
        
        guard sender.state == .ended else {
            
            return
        }
        //Calculates the length of the velocity vector (i.e. the magnitude).
        let velocity = sender.velocity(in: view)
        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y + velocity.y))
        let slideMultiplier = magnitude / 200;
        
        //Decreases the speed if the length is < 200. Otherwise, it increases it.
        let slideFactor = 0.1 * slideMultiplier
        
        //Calculates a final point based on the velocity and the slideFactor.
        var finalPoint = CGPoint(
            x: gestureView.center.x + (velocity.x * slideFactor),
            y: gestureView.center.y + (velocity.y * slideFactor)
        )
        
        //Makes sure the final point is within the view’s bounds
        finalPoint.x = min(max(finalPoint.x,0),view.bounds.width)
        finalPoint.y = min(max(finalPoint.y,0),view.bounds.height)
        
        //Animates the view to the final resting place.
        UIView.animate(withDuration: Double(slideFactor * 2), delay: 0, options: .curveEaseOut, animations: {
            gestureView.center = finalPoint
        }, completion: nil)
    }
    
    
    @IBAction func handelRotateAction(_ sender: UIRotationGestureRecognizer) {
        guard let gestureView = sender.view else {
            
            return
        }
        gestureView.transform = gestureView.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    
    @IBAction func handelPinchAction(_ sender: UIPinchGestureRecognizer) {
        guard let gestureView = sender.view else {
            
            return
        }
        gestureView.transform = gestureView.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
}

