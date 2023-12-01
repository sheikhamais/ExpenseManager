//
//  SetInitialsTableCell.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 17/08/2021.
//

import UIKit

protocol SetInitialsTableCellDelegate: AnyObject
{
//    func didUpdatedAmount(atCell: SetInitialsTableCell, amount: String)
    func requestModification(personName: String, modifiedAmount: String)
}

class SetInitialsTableCell: UITableViewCell
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    static let identifier = "SetInitialsTableCell"
    
    var containerView: UIView =
        {
            let obj = UIView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.backgroundColor = .white
            obj.addCornerRadius(8)
            obj.addShadowToView(shadowColor: .black,
                                offset: CGSize(width: 4, height: 4),
                                shadowRadius: 6,
                                shadowOpacity: 1)
            return obj
        }()
    
    var nameLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.font = UIFont.boldSystemFont(ofSize: 15)
            obj.numberOfLines = 0
            return obj
        }()
    
    lazy var amountTextField: CustomTextFieldView =
        {
            let obj = CustomTextFieldView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.textField.placeholder = "Set Amount"
//            obj.textField.keyboardType = .numberPad
            obj.textField.font = UIFont.systemFont(ofSize: 13)
            obj.textField.textAlignment = .center
            obj.textField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
            obj.layer.borderWidth = 1
            obj.layer.borderColor = UIColor.black.cgColor
            obj.addCornerRadius()
            return obj
        }()
    
    //data
    weak var delegate: SetInitialsTableCellDelegate?
    
    //------------------------------------------------------------
    //MARK:- Initializers
    //------------------------------------------------------------
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        //perperties
        backgroundColor = .clear
        selectionStyle = .none
        
        //subviews
        contentView.addSubview(containerView)
        containerView.addAllSubviews(nameLabel,
                                     amountTextField)
        
        //constraints
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            nameLabel.trailingAnchor.constraint(equalTo: amountTextField.leadingAnchor, constant: -4),
            
            amountTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            amountTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
            amountTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            amountTextField.widthAnchor.constraint(equalToConstant: 92)
        ])
    }
    
    //----------------------------------------------------------------------------------
    //MARK:- SectionName
    //----------------------------------------------------------------------------------
    
    @objc func amountChanged()
    {
//        delegate?.didUpdatedAmount(atCell: self, amount: amountTextField.textField.text!.trim)
        delegate?.requestModification(personName: nameLabel.text!, modifiedAmount: amountTextField.textField.text!.trim)
    }
}
