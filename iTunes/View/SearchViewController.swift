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
    private lazy var tableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        self.view.addSubview(view)
        return view
    }()
    
    private let list = Observable.just(["카카오 T - 택시, 대리, 주차, 어쩌고, 저쩌고", "카카오맵 - 대한민국 No.1 어쩌고 저쩌고 어쩌고"])

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        setSearchController()
        bind()
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
        searchController.searchBar.placeholder = "사진을 검색할 수 있습니다."
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: Data Bind
private extension SearchViewController {
    func bind() {
        disposeBag.insert {
            list
                .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { row, element, cell in
                    cell.configure(data: element)
                }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}
