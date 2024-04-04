//
//  UIView.swift
//  Financas
//
//  Created by Adonay on 30/11/23.
//

import UIKit

extension UIView {
    static func stack(views: [UIView],
                      axis: NSLayoutConstraint.Axis,
                      spacing: CGFloat,
                      alignment: UIStackView.Alignment = .fill,
                      distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = axis
        stack.spacing = spacing
        stack.alignment = alignment
        stack.distribution = distribution
        return stack
    }
}
