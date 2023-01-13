//
//  SidebarViewController.swift
//  DynamicNavigation
//
//  Created by James Tang on 13/1/2023.
//

import UIKit

class SidebarViewControllerV2: UIViewController {

    var viewControllers: [UIViewController] = []
    var didSelectViewController: ((_ vc: UIViewController) -> Void)?

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "SidebarView"
        tabBarItem.title = "SidebarView"
        tabBarItem.image = .checkmark
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let tableView = UITableView(frame: view.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension SidebarViewControllerV2: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")

        let vc = viewControllers[indexPath.row]
        cell.textLabel?.text = vc.title
        return cell
    }
}

extension SidebarViewControllerV2: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = viewControllers[indexPath.row]
        didSelectViewController?(vc)
    }
}
