//
//  Coordinator.swift
//  travel-app
//
//  Created by Nikita on 22.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import WLUserInterface

protocol Coordinator: AnyObject {
	var router: Routable { get }
	
	func start()
	func start(with deeplink: Deeplink?)
	func handle(deeplink: Deeplink)
}

// MARK: - Default implementation

extension Coordinator {
	
	// MARK: - Public methods
	
	func start() {
		start(with: nil)
	}
	
	func handle(deeplink: Deeplink) {
		// no-op
	}
	
	func handle(deeplink: Deeplink?) {
		guard let deeplink else { return }
		
		handle(deeplink: deeplink)
	}
}
