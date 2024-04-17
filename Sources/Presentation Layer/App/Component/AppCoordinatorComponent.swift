//
//  AppCoordinatorComponent.swift
//  travel-app
//
//  Created by Alexander Kiyaykin on 21.01.2022.
//  Copyright © 2022 CleverPumpkin. All rights reserved.
//

import WLNetwork
import NeedleFoundation

protocol AppCoordinatorDependency: Dependency {
	var rootWindow: UIWindow { get }
}

protocol AppCoordinatorProvider {
	var appCoordinator: AppCoordinator { get }
}

final class AppCoordinatorComponent: Component<AppCoordinatorDependency>, AppCoordinatorProvider {
	
	// MARK: - Internal properties
	
	var appCoordinator: AppCoordinator {
		AppCoordinatorImpl(
			router: appRouter,
			tabsCoordinatorProvider: tabsCoordinatorComponent
		)
	}
	
	// MARK: - Private properties
	
	private var appRouter: Routable {
		AppRouter(window: dependency.rootWindow)
	}
	
	private var tabsCoordinatorComponent: TabsCoordinatorComponent {
		TabsCoordinatorComponent(parent: self)
	}
}
