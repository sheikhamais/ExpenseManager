//
//  SelectPersonTableCell.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

protocol SelectPersonTableCellDelegate
{
    func didTapGiveFavour(cell: SelectPersonTableCell)
    func didTapSetPayee(cell: SelectPersonTableCell)
}

class SelectPersonTableCell: UITableViewCell
{
    //------------------------------------------------------------
    //MARK:- Variables
    //------------------------------------------------------------
    
    static let identifier = "SelectPersonTableCell"
    
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
    
    lazy var checkMarkCircleBtn: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.setImage(UIImage(systemName: "circle"), for: .normal)
            obj.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
            obj.tintColor = .green
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
    
    lazy var giveFavourBtn: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.backgroundColor = .red
            obj.setTitle("Favour", for: .normal)
            obj.addCornerRadius(8)
            obj.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            obj.addTarget(self, action: #selector(didTapGiveFavour), for: .touchUpInside)
            return obj
        }()
    
    lazy var payeeBtn: UIButton =
        {
            let obj = UIButton()
            obj.translatesAutoresizingMaskIntoConstraints = false
            obj.backgroundColor = .systemBlue
            obj.setTitle("Payee", for: .normal)
            obj.addCornerRadius(8)
            obj.layer.borderWidth = 2
            obj.layer.borderColor = UIColor.systemBlue.cgColor
            obj.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            obj.addTarget(self, action: #selector(didTapPayee), for: .touchUpInside)
            return obj
        }()
    
    //var for data
    var delegate: SelectPersonTableCellDelegate?
    
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
        
        containerView.addAllSubviews(checkMarkCircleBtn,
                                     nameLabel,
                                     payeeBtn,
                                     giveFavourBtn)
        
        //constraints
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            checkMarkCircleBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            checkMarkCircleBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkMarkCircleBtn.heightAnchor.constraint(equalToConstant: 24),
            checkMarkCircleBtn.widthAnchor.constraint(equalToConstant: 24),
            
            nameLabel.leadingAnchor.constraint(equalTo: checkMarkCircleBtn.trailingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: payeeBtn.leadingAnchor, constant: -4),
            
            payeeBtn.trailingAnchor.constraint(equalTo: giveFavourBtn.leadingAnchor, constant: -4),
            payeeBtn.topAnchor.constraint(equalTo: giveFavourBtn.topAnchor),
            payeeBtn.bottomAnchor.constraint(equalTo: giveFavourBtn.bottomAnchor),
            
            giveFavourBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            giveFavourBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            giveFavourBtn.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 8),
            giveFavourBtn.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8),
            giveFavourBtn.heightAnchor.constraint(equalToConstant: 40)
//            giveFavourBtn.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setForFavoured()
    {
        giveFavourBtn.setTitle("Favoured", for: .normal)
        giveFavourBtn.backgroundColor = .green
        giveFavourBtn.setTitleColor(.black, for: .normal)
    }
    
    func setForUnfavoured()
    {
        giveFavourBtn.setTitle("Favour", for: .normal)
        giveFavourBtn.backgroundColor = .red
        giveFavourBtn.setTitleColor(.white, for: .normal)
    }
    
    func setForPayee()
    {
        payeeBtn.backgroundColor = .systemBlue
        payeeBtn.setTitleColor(.white, for: .normal)
    }
    
    func setForNonPayee()
    {
        payeeBtn.backgroundColor = .clear
        payeeBtn.setTitleColor(.systemBlue, for: .normal)
    }
    
    //------------------------------------------------------------
    //MARK:- Functionality
    //------------------------------------------------------------
    
    //------------------------------------------------------------
    //MARK:- @objc Methods
    //------------------------------------------------------------
    
    @objc func didTapGiveFavour()
    { delegate?.didTapGiveFavour(cell: self) }
    
    @objc func didTapPayee()
    { delegate?.didTapSetPayee(cell: self) }
}
