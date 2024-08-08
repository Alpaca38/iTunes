//
//  BaseViewController.swift
//  iTunes
//
//  Created by 조규연 on 8/8/24.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayout()
    }
    
    func configureLayout() { }
}
