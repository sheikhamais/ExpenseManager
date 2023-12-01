//
//  PersonTableCell.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

class PersonTableCell: UITableViewCell
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    static let identifier = "PersonTableCell"
    
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
            obj.text = "name"
            obj.font = UIFont.boldSystemFont(ofSize: 15)
            return obj
        }()
    
    var outstandingAmountLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "amount"
            obj.font = UIFont.boldSystemFont(ofSize: 15)
            obj.textColor = .red
            return obj
        }()
    
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
                                     outstandingAmountLabel)
        
        //constraints
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 54),
            
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: outstandingAmountLabel.leadingAnchor, constant: 8),
            
            outstandingAmountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            outstandingAmountLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    //------------------------------------------------------------
    //MARK:- Functionality
    //------------------------------------------------------------
    
    //------------------------------------------------------------
    //MARK:- @objc Methods
    //------------------------------------------------------------
    
}
