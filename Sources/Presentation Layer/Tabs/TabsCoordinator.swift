//
//  TabsCoordinator.swift
//
//  Created by Kristina Shevtsova on 13.07.2021.
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import WLInformation
import WLUserInterface
import WLConfig
import WLSupport

// MARK: - Private typealiases

private typealias OtherScreenParameters = ApplicationConfiguration.OptionalTab.OtherParameters

// MARK: - Interface

protocol TabsCoordinator: Coordinator { }

// MARK: - Implementation

final class TabsCoordinatorImpl: TabsCoordinator {
	
	// MARK: - Internal properties
	
	let router: Routable
	
	// MARK: - Private properties
	
	private let flightsModuleProvider: FlightsModuleProvider
	private let otherModuleProvider: OtherModuleProvider
	private let informationModuleProvider: InformationModuleProvider
	private var childModules = [Presentable]()
	
	private var tabBarRouter: TabBarRouter? {
		router as? TabBarRouter
	}
	
	// MARK: - Inits
	
	init(
		router: Routable,
		flightsModuleProvider: FlightsModuleProvider,
		otherModuleProvider: OtherModuleProvider,
		informationModuleProvider: InformationModuleProvider
	) {
		self.router = router
		
		self.flightsModuleProvider = flightsModuleProvider
		self.otherModuleProvider = otherModuleProvider
		self.informationModuleProvider = informationModuleProvider
		
		tabBarRouter?.delegate = self
	}

	// MARK: - Internal methods

	func start(with deeplink: Deeplink?) {
		setupCoordinators(deeplink: deeplink)
		
		switch deeplink {
		case .flights:
			openFlights()
			
		case .none:
			openMainPage()
		}
		
		registerRoutes()
	}
	
	func handle(deeplink: Deeplink) {
		switch deeplink {
		case .flights:
			guard
				let flightsModule = childModules.lazy.compactMap({ $0 as? FlightsModule }).first
			else { return }
			
			router.dismissModule { [weak self] in
				guard let self else { return }
				
				openFlights()
				
				flightsModule.handle(deeplink: deeplink)
			}
		}
	}
	
	// MARK: - Private methods
	
	private func openMainPage() {
		tabBarRouter?.selectPage(index: .zero)
	}
	
	private func openFlights() {
		let flightTabIndex = ApplicationConfiguration.current.tabsToDisplay.firstIndex(of: .flights)
		
		tabBarRouter?.selectPage(index: flightTabIndex ?? .zero)
	}
	
	private func setupCoordinators(deeplink: Deeplink?) {
		let configuration = ApplicationConfiguration.current
		
		configuration.tabsToDisplay.forEach { tab in
			switch tab {
			case .flights:
				setupFlightsModule(deeplink: deeplink)
				
			case let .other(parameters):
				setupOtherModule(parameters: parameters)
			}
		}
		
		setupInformationModule(
			for: configuration.informationScreenConfiguration
		)
		
		tabBarRouter?.delegate = self
		tabBarRouter?.setRoot(
			modules: childModules,
			animated: true
		)
	}
	
	private func setupFlightsModule(deeplink: Deeplink?) {
		childModules.append(
			flightsModuleProvider.module(deeplink: deeplink)
		)
	}
	
	private func setupOtherModule(parameters: OtherScreenParameters) {
		childModules.append(
			otherModuleProvider.module(
				for: parameters
			)
		)
	}
	
	private func setupInformationModule(for informationScreenConfiguration: InformationScreenConfiguration) {
		childModules.append(
			informationModuleProvider.module(
				for: informationScreenConfiguration
			)
		)
	}
	
	private func registerRoutes() {
		let routeProvider = Configuration.current.routeProvider
		
		routeProvider.register(destination: .flightsCoordinator) { [weak self] in
			guard let self else { return }
			
			openFlightsTab()
		}
	}
	
	private func openFlightsTab() {
		guard
			let flightsTabIndex = childModules.firstIndex(where: { $0 is FlightsModule })
		else {
			return
		}
		
		tabBarRouter?.selectPage(index: flightsTabIndex)
	}
}

// MARK: - TabBarRouterDelegate

extension TabsCoordinatorImpl: TabBarRouterDelegate {
	
	// MARK: - Internal methods
	
	func tabbarIndexDidChange(index: Int) {
		guard
			childModules.indices.contains(index),
			let trackableScreen = childModules[index] as? TrackableScreen
		else {
			return
		}
		
		trackableScreen.trackOpen(from: .tabBar)
	}
}
