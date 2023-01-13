//
//  LibraryViewController.swift
//  DynamicNavigation
//
//  Created by James Tang on 12/1/2023.
//

import UIKit

class LibraryViewController: UIViewController {

    var toggleMode: (() -> Void)?

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Library"
        tabBarItem.title = "Library"
        tabBarItem.image = .remove
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

        let label = UILabel(frame: view.bounds)
        label.textAlignment = .center
        label.text = "Library"
        view.addSubview(label)

        let button = UIButton(frame: .init(origin: .init(x: 100, y: 100), size: .init(width: 200, height: 44)))
        button.setTitle("Toggle", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonDidPress), for: .touchUpInside)
    }

    @IBAction func buttonDidPress(_ sender: Any) {
        toggleMode?()
    }

}

