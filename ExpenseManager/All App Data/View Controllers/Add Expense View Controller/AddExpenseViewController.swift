//
//  AddExpenseViewController.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

protocol AddExpenseViewControllerDelegate: AnyObject
{
    func didUpdatedRecords()
}

class AddExpenseViewController: BaseVC
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    lazy var dismissButton: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
            obj.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            obj.tintColor = .white
            return obj
        }()
    
    var headingLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "Add New Expense"
            obj.textColor = .white
            obj.font = UIFont.boldSystemFont(ofSize: 22)
            return obj
        }()
    
    var amountFieldsContainer: UIView =
        {
            let obj = UIView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            return obj
        }()
    
    var billAmountLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "Bill Amount"
            obj.textColor = .white
            obj.font = UIFont.boldSystemFont(ofSize: 17)
            obj.textAlignment = .center
            return obj
        }()
    
    lazy var billAmountTextFieldView: CustomTextFieldView =
        {
            let obj = CustomTextFieldView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.backgroundColor = .white
            obj.textField.placeholder = "Enter Amount"
            obj.textField.textAlignment = .center
            obj.textField.keyboardType = .numberPad
//            obj.textField.addTarget(self, action: #selector(handleFavouredDifference), for: .editingChanged)
            obj.addCornerRadius(8)
            obj.textField.font = UIFont.systemFont(ofSize: 14)
            obj.addShadowToView(shadowColor: .black,
                                offset: CGSize(width: 4, height: 4),
                                shadowRadius: 6,
                                shadowOpacity: 0.6)
            return obj
        }()
    
    var billFavouredAmountsSeparator: UIView =
        {
            let obj = UIView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.backgroundColor = .clear
            return obj
        }()
    
    var favouredAmountLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "Favoured Amount"
            obj.textColor = .white
            obj.font = UIFont.boldSystemFont(ofSize: 17)
            obj.textAlignment = .center
            return obj
        }()
    
    var favouredAmountTextFieldView: CustomTextFieldView =
        {
            let obj = CustomTextFieldView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.backgroundColor = .white
            obj.textField.placeholder = "Enter Amount"
            obj.textField.textAlignment = .center
            obj.textField.keyboardType = .numberPad
            obj.textField.addTarget(self, action: #selector(handleFavouredDifference), for: .editingChanged)
            obj.addCornerRadius(8)
            obj.textField.font = UIFont.systemFont(ofSize: 14)
            obj.addShadowToView(shadowColor: .black,
                                offset: CGSize(width: 4, height: 4),
                                shadowRadius: 6,
                                shadowOpacity: 0.6)
            return obj
        }()
    
    var favouredDifferencePerHeadLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "Favoured Difference: 0"
            obj.textColor = .white
            obj.font = UIFont.systemFont(ofSize: 12)
            obj.textAlignment = .center
            return obj
        }()
    
    lazy var selectPersonsTableView: UITableView =
        {
            let obj = UITableView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.separatorStyle = .none
            obj.backgroundColor = .clear
            
            obj.delegate = self
            obj.dataSource = self
            obj.register(SelectPersonTableCell.self, forCellReuseIdentifier: SelectPersonTableCell.identifier)
            
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
    private var allPersons: [PersonsModel]
    
    private var selectedPersons = [PersonsModel]()
    private var favouredPersons = [PersonsModel]()
    private var isBillPayee: PersonsModel?
    
//    private var adjustRemainingAmountFrom: PersonsModel?
    weak var delegate: AddExpenseViewControllerDelegate?
    
    //----------------------------------------------------------------------------------
    //MARK:- init
    //----------------------------------------------------------------------------------
    
    init(allPersons: [PersonsModel])
    {
        self.allPersons = allPersons
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //------------------------------------------------------------
    //MARK:- life cycle
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
        view.addAllSubviews(dismissButton,
                            headingLabel,
                            amountFieldsContainer,
                            favouredDifferencePerHeadLabel,
                            selectPersonsTableView,
                            addExpenseButton)
        
        amountFieldsContainer.addAllSubviews(billAmountLabel,
                                             billAmountTextFieldView,
                                             billFavouredAmountsSeparator,
                                             favouredAmountLabel,
                                             favouredAmountTextFieldView)
        
        //constraints
        let viewSafeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            dismissButton.heightAnchor.constraint(equalToConstant: 44),
            dismissButton.widthAnchor.constraint(equalToConstant: 44),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            dismissButton.centerYAnchor.constraint(equalTo: headingLabel.centerYAnchor),
            
            headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headingLabel.topAnchor.constraint(equalTo: viewSafeArea.topAnchor, constant: 26),
            
            amountFieldsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            amountFieldsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            amountFieldsContainer.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 20),
            
            favouredDifferencePerHeadLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            favouredDifferencePerHeadLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            favouredDifferencePerHeadLabel.topAnchor.constraint(equalTo: amountFieldsContainer.bottomAnchor, constant: 8),
            
            selectPersonsTableView.leadingAnchor.constraint(equalTo: amountFieldsContainer.leadingAnchor),
            selectPersonsTableView.trailingAnchor.constraint(equalTo: amountFieldsContainer.trailingAnchor),
            selectPersonsTableView.topAnchor.constraint(equalTo: favouredDifferencePerHeadLabel.bottomAnchor, constant: 8),
            selectPersonsTableView.bottomAnchor.constraint(equalTo: addExpenseButton.topAnchor, constant: -20),
            
            addExpenseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addExpenseButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            addExpenseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28),
            addExpenseButton.heightAnchor.constraint(equalToConstant: 44),
            
            billFavouredAmountsSeparator.centerXAnchor.constraint(equalTo: amountFieldsContainer.centerXAnchor),
            billFavouredAmountsSeparator.widthAnchor.constraint(equalToConstant: 1),
            billFavouredAmountsSeparator.bottomAnchor.constraint(equalTo: amountFieldsContainer.bottomAnchor),
            billFavouredAmountsSeparator.topAnchor.constraint(equalTo: amountFieldsContainer.topAnchor),
            
            billAmountLabel.leadingAnchor.constraint(equalTo: amountFieldsContainer.leadingAnchor),
            billAmountLabel.trailingAnchor.constraint(equalTo: billFavouredAmountsSeparator.leadingAnchor),
            billAmountLabel.topAnchor.constraint(equalTo: amountFieldsContainer.topAnchor, constant: 8),
            
            billAmountTextFieldView.leadingAnchor.constraint(equalTo: amountFieldsContainer.leadingAnchor, constant: 10),
            billAmountTextFieldView.trailingAnchor.constraint(equalTo: billFavouredAmountsSeparator.leadingAnchor, constant: -10),
            billAmountTextFieldView.topAnchor.constraint(equalTo: billAmountLabel.bottomAnchor, constant: 8),
            billAmountTextFieldView.bottomAnchor.constraint(equalTo: amountFieldsContainer.bottomAnchor, constant: -8),
            billAmountTextFieldView.heightAnchor.constraint(equalToConstant: 44),
            
            favouredAmountLabel.leadingAnchor.constraint(equalTo: billFavouredAmountsSeparator.trailingAnchor),
            favouredAmountLabel.trailingAnchor.constraint(equalTo: amountFieldsContainer.trailingAnchor),
            favouredAmountLabel.topAnchor.constraint(equalTo: amountFieldsContainer.topAnchor, constant: 8),
            
            favouredAmountTextFieldView.leadingAnchor.constraint(equalTo: billFavouredAmountsSeparator.trailingAnchor, constant: 10),
            favouredAmountTextFieldView.trailingAnchor.constraint(equalTo: amountFieldsContainer.trailingAnchor, constant: -10),
            favouredAmountTextFieldView.topAnchor.constraint(equalTo: favouredAmountLabel.bottomAnchor, constant: 8),
            favouredAmountTextFieldView.bottomAnchor.constraint(equalTo: amountFieldsContainer.bottomAnchor, constant: -8),
            favouredAmountTextFieldView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    //------------------------------------------------------------
    //MARK:- Functionality
    //------------------------------------------------------------
    
    func selectedPersonsContains(person: PersonsModel) -> Bool
    {
        for per in selectedPersons
        {
            if per.name == person.name
            {
                return true
            }
        }
        
        return false
    }
    
    func favouredPersonsContains(person: PersonsModel) -> Bool
    {
        for per in favouredPersons
        {
            if per.name == person.name
            {
                return true
            }
        }
        
        return false
    }
    
    func removeFromSelectedPersons(person: PersonsModel)
    {
        guard selectedPersons.count > 0
        else { return }
        
        for i in 0...selectedPersons.count - 1
        {
            if selectedPersons[i].name == person.name
            {
                selectedPersons.remove(at: i)
                return
            }
        }
    }
    
    func removeFromFavouredPersons(person: PersonsModel)
    {
        guard favouredPersons.count > 0
        else { return }
        
        for i in 0...favouredPersons.count - 1
        {
            if favouredPersons[i].name == person.name
            {
                favouredPersons.remove(at: i)
                return
            }
        }
    }
    
    func getValidationError() -> String?
    {
        let totalBillAmount = billAmountTextFieldView.textField.text?.cgFloatValue ?? 0.0
        let favouredAmount = favouredAmountTextFieldView.textField.text?.cgFloatValue ?? 0.0
        
        guard totalBillAmount > 0
        else
        { return "Total bill amount should be greater than 0!" }
        
        guard totalBillAmount > favouredAmount
        else
        { return "Total bill amount should be greater than favoured amount!" }
        
        guard selectedPersons.count > 0
        else
        { return "Selected number of persons for bill cannot be 0!" }
        
        guard isBillPayee != nil
        else
        { return "Bill payee cannot be nil!" }
        
        if favouredAmount > 0 || favouredPersons.count > 0
        {
            guard favouredPersons.count > 0
            else
            { return "Selected number of persons to be favoured cannot be 0!" }
            
            guard favouredAmount > 0
            else
            { return "Favoured amount cannot be 0!" }
            
            guard favouredPersons.count < selectedPersons.count
            else
            { return "Favoured number of persons should be less than selected number of persons!" }
        }
        
        return nil
    }
    
    func settleAmounts(favouredAmount: Int, unfavouredAmount: Int)
    {
        let totalBillAmount = Int(billAmountTextFieldView.textField.text!) ?? 0
        
        for person in selectedPersons
        {
            let amountToAdd = favouredPersons.contains(where: {
                $0.name == person.name
            }) ? favouredAmount : unfavouredAmount
            
            let existingAmount = Int(person.outstandingAmount) ?? 0
            var newValue = existingAmount + amountToAdd
            
            if person.name == isBillPayee?.name
            {
                newValue -= totalBillAmount
            }
            
            person.outstandingAmount = "\(newValue)"
        }
    }
    
    func storeUpdatedDataInDefaults()
    { UserDefaultsManager.storePersonsDataInUserDefaults(persons: allPersons) }
    
    func dismissUponCompletion()
    {
        storeUpdatedDataInDefaults()
        delegate?.didUpdatedRecords()
        dismiss(animated: true)
    }
    
    //------------------------------------------------------------
    //MARK:- @objc Methods
    //------------------------------------------------------------
    
    @objc func didTapAddExpense()
    {
        if let error = getValidationError()
        {
            showAlertView(title: "Error", message: error)
            return
        }
        
        let totalBillAmount = billAmountTextFieldView.textField.text?.cgFloatValue ?? 0.0
        let favouredAmount = favouredAmountTextFieldView.textField.text?.cgFloatValue ?? 0.0
        
        let selectedUnfavouredPersons = selectedPersons.filter
        {
            if favouredPersonsContains(person: $0)
            { return false }
            else
            { return true }
        }
        
        var favouredFactorToAddInUnfavouredOnes: CGFloat = 0
        if selectedUnfavouredPersons.count > 0
        {
            favouredFactorToAddInUnfavouredOnes = favouredAmount / CGFloat(selectedUnfavouredPersons.count)
        }
        
        let amountToAddInFavoured = floor((totalBillAmount - favouredAmount) / CGFloat(selectedPersons.count))
        let amountToAddInUnfavoured = floor(amountToAddInFavoured + favouredFactorToAddInUnfavouredOnes)
        
        print(amountToAddInFavoured, amountToAddInUnfavoured)
        
        let totalCalculatedAmount = Int(amountToAddInFavoured) * favouredPersons.count + Int(amountToAddInUnfavoured) * selectedUnfavouredPersons.count

        print(totalCalculatedAmount)
        
        if totalCalculatedAmount < Int(totalBillAmount)
        {
            //get settlement person
            let remainingAmount = Int(totalBillAmount) - totalCalculatedAmount
            let vc = RemainingExpenseAjustmentVC(persons: selectedPersons, remainingAmount: remainingAmount, delegate: self)
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        else
        {
            settleAmounts(favouredAmount: Int(amountToAddInFavoured),
                          unfavouredAmount: Int(amountToAddInUnfavoured))
            
            dismissUponCompletion()
        }
    }
    
    @objc func didTapDismiss()
    { dismiss(animated: true, completion: nil) }
    
    @objc func handleFavouredDifference()
    {
        let favouredAmount = favouredAmountTextFieldView.textField.text!.cgFloatValue ?? 0.0
        
        guard selectedPersons.count > 0,
              favouredPersons.count > 0,
              favouredAmount != 0.0
        else { return }
        
        let selectedUnfavouredPersons = selectedPersons.filter
        {
            if favouredPersonsContains(person: $0)
            { return false }
            else
            { return true }
        }
        
        let favouredDiffAmount = favouredAmount / CGFloat(selectedUnfavouredPersons.count)
        favouredDifferencePerHeadLabel.text = "Favoured Difference: \(favouredDiffAmount)"
    }
}

