//
//  Ext_UIViewController.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

extension UIViewController
{
    func addChildViaConstraints(child: UIViewController, toView: UIView)
    {
        addChild(child)
        toView.addSubview(child.view)
        child.didMove(toParent: self)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        guard let childVcView = child.view
        else { return }
        
        NSLayoutConstraint.activate([
            childVcView.leadingAnchor.constraint(equalTo: toView.leadingAnchor),
            childVcView.trailingAnchor.constraint(equalTo: toView.trailingAnchor),
            childVcView.topAnchor.constraint(equalTo: toView.topAnchor),
            childVcView.bottomAnchor.constraint(equalTo: toView.bottomAnchor)
        ])
    }
    
    func removeSelfFromParent() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func removeChild(viewController: UIViewController)
    {
        guard viewController.parent != nil else {
            return
        }
        
        viewController.willMove(toParent: nil)
        viewController.removeFromParent()
        viewController.view.removeFromSuperview()
    }
    
    func addEndEditingGesture()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        gesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(gesture)
    }
    @objc func handleViewTap() { self.view.endEditing(true) }
    

    func navigate(to vc: AnyClass) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        for viewcontroller in viewControllers {
            if viewcontroller.isKind(of: vc){
                self.navigationController!.popToViewController(viewcontroller, animated: true)
                
            }
        }
    }
    
    func showAlertView(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showToast(withMessage message: String)
    {
        let containerView: UIView =
            {
                let obj = UIView()
                obj.translatesAutoresizingMaskIntoConstraints = false
                obj.backgroundColor = .darkGray
                obj.addCornerRadius(8)
                return obj
            }()
        
        let label: UILabel =
            {
                let obj = UILabel()
                obj.translatesAutoresizingMaskIntoConstraints = false
                obj.text = message
                obj.textColor = .white
                obj.textAlignment = .center
                obj.font = UIFont.systemFont(ofSize: 12)
                obj.alpha = 0
                return obj
            }()
        
        self.view.addSubview(containerView)
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            containerView.heightAnchor.constraint(equalToConstant: 32),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: containerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25)
        {
            label.alpha = 1
            self.view.layoutIfNeeded()
        }
        completion:
        { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                containerView.removeFromSuperview()
            }
        }
    }
}
