//
//  TabsCoordinatorComponent.swift
//
//  Created by Kristina Shevtsova on 13.07.2021.
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//

import NeedleFoundation

// MARK: - Dependencies

protocol TabsCoordinatorDependency: Dependency { }

// MARK: - Provider

protocol TabsCoordinatorProvider {
	
	var coordinator: TabsCoordinator { get }
}

// MARK: - Component

final class TabsCoordinatorComponent: Component<TabsCoordinatorDependency>, TabsCoordinatorProvider {

	// MARK: - Internal properties

	var coordinator: TabsCoordinator {
		TabsCoordinatorImpl(
			router: router,
			flightsModuleProvider: flightsModuleProvider,
			otherModuleProvider: otherModuleProvider,
			informationModuleProvider: informationModuleProvider
		)
	}

	// MARK: - Private properties
	
	private var router: Routable {
		TabBarRouter(rootTabBarController: TabBarController())
	}
	
	private var flightsModuleProvider: FlightsModuleProvider {
		FlightsModuleComponent(parent: self)
	}
	
	private var otherModuleProvider: OtherModuleProvider {
		OtherModuleComponent(parent: self)
	}
	
	private var informationModuleProvider: InformationModuleProvider {
		InformationModuleComponent(parent: self)
	}
}
