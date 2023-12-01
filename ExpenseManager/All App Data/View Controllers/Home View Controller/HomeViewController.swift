//
//  HomeViewController.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

class HomeViewController: BaseVC
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    var mainHeadingLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "Expense Manager"
            obj.font = UIFont.boldSystemFont(ofSize: 22)
            obj.textColor = .white
            return obj
        }()
    
    lazy var addPersonBtn: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.addTarget(self, action: #selector(didTapAddPerson), for: .touchUpInside)
//            obj.setImage(UIImage(systemName: "plus.circle"), for: .normal)
            obj.setTitle("Add New Person", for: .normal)
            obj.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            obj.tintColor = .white
            return obj
        }()
    
    lazy var setInitialAmountsBtn: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.addTarget(self, action: #selector(didTapSetInitialAmounts), for: .touchUpInside)
            obj.setTitle("Set Initial Amounts", for: .normal)
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
    
    lazy var personsTableView: UITableView =
        {
            let obj = UITableView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.separatorStyle = .none
            obj.backgroundColor = .clear
            
            obj.delegate = self
            obj.dataSource = self
            obj.register(PersonTableCell.self, forCellReuseIdentifier: PersonTableCell.identifier)
            
            return obj
        }()
    
    var copyAddExpenseBtnsStack: UIStackView =
        {
            let obj = UIStackView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.spacing = 8
            obj.distribution = .fillEqually
            return obj
        }()
    
    lazy var copyRecordsButton: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.addTarget(self, action: #selector(didTapCopyRecords), for: .touchUpInside)
            obj.setTitle("Copy Records", for: .normal)
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
    
    lazy var addExpenseButton: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.addTarget(self, action: #selector(didTapAddExpense), for: .touchUpInside)
            obj.setTitle("Add Expense", for: .normal)
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
    
    //variables for holding data
    var persons: [PersonsModel] = UserDefaultsManager.retrievePersonsDataFromUserDefaults() ?? [PersonsModel]()
    
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
        //properties
        view.backgroundColor = .gray
        
        //subviews
        view.addAllSubviews(mainHeadingLabel,
                            addPersonBtn,
                            setInitialAmountsBtn,
                            personsTableView,
                            copyAddExpenseBtnsStack)
        
        copyAddExpenseBtnsStack.addAllArrangedSubviews(copyRecordsButton,
                                                       addExpenseButton)
        
        //constraints
        let viewSafeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            mainHeadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainHeadingLabel.topAnchor.constraint(equalTo: viewSafeArea.topAnchor, constant: 24),
            
//            addPersonBtn.widthAnchor.constraint(equalToConstant: 44),
            addPersonBtn.heightAnchor.constraint(equalToConstant: 44),
            addPersonBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            addPersonBtn.centerYAnchor.constraint(equalTo: mainHeadingLabel.centerYAnchor),
            
            setInitialAmountsBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setInitialAmountsBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            setInitialAmountsBtn.topAnchor.constraint(equalTo: mainHeadingLabel.bottomAnchor, constant: 20),
            setInitialAmountsBtn.heightAnchor.constraint(equalToConstant: 36),
            
            personsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            personsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            personsTableView.topAnchor.constraint(equalTo: setInitialAmountsBtn.bottomAnchor, constant: 20),
            personsTableView.bottomAnchor.constraint(equalTo: addExpenseButton.topAnchor, constant: -20),
            
//            copyAddExpenseBtnsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            copyAddExpenseBtnsStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            copyAddExpenseBtnsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            copyAddExpenseBtnsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            copyAddExpenseBtnsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28),
            copyAddExpenseBtnsStack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    //------------------------------------------------------------
    //MARK:- Functionality
    //------------------------------------------------------------
    
    func reloadRecords()
    {
        persons = UserDefaultsManager.retrievePersonsDataFromUserDefaults() ?? [PersonsModel]()
        personsTableView.reloadData()
    }
    
    func getPersonsCopyableString() -> String
    {
        var personsString = ""
        var longestNameStringCount = 0
        
        for person in persons
        {
            if person.name.count > longestNameStringCount
            { longestNameStringCount = person.name.count }
        }
        
        for person in persons
        {
            let spaceString = String(repeating: " ", count: longestNameStringCount - person.name.count + 6 )
            personsString.append("\(person.name):\(spaceString)\(person.outstandingAmount)\n")
        }
        
        return personsString
    }
    
    //------------------------------------------------------------
    //MARK:- @objc Methods
    //------------------------------------------------------------
    
    @objc func didTapAddPerson()
    {
        let vc = AddNewMemberViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapAddExpense()
    {
        let vc = AddExpenseViewController(allPersons: persons)
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapSetInitialAmounts()
    {
        let vc = SetInitialAmountsVC(persons: persons, delegate: self)
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapCopyRecords()
    {
        UIPasteboard.general.string = getPersonsCopyableString()
        showToast(withMessage: "Copied to clipboard")
    }
}

//----------------------------------------------------------------------------------
//MARK:- UITableViewDelegate, UITableViewDataSource
//----------------------------------------------------------------------------------

extension HomeViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableCell.identifier, for: indexPath) as! PersonTableCell
        
        let personModel = persons[indexPath.row]
        cell.nameLabel.text = personModel.name
        cell.outstandingAmountLabel.text = personModel.outstandingAmount
        
        return cell
    }
}

//----------------------------------------------------------------------------------
//MARK:- SectionName
//----------------------------------------------------------------------------------

extension HomeViewController: AddNewMemberViewControllerDelgate
{
    func didAddedPerson()
    { reloadRecords() }
}

//----------------------------------------------------------------------------------
//MARK:- SectionName
//----------------------------------------------------------------------------------

extension HomeViewController: AddExpenseViewControllerDelegate
{
    func didUpdatedRecords()
    { reloadRecords() }
}

//----------------------------------------------------------------------------------
//MARK:- SectionName
//----------------------------------------------------------------------------------

extension HomeViewController: SetInitialAmountsVCDelegate
{
    func didSetInitialAmounts()
    { reloadRecords() }
}
