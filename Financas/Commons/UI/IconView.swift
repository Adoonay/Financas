//
//  IconView.swift
//  Financas
//
//  Created by Adonay on 30/11/23.
//

import UIKit

class IconView: UIImageView {
    var type: EntryType = .earning {
        didSet {
            image = UIImage(systemName: type.imageName)
        }
    }

    init(type: EntryType = .earning) {
        self.type = type
        super.init(frame: .zero)

        tintColor = .red

        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 24),
            widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
