//
//  ViewController.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchViewController: BaseViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout())
        view.showsHorizontalScrollIndicator = false
        view.register(SearchListCollectionViewCell.self, forCellWithReuseIdentifier: SearchListCollectionViewCell.identifier)
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var tableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        self.view.addSubview(view)
        return view
    }()
    
    private let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        setSearchController()
        bind()
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

// MARK: UI
private extension SearchViewController {
    func setNavi() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "검색"
    }
    
    func setSearchController() {
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return layout
    }
}

// MARK: Data Bind
private extension SearchViewController {
    func bind() {
        let input = SearchViewModel.Input(
            searchTap: searchController.searchBar.rx.searchButtonClicked,
            searchText: searchController.searchBar.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        disposeBag.insert {
            output.list
                .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { row, element, cell in
                    cell.configure(data: element)
                }
            
            tableView.rx.modelSelected(SoftwareResult.self)
                .bind(with: self) { owner, value in
                    let viewModel = SearchDetailViewModel(softwareData: value)
                    let vc = SearchDetailViewController(viewModel: viewModel)
                    owner.navigationController?.pushViewController(vc, animated: true)
                }
            
            output.searchList
                .bind(to: collectionView.rx.items(cellIdentifier: SearchListCollectionViewCell.identifier, cellType: SearchListCollectionViewCell.self)) { item, element, cell in
                    cell.configure(data: element)
                }
        }
    }
}
