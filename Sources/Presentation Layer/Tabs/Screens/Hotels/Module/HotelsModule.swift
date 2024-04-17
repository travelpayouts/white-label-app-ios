//
//  HotelsModule.swift
//  travel-app-ios
//
//  Created by Nikita on 25/03/2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import WLHotels
import WLSupport

final class HotelsModule: HotelsModuleCore {
	
	// MARK: - Private properties
	
	private let viewController: UIViewController
	
	// MARK: - Initialization
	
	init() {
		viewController = WLHotels.ScreenProvider.shared.hotelsViewController
		
		viewController.tabBarItem = ESTabBarItem(
			title: R.string.tabBar.hotels_tab_title(),
			moduleIcon: moduleIcon
		)
	}
}

// MARK: - Presentable

extension HotelsModule: Presentable {
	
	// MARK: - Internal properties
	
	var toPresent: UIViewController? {
		viewController
	}
}
