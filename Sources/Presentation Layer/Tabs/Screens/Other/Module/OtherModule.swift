//
//  OtherModule.swift
//  travel-app-ios
//
//  Created by Nikita on 25/03/2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import WLSupport

final class OtherModule {
	
	// MARK: - Private properties
	
	private let viewController: UIViewController
	
	// MARK: - Initialization
	
	init(for otherParameters: ApplicationConfiguration.OptionalTab.OtherParameters) {
		viewController = WLSupport.ScreenProvider.shared.webContaiverViewController(
			for: otherParameters.url.localized
		)
		
		viewController.tabBarItem = ESTabBarItem(
			otherParameters: otherParameters
		)
	}
}

// MARK: - Presentable

extension OtherModule: Presentable {
	
	// MARK: - Internal properties
	
	var toPresent: UIViewController? {
		viewController
	}
}
