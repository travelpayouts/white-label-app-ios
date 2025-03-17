//
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//

import Foundation
import WLUserInterface

protocol AppCoordinator: Coordinator { }

final class AppCoordinatorImpl: AppCoordinator {
	
	// MARK: - Internal properties
	
	let router: Routable
	var coordinators = [Coordinator]()
	
	// MARK: - Private properties
	
	private let tabsCoordinatorProvider: TabsCoordinatorProvider
	
	private var tabsCoordinator: TabsCoordinator?
	
	// MARK: - Init
	
	init(router: Routable, tabsCoordinatorProvider: TabsCoordinatorProvider) {
		self.tabsCoordinatorProvider = tabsCoordinatorProvider
		self.router = router
	}
	
	// MARK: - Internal methods
	
	func start(with deeplink: Deeplink?) {
		handleApplicationStart(deeplink: deeplink)
	}
	
	func handle(deeplink: Deeplink) {
		tabsCoordinator?.handle(deeplink: deeplink)
	}

	// MARK: - Private methods
	
	private func handleApplicationStart(deeplink: Deeplink?) {
		let coordinator = tabsCoordinatorProvider.coordinator
		
		coordinators.append(coordinator)
		router.setRoot(module: coordinator.router)
		coordinator.start(with: deeplink)
		
		tabsCoordinator = coordinator
	}
}
