//
//  ESTabBarItem+Convenience.swift
//  travel-app
//
//  Created by Nikita on 26.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import ESTabBarController_swift
import WLSupport

extension ESTabBarItem {
	
	// MARK: - Initialization
	
	convenience init(title: String, moduleIcon: ModuleIcon) {
		self.init(
			TabBarItemContentView(),
			title: title,
			image: moduleIcon.active,
			selectedImage: moduleIcon.inactive
		)
	}
	
	convenience init(otherParameters: ApplicationConfiguration.OptionalTab.OtherParameters) {
		self.init(
			TabBarItemContentView(),
			title: otherParameters.title.localized,
			image: otherParameters.icon,
			selectedImage: otherParameters.icon
		)
	}
}
