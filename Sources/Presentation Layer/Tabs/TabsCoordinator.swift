//
//  TabsCoordinator.swift
//
//  Created by Kristina Shevtsova on 13.07.2021.
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import WLInformation
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
	private let hotelsModuleProvider: HotelsModuleProvider
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
		hotelsModuleProvider: HotelsModuleProvider,
		otherModuleProvider: OtherModuleProvider,
		informationModuleProvider: InformationModuleProvider
	) {
		self.router = router
		
		self.flightsModuleProvider = flightsModuleProvider
		self.hotelsModuleProvider = hotelsModuleProvider
		self.otherModuleProvider = otherModuleProvider
		self.informationModuleProvider = informationModuleProvider
		
		tabBarRouter?.delegate = self
		
		setupCoordinators()
	}

	// MARK: - Internal methods

	func start() {
		openMainPage()
		registerRoutes()
	}
	
	// MARK: - Private methods
	
	private func openMainPage() {
		tabBarRouter?.selectPage(index: .zero)
	}
	
	private func setupCoordinators() {
		let configuration = ApplicationConfiguration.current
		
		if configuration.tabsToDisplay.contains(.flights) {
			setupFlightsModule()
		}
		
		if configuration.tabsToDisplay.contains(.hotels) {
			setupHotelsModule()
		}
		
		configuration.otherScreenParameters.forEach { parameters in
			setupOtherModule(parameters: parameters)
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
	
	private func setupFlightsModule() {
		childModules.append(
			flightsModuleProvider.module
		)
	}
	
	private func setupHotelsModule() {
		childModules.append(
			hotelsModuleProvider.module
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
		
		routeProvider.register(destination: .hotelsCoordinator) { [weak self] in
			guard let self else { return }
			
			openHotelsTab()
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
	
	private func openHotelsTab() {
		guard
			let flightsTabIndex = childModules.firstIndex(where: { $0 is HotelsModule })
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
