//
//  AddNewMemberViewController.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

protocol AddNewMemberViewControllerDelgate: AnyObject
{
    func didAddedPerson()
}

class AddNewMemberViewController: BaseVC
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    var headingLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "Add New Member"
            obj.textColor = .white
            obj.font = UIFont.boldSystemFont(ofSize: 22)
            return obj
        }()
    
    var nameTextFieldView: CustomTextFieldView =
        {
            let obj = CustomTextFieldView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.backgroundColor = .white
            obj.textField.placeholder = "Enter Name.."
            obj.addCornerRadius(8)
            obj.textField.font = UIFont.systemFont(ofSize: 14)
            obj.addShadowToView(shadowColor: .black,
                                offset: CGSize(width: 4, height: 4),
                                shadowRadius: 10,
                                shadowOpacity: 0.6)
            return obj
        }()
    
    lazy var addMemberButton: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.addTarget(self, action: #selector(didTapAddMember), for: .touchUpInside)
            obj.setTitle("Add Member", for: .normal)
            obj.setTitleColor(.black, for: .normal)
            obj.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            obj.addCornerRadius(8)
            obj.backgroundColor = .white
            obj.addShadowToView(shadowColor: .black,
                                offset: CGSize(width: 4, height: 4),
                                shadowRadius: 10,
                                shadowOpacity: 0.6)
            return obj
        }()
    
    //var holding data
    weak var delegate: AddNewMemberViewControllerDelgate?
    
    //------------------------------------------------------------
    //MARK:- Initializers
    //------------------------------------------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureUI()
    }
    
    //------------------------------------------------------------
    //MARK:- Configure UI Methods
    //------------------------------------------------------------
    
    func configureUI()
    {
        //properties
        addEndEditingGesture()
        view.backgroundColor = .gray
        
        //subviews
        view.addAllSubviews(headingLabel,
                            nameTextFieldView,
                            addMemberButton)
        
        //constraints
        NSLayoutConstraint.activate([
            
            headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 26),
            
            nameTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameTextFieldView.heightAnchor.constraint(equalToConstant: 44),
            
            addMemberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addMemberButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            addMemberButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28),
            addMemberButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    //------------------------------------------------------------
    //MARK:- Functionality
    //------------------------------------------------------------
    
    //------------------------------------------------------------
    //MARK:- @objc Methods
    //------------------------------------------------------------
    
    @objc func didTapAddMember()
    {
        let name = nameTextFieldView.textField.text!.trim
        
        guard name.isNotEmpty
        else
        {
            showAlertView(title: "Error", message: "Name cannot be empty!")
            return
        }
        
        let person = PersonsModel(name: name, outstandingAmount: "0")
        guard UserDefaultsManager.addNewPersonsInList(person: person)
        else
        {
            showAlertView(title: "Error", message: "Unable to add user!")
            return
        }
        
        delegate?.didAddedPerson()
        self.dismiss(animated: true)
    }
}

