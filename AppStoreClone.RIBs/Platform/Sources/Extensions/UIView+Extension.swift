//
//  UIView+Utils.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import UIKit

public extension UIView {
    func roundCorners(_ radius: CGFloat = 16.0) {
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setBorder(width: CGFloat = 1.0, color: UIColor = .systemGray4) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
