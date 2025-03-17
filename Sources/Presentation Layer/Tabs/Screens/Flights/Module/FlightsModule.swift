//
//  FlightsModule.swift
//  travel-app-ios
//
//  Created by Nikita on 25/03/2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import WLUserInterface
import WLFlights
import WLSupport

final class FlightsModule: FlightsModuleCore {
	
	// MARK: - Private properties
	
	private let viewController: DeeplinkResponderViewController
	
	// MARK: - Initialization
	
	init(deeplink: Deeplink?) {
		viewController = WLFlights.ScreenProvider.shared.flightsViewController(deeplink: deeplink)
		
		viewController.tabBarItem = ESTabBarItem(
			title: R.string.tabBar.flights_tab_title(),
			moduleIcon: moduleIcon
		)
	}
	
	// MARK: - Internal methods
	
	func handle(deeplink: Deeplink) {
		viewController.handle(deeplink: deeplink)
	}
}

// MARK: - Presentable

extension FlightsModule: Presentable {
	
	// MARK: - Internal properties
	
	var toPresent: UIViewController? {
		viewController
	}
}
