//
//  ScreenshotCollectionViewCell.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import UIKit
import SnapKit
import Kingfisher

final class ScreenshotCollectionViewCell: BaseCollectionViewCell {
    private let screenshotImageView = ScreenShotImageView(frame: .zero)
    
    override func configureLayout() {
        contentView.addSubview(screenshotImageView)
        
        screenshotImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(screenshotURL: String) {
        let imageURL = URL(string: screenshotURL)
        screenshotImageView.kf.setImage(with: imageURL)
    }
}
