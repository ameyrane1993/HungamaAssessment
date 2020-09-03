//
//  UIView.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 03/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setCornerRadiusWith(radius:CGFloat, borderColor: UIColor = .clear, borderWidth: CGFloat = 0.0) {
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
       let shadowLayer = UIView(frame: self.frame)
        shadowLayer.backgroundColor = UIColor.clear
       shadowLayer.layer.shadowColor = UIColor.gray.cgColor
        shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        shadowLayer.layer.shadowOffset = .zero
        shadowLayer.layer.shadowOpacity = 0.3
       shadowLayer.layer.shadowRadius = 9
       shadowLayer.layer.masksToBounds = true
       shadowLayer.clipsToBounds = false

       self.superview?.addSubview(shadowLayer)
       self.superview?.bringSubviewToFront(self)
    }
}

