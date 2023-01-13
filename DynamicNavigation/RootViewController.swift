//
//  ViewController.swift
//  DynamicNavigation
//
//  Created by James Tang on 12/1/2023.
//

import UIKit
import Combine

class RootViewModel: ObservableObject {
    enum Mode {
        case tabBar // legacy
        case sideBar
    }

    var router: Router
    @Published var mode: Mode

    init(router: Router,
         mode: Mode) {
        self.router = router
        self.mode = mode
    }
}

class RootViewController: UIViewController {

    let viewModel: RootViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(_ viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let label = UILabel(frame: view.bounds)
        label.textAlignment = .center
        label.text = "Root View \(viewModel.mode)"
        view.addSubview(label)

        var currentRoot: UIViewController?
        viewModel.$mode
            .sink { mode in
                if let currentRoot = currentRoot {
                    currentRoot.view.removeFromSuperview()
                    currentRoot.removeFromParent()
                }
                switch mode {
                case .tabBar:
                    currentRoot = self.setupTabBarController()
                case .sideBar:
                    currentRoot = self.setupSidebarController()
                }
            }
            .store(in: &self.cancellables)

    }

    private func setupTabBarController() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            setupLibraryViewController().withNavigationController(),
            viewModel.router.searchViewController().withNavigationController(),
            viewModel.router.libraryViewV2().withNavigationController()
        ]

        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
        return tabBarController
    }

    private func setupSidebarController() -> UIViewController {
        let splitViewController = UISplitViewController()
        splitViewController.preferredDisplayMode = .oneBesideSecondary
        let sidebarViewController = SidebarViewControllerV2()
        sidebarViewController.viewControllers = [
            viewModel.router.libraryViewV2().withNavigationController(),
            setupLibraryViewController().withNavigationController(),
            viewModel.router.searchViewController().withNavigationController()
        ]
        sidebarViewController.didSelectViewController = { vc in
            splitViewController.showDetailViewController(vc, sender: nil)
        }

        addChild(splitViewController)
        view.addSubview(splitViewController.view)
        splitViewController.didMove(toParent: self)
        splitViewController.view.frame = view.bounds
        splitViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        splitViewController.view.translatesAutoresizingMaskIntoConstraints = true
        splitViewController.viewControllers = [sidebarViewController, sidebarViewController.viewControllers[0]]
        return splitViewController
    }

    private func setupLibraryViewController() -> LibraryViewController {
        let vc = viewModel.router.libraryViewController()
        vc.toggleMode = { [unowned self] in
            switch self.viewModel.mode {
            case .sideBar:
                self.viewModel.mode = .tabBar
            case .tabBar:
                self.viewModel.mode = .sideBar
            }
        }
        return vc
    }

}

extension UIViewController {
    func withNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        return navigationController
    }
}
