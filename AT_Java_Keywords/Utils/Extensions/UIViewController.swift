//
//  UIViewController.swift
//  AT_Java_Keywords
//
//  Created by Carlos Henrique on 11/08/19.
//  Copyright © 2019 Carlos Henrique. All rights reserved.
//

import UIKit

var loadingContainer : UIView?
 
extension UIViewController {
    func showSpinner(onView : UIView) {
        
        let container: UIView = UIView()
        container.frame = onView.frame
        container.center = onView.center
        container.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 160, height: 110)
        loadingView.center = onView.center
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let loadingLabel: UILabel = UILabel()
        loadingLabel.font = UIFont.words.button.font
        loadingLabel.text = "Loading..."
        loadingLabel.textAlignment = .center
        loadingLabel.textColor = .white
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        loadingLabel.center = CGPoint(x: loadingView.frame.size.width / 2,
                                      y: loadingView.frame.size.height * 0.75)
        
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.color = .white
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,
                            y: loadingView.frame.size.height * 0.35)
        
        
        DispatchQueue.main.async {
            
            loadingView.addSubview(activityIndicator)
            loadingView.addSubview(loadingLabel)
            container.addSubview(loadingView)
            onView.addSubview(container)
            activityIndicator.startAnimating()
        }
        
        loadingContainer = container
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            loadingContainer?.removeFromSuperview()
            loadingContainer = nil
        }
    }
    
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
