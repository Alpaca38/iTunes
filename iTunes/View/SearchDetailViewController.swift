//
//  SearchDetailViewController.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchDetailViewController: BaseViewController {
    private let appIconImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    private let sellerLabel = {
        let view = SecondaryLabel()
        view.textAlignment = .left
        return view
    }()
    
    private let downloadButton = {
        var config = UIButton.Configuration.tinted()
        config.background.backgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.title = "받기"
        config.cornerStyle = .capsule
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
    private let releaseNotesLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.numberOfLines = 0
        return view
    }()
    
    private let descriptionLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        return view
    }()
    
    private let viewModel: SearchDetailViewModel
    
    init(viewModel: SearchDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        configure(data: viewModel.softwareData)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func configureLayout() {
        view.addSubViews(views: [appIconImageView, titleLabel, sellerLabel, downloadButton, newInfoLabel, versionLabel, releaseNotesLabel, descriptionLabel])
        
        appIconImageView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top).offset(10)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        sellerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
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
        
        releaseNotesLabel.snp.makeConstraints {
            $0.top.equalTo(versionLabel.snp.bottom).offset(20)
            $0.leading.equalTo(appIconImageView)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(releaseNotesLabel.snp.bottom).offset(20)
            $0.leading.equalTo(appIconImageView)
            $0.trailing.equalTo(releaseNotesLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchDetailViewController {
    func configure(data: SoftwareResult) {
        let appIconURL = URL(string: data.artworkUrl100)
        appIconImageView.kf.setImage(with: appIconURL)
        
        titleLabel.text = data.trackName
        
        sellerLabel.text = data.sellerName
        
        versionLabel.text = data.versionLabel
        
        releaseNotesLabel.text = data.releaseNotes
        
        descriptionLabel.text = data.description
    }
}
