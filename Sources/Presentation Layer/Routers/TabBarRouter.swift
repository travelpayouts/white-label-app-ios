//
//  TabBarRouter.swift
//  travel-app
//
//  Created by Alexander Kiyaykin on 21.01.2022.
//  Copyright © 2022 CleverPumpkin. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Delegate

protocol TabBarRouterDelegate: AnyObject {
	
	func tabbarDidSelect(index: Int)
	func tabbarIndexDidChange(index: Int)
}

// MARK: - Router

final class TabBarRouter: NSObject, Routable {
	
	// MARK: - Internal properties
	
	weak var delegate: TabBarRouterDelegate?
	
	var toPresent: UIViewController? {
		rootTabBarController
	}
	
	var selectedIndex: Int {
		get {
			rootTabBarController.selectedIndex
		}
		set {
			rootTabBarController.selectedIndex = newValue
		}
	}
	
	// MARK: - Private properties
	
	private let rootTabBarController: UITabBarController
	private var lastSelectedIndex: Int?
	
	private var currentVC: UIViewController? {
		guard
			let viewControllers = rootTabBarController.viewControllers,
			viewControllers.indices.contains(rootTabBarController.selectedIndex)
		else {
			return nil
		}
		
		return viewControllers[rootTabBarController.selectedIndex]
	}
	
	// MARK: - Inits
	
	init(rootTabBarController: UITabBarController) {
		self.rootTabBarController = rootTabBarController
		
		super.init()
		
		self.rootTabBarController.delegate = self
	}
	
	// MARK: - Routable
	
	func present(
		module: Presentable?,
		animated: Bool,
		completion: (() -> Void)?
	) {
		guard let toController = module?.toPresent else {
			return
		}
		
		self.rootTabBarController.present(
			toController,
			animated: animated,
			completion: completion
		)
	}
	
	func dismissModule(animated: Bool, completion: (() -> Void)?) {
		rootTabBarController.dismiss(
			animated: animated,
			completion: completion
		)
	}
	
	func popModule(animated: Bool) {
		currentVC?.navigationController?.popViewController(
			animated: animated
		)
	}
	
	func push(module: Presentable?, animated: Bool) {
		guard let toController = module?.toPresent else {
			return
		}
		
		currentVC?.navigationController?.pushViewController(
			toController,
			animated: animated
		)
	}
	
	func setRoot(module: Presentable?, animated: Bool) {
		guard let module = module else {
			return
		}
		
		setRoot(
			modules: [module],
			animated: animated
		)
	}
	
	func setRoot(modules: [Presentable], animated: Bool) {
		var controllers = modules
			.compactMap { $0.toPresent }
		
		if UIView.userInterfaceLayoutDirection(for: .unspecified) == .rightToLeft {
			controllers.reverse()
		}
		
		rootTabBarController.setViewControllers(
			controllers,
			animated: animated
		)
	}
	
	func selectPage(index: Int) {
		guard let viewControllers = rootTabBarController.viewControllers else {
			return
		}
		
		var rtlSupportedIndex = index
		
		if UIView.userInterfaceLayoutDirection(for: .unspecified) == .rightToLeft {
			rtlSupportedIndex = viewControllers.count - index - 1
		}
		
		rootTabBarController.selectedIndex = rtlSupportedIndex
	}
}

// MARK: - UITabBarControllerDelegate

extension TabBarRouter: UITabBarControllerDelegate {
	
	// MARK: - Internal methods
	
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		delegate?.tabbarDidSelect(index: tabBarController.selectedIndex)
		
		guard lastSelectedIndex != tabBarController.selectedIndex else {
			return
		}
		
		lastSelectedIndex = tabBarController.selectedIndex
		
		delegate?.tabbarIndexDidChange(index: tabBarController.selectedIndex)
	}
}

// MARK: - Default delegate implementation

extension TabBarRouterDelegate {
	
	// MARK: - Intarnal methods
	
	func tabbarDidSelect(index: Int) {
		/* no-op */
	}
}
