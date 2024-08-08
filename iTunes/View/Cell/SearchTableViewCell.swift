//
//  SearchTableViewCell.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import UIKit
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    private let appIconImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .lightGray // test
        return view
    }()
    
    private let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    private let downloadButton = {
        var config = UIButton.Configuration.gray()
        config.cornerStyle = .capsule
        config.title = "받기"
        let view = UIButton(configuration: config)
        return view
    }()
    
    private let starImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        return view
    }()
    
    private let ratingLabel = SecondaryLabel()
    private let sellerLabel = SecondaryLabel()
    private let genreLabel = SecondaryLabel()
    private let firstScreenshotImageView = ScreenShotImageView(frame: .zero)
    private let secondScreenshotImageView = ScreenShotImageView(frame: .zero)
    private let thirdScreenshotImageView = ScreenShotImageView(frame: .zero)
    
    override func configureLayout() {
        contentView.addSubViews(views: [appIconImageView, titleLabel, downloadButton, starImageView, ratingLabel, sellerLabel, genreLabel, firstScreenshotImageView, secondScreenshotImageView, thirdScreenshotImageView])
        
        appIconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.size.equalTo(70)
        }
        
        downloadButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(appIconImageView)
            $0.width.equalTo(70)
            $0.height.equalTo(35)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(appIconImageView)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-10)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.bottom).offset(10)
            $0.leading.equalTo(appIconImageView)
            $0.size.equalTo(20)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
            $0.centerY.equalTo(starImageView)
        }
        ratingLabel.text = "4.7" // dummy
        
        sellerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(starImageView)
        }
        sellerLabel.text = "Kakao Corp." // dummy
        
        genreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(starImageView)
        }
        genreLabel.text = "네비게이션" // dummy
        
        firstScreenshotImageView.snp.makeConstraints {
            $0.top.equalTo(starImageView.snp.bottom).offset(10)
            $0.leading.equalTo(starImageView)
            
            let width = (UIScreen.main.bounds.width - 60) / 3
            $0.width.equalTo(width)
            $0.height.equalTo(width * 2)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        secondScreenshotImageView.snp.makeConstraints {
            $0.top.equalTo(firstScreenshotImageView)
            $0.leading.equalTo(firstScreenshotImageView.snp.trailing).offset(10)
            
            let width = (UIScreen.main.bounds.width - 60) / 3
            $0.width.equalTo(width)
            $0.height.equalTo(width * 2)
            $0.bottom.equalTo(firstScreenshotImageView)
        }
        
        thirdScreenshotImageView.snp.makeConstraints {
            $0.top.equalTo(firstScreenshotImageView)
            $0.leading.equalTo(secondScreenshotImageView.snp.trailing).offset(10)
            
            let width = (UIScreen.main.bounds.width - 60) / 3
            $0.width.equalTo(width)
            $0.height.equalTo(width * 2)
            $0.bottom.equalTo(firstScreenshotImageView)
        }
    }
    
    func configure(data: String) {
        titleLabel.text = data
    }
}
