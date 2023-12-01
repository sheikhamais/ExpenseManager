//
//  RemainingExpenseAjustmentVC.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 17/08/2021.
//

import UIKit

protocol RemainingExpenseAjustmentVCDelegate: AnyObject
{
    func didSelectedAdjustedPerson(person: PersonsModel)
}

class RemainingExpenseAjustmentVC: BaseVC
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    var headingLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "Adjust Remaining"
            obj.textColor = .white
            obj.font = UIFont.boldSystemFont(ofSize: 22)
            return obj
        }()
    
    lazy var dismissButton: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
            obj.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            obj.tintColor = .white
            return obj
        }()

    lazy var detailsLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "Total sum of \"\(remainingAmount)\" from bill is due, please select a hero to adjust from!"
            obj.textColor = .white
            obj.font = UIFont.boldSystemFont(ofSize: 15)
            obj.numberOfLines = 0
            return obj
        }()
    
    lazy var adjustablePersonsTableView: UITableView =
        {
            let obj = UITableView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.separatorStyle = .none
            obj.backgroundColor = .clear
            
            obj.delegate = self
            obj.dataSource = self
            obj.register(AjustablePersonCell.self, forCellReuseIdentifier: AjustablePersonCell.identifier)
            
            return obj
        }()
    
    lazy var adjustInPersonButton: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.addTarget(self, action: #selector(didTapAjustBtn), for: .touchUpInside)
            obj.setTitle("Ajust", for: .normal)
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
    private var remainingAmount: Int
    private var adjustedPerson: PersonsModel?
    
    weak var delegate: RemainingExpenseAjustmentVCDelegate?
    
    //----------------------------------------------------------------------------------
    //MARK:- init
    //----------------------------------------------------------------------------------
    
    init(persons: [PersonsModel], remainingAmount: Int, delegate: RemainingExpenseAjustmentVCDelegate?)
    {
        self.persons = persons
        self.remainingAmount = remainingAmount
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
        
        //subviews
        view.addAllSubviews(dismissButton,
                            headingLabel,
                            detailsLabel,
                            adjustablePersonsTableView,
                            adjustInPersonButton)
        
        //constraints
        NSLayoutConstraint.activate([
            
            dismissButton.heightAnchor.constraint(equalToConstant: 44),
            dismissButton.widthAnchor.constraint(equalToConstant: 44),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            dismissButton.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor),
            
//            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            detailsLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 8),
            
            adjustablePersonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            adjustablePersonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            adjustablePersonsTableView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 12),
            adjustablePersonsTableView.bottomAnchor.constraint(equalTo: adjustInPersonButton.topAnchor, constant: -16),
            
            adjustInPersonButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adjustInPersonButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            adjustInPersonButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28),
            adjustInPersonButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    //----------------------------------------------------------------------------------
    //MARK:- objc
    //----------------------------------------------------------------------------------
    
    @objc func didTapAjustBtn()
    {
        guard adjustedPerson != nil
        else
        {
            showAlertView(title: "Error", message: "Adjusted person is not selected!")
            return
        }
        
        dismiss(animated: true)
        delegate?.didSelectedAdjustedPerson(person: adjustedPerson!)
    }
    
    @objc func didTapDismiss()
    { dismiss(animated: true, completion: nil) }
}

//----------------------------------------------------------------------------------
//MARK:- UITableViewDelegate, UITableViewDataSource
//----------------------------------------------------------------------------------

extension RemainingExpenseAjustmentVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: AjustablePersonCell.identifier, for: indexPath) as! AjustablePersonCell
        
        let person = persons[indexPath.row]
        cell.nameLabel.text = person.name
        
        if adjustedPerson?.name == person.name
        {
            cell.setForAdjustee()
        }
        else
        {
            cell.setForNonAdjustee()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        adjustedPerson = persons[indexPath.row]
        tableView.reloadData()
    }
}
