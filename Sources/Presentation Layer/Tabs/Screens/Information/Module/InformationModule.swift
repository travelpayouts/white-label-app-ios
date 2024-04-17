//
//  InformationModule.swift
//  travel-app-ios
//
//  Created by Nikita on 25/03/2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import WLInformation
import WLSupport

final class InformationModule: InformationModuleCore {
	
	// MARK: - Private properties
	
	private let viewController: UIViewController
	
	// MARK: - Initialization
	
	init(for informationScreenConfiguration: InformationScreenConfiguration) {
		viewController = WLInformation.ScreenProvider.shared.informationViewController(
			informationScreenConfiguration: informationScreenConfiguration
		)
		
		viewController.tabBarItem = ESTabBarItem(
			title: R.string.tabBar.info_tab_title(),
			moduleIcon: moduleIcon
		)
	}
}

// MARK: - Presentable

extension InformationModule: Presentable {
	
	// MARK: - Internal properties
	
	var toPresent: UIViewController? {
		viewController
	}
}
