//
//  AjustablePersonCell.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 17/08/2021.
//

import UIKit

class AjustablePersonCell: UITableViewCell
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    static let identifier = "AjustablePersonCell"
    
    var containerView: UIView =
        {
            let obj = UIView()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.backgroundColor = .white
            obj.addCornerRadius(8)
            return obj
        }()
    
    var nameLabel: UILabel =
        {
            let obj = UILabel()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.text = "name"
            obj.font = UIFont.boldSystemFont(ofSize: 15)
            obj.numberOfLines = 0
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
        
        containerView.layer.borderColor = UIColor.red.cgColor
        
        //subviews
        contentView.addSubview(containerView)
        containerView.addAllSubviews(nameLabel)
        
        //constraints
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ])
    }
    
    func setForAdjustee()
    {
        containerView.layer.borderWidth = 1
    }
    
    func setForNonAdjustee()
    {
        containerView.layer.borderWidth = 0
    }
}
