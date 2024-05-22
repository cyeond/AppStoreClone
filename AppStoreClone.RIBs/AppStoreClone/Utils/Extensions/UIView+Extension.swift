//
//  UIView+Utils.swift
//  RIBsPractice
//
//  Created by YD on 5/14/24.
//

import UIKit

extension UIView {
    func roundCorners(_ radius: CGFloat = 16.0) {
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
