//
//  LibraryViewControllerV2.swift
//  DynamicNavigation
//
//  Created by James Tang on 12/1/2023.
//

import UIKit

class SearchViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Search"
        tabBarItem.title = "Search"
        tabBarItem.image = .actions
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let label = UILabel(frame: view.bounds)
        label.textAlignment = .center
        label.text = "Search"
        view.addSubview(label)
    }

}

