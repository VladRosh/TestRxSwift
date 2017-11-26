//
//  extension.swift
//  TestRxSwift
//
//  Created by VLAD on 24/11/2017.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
