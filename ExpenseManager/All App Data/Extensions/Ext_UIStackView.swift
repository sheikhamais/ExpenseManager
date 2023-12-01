//
//  Ext_UIStackView.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 18/08/2021.
//

import UIKit

extension UIStackView
{
    func addAllArrangedSubviews(_ views: UIView ...)
    {
        for view in views
        {
            self.addArrangedSubview(view)
        }
    }
}
