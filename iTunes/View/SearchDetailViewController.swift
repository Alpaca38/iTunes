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
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
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
    
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return view
    }()
    
    private let descriptionLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.addSubview(contentView)
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var contentView = {
        let view = UIView()
        view.addSubViews(views: [appIconImageView, titleLabel, sellerLabel, downloadButton, newInfoLabel, versionLabel, releaseNotesLabel, collectionView, descriptionLabel])
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
        configureDataSource()
        updateSnapshot()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        appIconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
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
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(releaseNotesLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(580)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview().inset(20)
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

// MARK: CollectiovView Layout
private extension SearchDetailViewController {
    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(section: createSection())
    }
    
    func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

// MARK: DataSource
private extension SearchDetailViewController {
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ScreenshotCollectionViewCell, String> { cell, indexPath, itemIdentifier in
            cell.configure(screenshotURL: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.softwareData.screenshotUrls, toSection: 0)
        
        dataSource.apply(snapshot)
    }
}
