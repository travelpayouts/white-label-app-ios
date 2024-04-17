//
//  AppRouter.swift
//  travel-app
//
//  Created by Gleb on 15.03.2021.
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//

import UIKit

final class AppRouter: Routable {
	
	// MARK: - Internal properties
	
	let window: UIWindow
	
	var toPresent: UIViewController? {
		window.rootViewController
	}
	
	// MARK: - Initialization
	
	init(window: UIWindow) {
		self.window = window
	}
	
	// MARK: - Internal methods
	
	func present(
		module: Presentable?,
		animated: Bool,
		completion: (() -> Void)?
	) {
		guard let toController = module?.toPresent else {
			return
		}
		
		window.rootViewController?.present(
			toController,
			animated: animated,
			completion: completion
		)
	}
	
	func popModule(animated: Bool) {
		guard
			let navigationController = window.rootViewController as? UINavigationController
		else {
			return
		}
		
		navigationController.popViewController(animated: animated)
	}
	
	func push(module: Presentable?, animated: Bool) {
		guard
			let navigationController = window.rootViewController as? UINavigationController,
			let toController = module?.toPresent
		else {
			return
		}
		
		navigationController.pushViewController(toController, animated: animated)
	}
	
	func dismissModule(animated: Bool, completion: (() -> Void)?) {
		window.rootViewController?.dismiss(
			animated: animated,
			completion: completion
		)
	}
	
	func setRoot(module: Presentable?, animated: Bool) {
		window.rootViewController = module?.toPresent
	}
}
