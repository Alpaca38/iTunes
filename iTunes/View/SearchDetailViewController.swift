//
//  SearchDetailViewController.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import UIKit
import SnapKit

final class SearchDetailViewController: BaseViewController {
    private let appIconImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    private let sellerLabel = SecondaryLabel()
    private let downloadButton = {
        var config = UIButton.Configuration.tinted()
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.title = "받기"
        let view = UIButton(configuration: config)
        return view
    }()
    
    private let newInfoLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.text = "새로운 소식"
        return view
    }()
    
    private let versionLabel = SecondaryLabel()
    private let descriptionLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.numberOfLines = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureLayout() {
        view.addSubViews(views: [appIconImageView, titleLabel, sellerLabel, downloadButton, newInfoLabel, versionLabel, descriptionLabel])
        
        appIconImageView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top).offset(20)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        sellerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel)
        }
        
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView)
            $0.leading.equalTo(titleLabel)
            $0.width.equalTo(70)
            $0.height.equalTo(35)
        }
        
        newInfoLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.bottom).offset(30)
            $0.leading.equalTo(appIconImageView)
        }
        
        versionLabel.snp.makeConstraints {
            $0.top.equalTo(newInfoLabel.snp.bottom).offset(10)
            $0.leading.equalTo(appIconImageView)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(versionLabel.snp.bottom).offset(20)
            $0.leading.equalTo(appIconImageView)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}


