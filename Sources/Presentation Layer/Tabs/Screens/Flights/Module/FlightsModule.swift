//
//  FlightsModule.swift
//  travel-app-ios
//
//  Created by Nikita on 25/03/2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import WLFlights
import WLSupport

final class FlightsModule: FlightsModuleCore {
	
	// MARK: - Private properties
	
	private let viewController: UIViewController
	
	// MARK: - Initialization
	
	init() {
		viewController = WLFlights.ScreenProvider.shared.flightsViewController()
		
		viewController.tabBarItem = ESTabBarItem(
			title: R.string.tabBar.flights_tab_title(),
			moduleIcon: moduleIcon
		)
	}
}

// MARK: - Presentable

extension FlightsModule: Presentable {
	
	// MARK: - Internal properties
	
	var toPresent: UIViewController? {
		viewController
	}
}
