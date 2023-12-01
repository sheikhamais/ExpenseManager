//
//  Ext_UIView.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

extension UIView
{
    func addCornerRadius(_ radius: CGFloat = 8.0)
    {
        self.layer.cornerRadius = radius
    }
    
    func addCornerRadiusTo(cornerRadius: CGFloat = 8, corners: CACornerMask)
    {
        if #available(iOS 11.0, *)
        {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.layer.maskedCorners = corners
        }
    }
    
    func addAllSubviews(_ views: UIView ...)
    {
        for view in views
        {
            self.addSubview(view)
        }
    }
    
    func addShadowToView(shadowColor: UIColor  = UIColor.black,
                         offset: CGSize         = .zero,
                         shadowRadius: CGFloat = 10,
                         shadowOpacity: Float  = 0.8)
    {
        layer.shadowColor      = shadowColor.cgColor
        layer.shadowOpacity    = shadowOpacity
        layer.shadowOffset     = offset
        layer.shadowRadius     = shadowRadius
   
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
//    func addTwoColors(colors: [UIColor], locations: [CGFloat])
//    {
////        guard colors.count == 2,
////              locations.count == 2
////        else { return }
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//        gradientLayer.needsDisplayOnBoundsChange = true
//        gradientLayer.colors = [colors[0].cgColor, colors[1].cgColor,]
//        gradientLayer.locations = [0.0, 0.5]
//        layer.addSublayer(gradientLayer)
//
//        NSLayoutConstraint.activate([
//            gradientLayer.leadingAnchor.constraint(equalTo: leadingAnchor),
//            gradientLayer.trailingAnchor.constraint(equalTo: trailingAnchor),
//            gradientLayer.topAnchor.constraint(equalTo: topAnchor),
//            gradientLayer.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
    
//    func addTwoColorVerticalGradient(color1: UIColor, color2: UIColor)
//    {
//        let gradientLayer: CAGradientLayer =
//            {
//                let obj = CAGradientLayer()
//                obj.colors = [color1.cgColor, color2.cgColor]
//                obj.startPoint = CGPoint(x: 0.5, y: 0)
//                obj.endPoint = CGPoint(x: 0.5, y: 1)
//
//                let locations: [NSNumber] = [0, 0.5, 1]
//                obj.locations = locations
//
//                return obj
//            }()
//
//        self.layer.addSublayer(gradientLayer)
//
//    }
    
    func makeViewDull()
    {
        let coveringView: UIView =
            {
                let obj = UIView()
                obj.translatesAutoresizingMaskIntoConstraints = false
                obj.backgroundColor = .black
                obj.alpha = 0.3
                return obj
            }()
        
        addSubview(coveringView)
        
        NSLayoutConstraint.activate([
            
            coveringView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coveringView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coveringView.topAnchor.constraint(equalTo: topAnchor),
            coveringView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
