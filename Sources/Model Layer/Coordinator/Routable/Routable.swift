//
//  Routable.swift
//  travel-app
//
//  Created by Nikita on 22.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

protocol Routable: Presentable {
	
	// Modally
	func present(module: Presentable?)
	func present(module: Presentable?, animated: Bool)
	func present(module: Presentable?, animated: Bool, completion: (() -> Void)?)
	
	func dismissModule()
	func dismissModule(completion: (() -> Void)?)
	func dismissModule(animated: Bool, completion: (() -> Void)?)
	
	// Navigation
	func push(module: Presentable?)
	func push(module: Presentable?, animated: Bool)
	
	func popModule()
	func popModule(animated: Bool)
	
	// Change root
	func setRoot(module: Presentable?)
	func setRoot(module: Presentable?, animated: Bool)
}

// MARK: - Modally

extension Routable {
	
	// MARK: - Internal methods
	
	func present(module: Presentable?) {
		present(module: module, animated: true, completion: nil)
	}
	
	func present(module: Presentable?, animated: Bool) {
		present(module: module, animated: animated, completion: nil)
	}
	
	func dismissModule() {
		dismissModule(animated: true, completion: nil)
	}
	
	func dismissModule(completion: (() -> Void)?) {
		dismissModule(animated: true, completion: completion)
	}
}

// MARK: - Navigation

extension Routable {
	
	// MARK: - Internal methods
	
	func popModule() {
		popModule(animated: true)
	}
	
	func push(module: Presentable?) {
		push(module: module, animated: true)
	}
}

// MARK: - Change root

extension Routable {
	
	// MARK: - Internal methods
	
	func setRoot(module: Presentable?) {
		setRoot(module: module, animated: true)
	}
}
