//
//  Router.swift
//  DynamicNavigation
//
//  Created by James Tang on 13/1/2023.
//

import Foundation
import SwiftUI

class Router {
    func libraryViewController() -> LibraryViewController {
        LibraryViewController()
    }
    func searchViewController() -> SearchViewController {
        SearchViewController()
    }
    func libraryViewV2() -> UIViewController {
        let vc = UIHostingController(rootView: LibraryViewV2())
        vc.title = "Library V2"
        vc.tabBarItem.title = "Library V2"
        vc.tabBarItem.image = .checkmark
        return vc
    }
}
