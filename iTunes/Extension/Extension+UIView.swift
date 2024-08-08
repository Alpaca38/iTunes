//
//  Extension+UIView.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import UIKit

extension UIView {
    func addSubViews(views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
