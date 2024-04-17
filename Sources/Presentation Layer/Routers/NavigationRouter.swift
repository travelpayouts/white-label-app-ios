//
//  NavigationRouter.swift
//  travel-app
//
//  Created by Nikita on 22.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import UIKit

final class NavigationRouter: Routable {
	
	// MARK: - Internal properties
	
	var toPresent: UIViewController? {
		return self.rootNavigationController
	}
	
	let rootNavigationController: UINavigationController
	
	// MARK: - Initialization
	
	init(rootNavigationController: UINavigationController) {
		self.rootNavigationController = rootNavigationController
	}
	
	// MARK: - Public methods
	
	func popToRoot(animated: Bool = true) {
		rootNavigationController.popToRootViewController(animated: animated)
	}
	
	func setRoot(module: Presentable?, animated: Bool) {
		guard let toController = module?.toPresent else {
			return
		}
		
		rootNavigationController.setViewControllers([toController], animated: true)
	}
	
	func push(module: Presentable?, animated: Bool) {
		guard let toController = module?.toPresent else {
			return
		}
		
		rootNavigationController.pushViewController(toController, animated: animated)
	}
	
	func push(modules: [Presentable], animated: Bool = true) {
		let vcs = modules.map { $0.toPresent }.compactMap { $0 }
		
		let currentVCs = self.rootNavigationController.viewControllers
		
		rootNavigationController.setViewControllers(currentVCs + vcs, animated: animated)
	}
	
	func popModule(animated: Bool) {
		rootNavigationController.popViewController(animated: animated)
	}
	
	func present(
		module: Presentable?,
		animated: Bool,
		completion: (() -> Void)?
	) {
		guard let toController = module?.toPresent else {
			return
		}
		
		if let presented = self.rootNavigationController.presentedViewController {
			presented.present(toController, animated: animated, completion: completion)
		} else {
			rootNavigationController.present(toController, animated: animated, completion: completion)
		}
	}
	
	func dismissModule() {
		dismissModule(animated: true, completion: nil)
	}
	
	func dismissModule(animated: Bool, completion: (() -> Void)?) {
		if let presented = self.rootNavigationController.presentedViewController {
			presented.dismiss(animated: animated, completion: completion)
		} else {
			rootNavigationController.dismiss(animated: animated, completion: completion)
		}
	}
}
