//
//  ScreenShotImageView.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import UIKit

final class ScreenShotImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        backgroundColor = .lightGray
        layer.cornerRadius = 10
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