//----------------------------------------------------------------------------------
//MARK:- UITableViewDelegate, UITableViewDataSource
//----------------------------------------------------------------------------------

extension AddExpenseViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allPersons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectPersonTableCell.identifier, for: indexPath) as! SelectPersonTableCell
        
        cell.delegate = self
        
        let personModel = allPersons[indexPath.row]
        cell.nameLabel.text = personModel.name
        
        if selectedPersonsContains(person: personModel)
        {
            cell.checkMarkCircleBtn.isSelected = true
        }
        else
        {
            cell.checkMarkCircleBtn.isSelected = false
        }
        
        if favouredPersonsContains(person: personModel)
        {
            cell.setForFavoured()
        }
        else
        {
            cell.setForUnfavoured()
        }
        
        if let payee = isBillPayee,
           payee.name == personModel.name
        {
            cell.setForPayee()
        }
        else
        {
            cell.setForNonPayee()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let person = allPersons[indexPath.row]
        
        if selectedPersonsContains(person: person)
        {
            removeFromFavouredPersons(person: person)
            removeFromSelectedPersons(person: person)
        }
        else
        {
            selectedPersons.append(person)
        }
        
        handleFavouredDifference()
        tableView.reloadData()
    }
}

//----------------------------------------------------------------------------------
//MARK:- SelectPersonTableCellDelegate
//----------------------------------------------------------------------------------

