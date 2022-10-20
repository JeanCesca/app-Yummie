//
//  UIView+.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 18/10/22.
//

import Foundation
import UIKit

extension UIView {
    
    func applyShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.systemGray3.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
    }
}
