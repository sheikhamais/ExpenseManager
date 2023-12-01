//
//  SetInitialAmountsVC.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 17/08/2021.
//

import UIKit

protocol SetInitialAmountsVCDelegate: AnyObject
{
    func didSetInitialAmounts()
}

class SetInitialAmountsVC: BaseVC
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    var headingLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "Set Inital Amounts"
            obj.textColor = .white
            obj.font = UIFont.boldSystemFont(ofSize: 22)
            return obj
        }()
    
    lazy var setInitialsTableView: UITableView =
        {
            let obj = UITableView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.separatorStyle = .none
            obj.backgroundColor = .clear
            
            obj.delegate = self
            obj.dataSource = self
            obj.register(SetInitialsTableCell.self, forCellReuseIdentifier: SetInitialsTableCell.identifier)
            
            return obj
        }()
    
    lazy var submitButton: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.addTarget(self, action: #selector(didTapSubmitBtn), for: .touchUpInside)
            obj.setTitle("Submit", for: .normal)
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
    
    //holding data
    private var persons: [PersonsModel]
    private var requestedModifications = [String: String]()
    
    weak var delegate: SetInitialAmountsVCDelegate?
    
    //----------------------------------------------------------------------------------
    //MARK:- init
    //----------------------------------------------------------------------------------
    
    init(persons: [PersonsModel], delegate: SetInitialAmountsVCDelegate?)
    {
        self.persons = persons
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //------------------------------------------------------------
    //MARK:- Life Cycle Methods
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
        //props
        view.backgroundColor = .gray
        addEndEditingGesture()
        
        //subviews
        view.addAllSubviews(headingLabel,
                            setInitialsTableView,
                            submitButton)
        
        //constraints
        NSLayoutConstraint.activate([
            
            headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            
            setInitialsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            setInitialsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            setInitialsTableView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 46),
            setInitialsTableView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -16),
            
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    //----------------------------------------------------------------------------------
    //MARK:- functionality
    //----------------------------------------------------------------------------------
    
    func isAmountValid(amount: String) -> Bool
    {
        let number = Int(amount)
        
        guard number != nil
        else { return false }
        
        return true
    }
    
    //----------------------------------------------------------------------------------
    //MARK:- objc
    //----------------------------------------------------------------------------------
    
    @objc func didTapSubmitBtn()
    {
        for person in persons
        {
            if let requestedModificationAmountForPerson = requestedModifications[person.name]
            {
                guard isAmountValid(amount: requestedModificationAmountForPerson)
                else
                {
                    showAlertView(title: "Error", message: "Please enter a valid amount for \(person.name)")
                    return
                }
                
                person.outstandingAmount = requestedModificationAmountForPerson
            }
        }
        
        UserDefaultsManager.storePersonsDataInUserDefaults(persons: persons)
        delegate?.didSetInitialAmounts()
        dismiss(animated: true)
    }
}

//----------------------------------------------------------------------------------
//MARK:- UITableViewDelegate, UITableViewDataSource
//----------------------------------------------------------------------------------

extension SetInitialAmountsVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: SetInitialsTableCell.identifier, for: indexPath) as! SetInitialsTableCell
        
        cell.delegate = self
        
        let person = persons[indexPath.row]
        cell.nameLabel.text = person.name
        cell.amountTextField.textField.text = person.outstandingAmount
        
        return cell
    }
}

//----------------------------------------------------------------------------------
//MARK:- SectionName
//----------------------------------------------------------------------------------

extension SetInitialAmountsVC: SetInitialsTableCellDelegate
{
    func requestModification(personName: String, modifiedAmount: String)
    {
        requestedModifications[personName] = modifiedAmount
    }
    
//    func didUpdatedAmount(atCell: SetInitialsTableCell, amount: String)
//    {
//        guard let indexPath = setInitialsTableView.indexPath(for: atCell),
//              isAmountValid(amount: amount)
//        else { return }
//
//        let person = persons[indexPath.row]
//
//        person.outstandingAmount = amount
////        if amount.isEmpty
////        {
////            person.outstandingAmount = "0"
////        }
////        else
////        {
////            person.outstandingAmount = amount
////        }
//    }
}
