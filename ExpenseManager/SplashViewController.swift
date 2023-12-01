//
//  ViewController.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

class SplashViewController: UIViewController
{
    //----------------------------------------------------------------------------------
    //MARK:- vars
    //----------------------------------------------------------------------------------
    
    var logoImageView: UIImageView =
        {
            let obj = UIImageView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.contentMode = .scaleAspectFit
            obj.image = UIImage(named: "logo")
            return obj
        }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView =
        {
            let obj = UIActivityIndicatorView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.startAnimating()
            obj.style = .large
            obj.color = .white
            return obj
        }()
    
    //----------------------------------------------------------------------------------
    //MARK:- life cycle
    //----------------------------------------------------------------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureUI()
        moveToHomeScreen()
    }
    
    //----------------------------------------------------------------------------------
    //MARK:- configureUI
    //----------------------------------------------------------------------------------
    
    func configureUI()
    {
        //properties
        view.backgroundColor = .gray
        
        //subviews
        view.addAllSubviews(logoImageView,
                            activityIndicatorView)
        
        //constraints
        NSLayoutConstraint.activate([
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 60),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func moveToHomeScreen()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
        {
            let vc = HomeViewController()
            Utilities.setAsWindowRoot(viewControllerInsideNavigationController: vc)
        }
    }
}

