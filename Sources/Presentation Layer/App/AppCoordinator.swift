//
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//

import Foundation

protocol AppCoordinator: Coordinator { }

final class AppCoordinatorImpl: AppCoordinator {
	
	// MARK: - Internal properties
	
	let router: Routable
	var coordinatos = [Coordinator]()
	
	// MARK: - Private properties
	
	private let tabsCoordinatorProvider: TabsCoordinatorProvider
	
	// MARK: - Init
	
	init(router: Routable, tabsCoordinatorProvider: TabsCoordinatorProvider) {
		self.tabsCoordinatorProvider = tabsCoordinatorProvider
		self.router = router
	}
	
	// MARK: - Internal methods
	
	func start() {
		handleApplicationStart()
	}

	// MARK: - Private methods
	
	private func handleApplicationStart() {
		let coordinator = tabsCoordinatorProvider.coordinator
		
		coordinatos.append(coordinator)
		router.setRoot(module: coordinator.router)
		coordinator.start()
	}
}
