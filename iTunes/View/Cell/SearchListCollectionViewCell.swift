//
//  SearchListCollectionViewCell.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import UIKit
import SnapKit

final class SearchListCollectionViewCell: UICollectionViewCell {
        
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        contentView.addSubview(label)
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configure(data: String) {
        label.text = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
