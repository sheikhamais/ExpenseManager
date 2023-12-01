//
//  BaseVC.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

class BaseVC: UIViewController
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    //------------------------------------------------------------
    //MARK:- Life Cycle Methods
    //------------------------------------------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //------------------------------------------------------------
    //MARK:- Configure UI Methods
    //------------------------------------------------------------
    
    //------------------------------------------------------------
    //MARK:- Functionality
    //------------------------------------------------------------
    
    //------------------------------------------------------------
    //MARK:- @objc Methods
    //------------------------------------------------------------
    
}
