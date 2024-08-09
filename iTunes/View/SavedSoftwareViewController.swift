//
//  SavedSoftwareViewController.swift
//  iTunesSearch
//
//  Created by 조규연 on 8/9/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SavedSoftwareViewController: BaseViewController {
    private let tableView = UITableView()
    
    private let viewModel = SavedSoftwareViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureLayout() {
        view.addSubview(tableView)
        tableView.register(SavedSoftwareTableViewCell.self, forCellReuseIdentifier: SavedSoftwareTableViewCell.identifier)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

private extension SavedSoftwareViewController {
    func bind() {
        let input = SavedSoftwareViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.list
            .bind(to: tableView.rx.items(cellIdentifier: SavedSoftwareTableViewCell.identifier, cellType: SavedSoftwareTableViewCell.self)) { row, element, cell in
                cell.configure(data: element)
            }
            .disposed(by: disposeBag)
    }
}
