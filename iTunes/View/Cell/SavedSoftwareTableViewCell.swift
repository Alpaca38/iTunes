//
//  SavedSoftwareTableViewCell.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SavedSoftwareTableViewCell: BaseTableViewCell {
    private let appIconImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    private let regDateLabel = SecondaryLabel()
    
    private lazy var labelStack = {
        let view = UIStackView(arrangedSubviews: [titleLabel, regDateLabel])
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 4
        return view
    }()
    
    override func configureLayout() {
        contentView.addSubview(appIconImageView)
        contentView.addSubview(labelStack)
        
        appIconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.size.equalTo(70)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        labelStack.snp.makeConstraints {
            $0.top.equalTo(appIconImageView).offset(10)
            $0.bottom.equalTo(appIconImageView).offset(-10)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func configure(data: SavedSoftware) {
        let appIconURL = URL(string: data.artworkURL)
        appIconImageView.kf.setImage(with: appIconURL)
        
        titleLabel.text = data.trackName
        
        regDateLabel.text = data.regDateLabel
    }
}
