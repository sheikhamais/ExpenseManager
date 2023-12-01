//
//  CustomTextFieldView.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//
import UIKit

class CustomTextFieldView: UIView
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    var textField: UITextField =
        {
            let obj = UITextField()
            obj.translatesAutoresizingMaskIntoConstraints = false
            return obj
        }()
    
    //------------------------------------------------------------
    //MARK:- Initializers
    //------------------------------------------------------------
    
    init()
    {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //------------------------------------------------------------
    //MARK:- Configure UI Methods
    //------------------------------------------------------------
    
    func configureUI()
    {
        //prop
        backgroundColor = .white
        
        //subviews
        addAllSubviews(textField)
        
        //constraints
        NSLayoutConstraint.activate([
            
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

