//
//  SecondaryLabel.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import UIKit

final class SecondaryLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .secondaryLabel
        font = .systemFont(ofSize: 13)
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