extension AddExpenseViewController: SelectPersonTableCellDelegate
{
    func didTapSetPayee(cell: SelectPersonTableCell)
    {
        guard let indexPath = selectPersonsTableView.indexPath(for: cell)
        else { return }
        
        let person = allPersons[indexPath.row]
        
        guard selectedPersonsContains(person: person)
        else
        {
            showAlertView(title: "Error", message: "Person should be selected to be bill payee!")
            return
        }
        
        isBillPayee = person
        selectPersonsTableView.reloadData()
    }
    
    func didTapGiveFavour(cell: SelectPersonTableCell)
    {
        guard let indexPath = selectPersonsTableView.indexPath(for: cell)
        else { return }
        
        let person = allPersons[indexPath.row]
        
        guard selectedPersonsContains(person: person)
        else
        {
            showAlertView(title: "Error", message: "Person should be selected first to be favoured!")
            return
        }
        
        if favouredPersonsContains(person: person)
        {
            removeFromFavouredPersons(person: person)
        }
        else
        {
            favouredPersons.append(person)
        }
        
        handleFavouredDifference()
        selectPersonsTableView.reloadData()
    }
}

//----------------------------------------------------------------------------------
//MARK:- SectionName
//----------------------------------------------------------------------------------

extension AddExpenseViewController: RemainingExpenseAjustmentVCDelegate
{
    func didSelectedAdjustedPerson(person: PersonsModel)
    {
        let totalBillAmount = billAmountTextFieldView.textField.text?.cgFloatValue ?? 0.0
        let favouredAmount = favouredAmountTextFieldView.textField.text?.cgFloatValue ?? 0.0
        
        let selectedUnfavouredPersons = selectedPersons.filter
        {
            if favouredPersonsContains(person: $0)
            { return false }
            else
            { return true }
        }
        
        var favouredFactorToAddInUnfavouredOnes: CGFloat = 0
        if selectedUnfavouredPersons.count > 0
        {
            favouredFactorToAddInUnfavouredOnes = favouredAmount / CGFloat(selectedUnfavouredPersons.count)
        }
        
        let amountToAddInFavoured = floor((totalBillAmount - favouredAmount) / CGFloat(selectedPersons.count))
        let amountToAddInUnfavoured = floor(amountToAddInFavoured + favouredFactorToAddInUnfavouredOnes)
        
        let totalCalculatedAmount = Int(amountToAddInFavoured) * favouredPersons.count + Int(amountToAddInUnfavoured) * selectedUnfavouredPersons.count

        let remainingAdjustableAmount = Int(totalBillAmount) - totalCalculatedAmount
         
        for per in selectedPersons
        {
            if per.name == person.name
            {
                let existingAmount = Int(per.outstandingAmount) ?? 0
                per.outstandingAmount = "\(existingAmount + remainingAdjustableAmount)"
            }
        }
        
        settleAmounts(favouredAmount: Int(amountToAddInFavoured),
                      unfavouredAmount: Int(amountToAddInUnfavoured))
        
        dismissUponCompletion()
    }
}
