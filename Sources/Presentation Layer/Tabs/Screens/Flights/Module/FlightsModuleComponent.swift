//
//  FlightsModuleComponent.swift
//  travel-app-ios
//
//  Created by Nikita on 25/03/2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import NeedleFoundation
import WLUserInterface

// MARK: - Dependencies

protocol FlightsModuleDependency: Dependency {}

// MARK: - Provider

protocol FlightsModuleProvider {
	func module(deeplink: Deeplink?) -> FlightsModule
}

// MARK: - Component

final class FlightsModuleComponent: Component<FlightsModuleDependency>, FlightsModuleProvider {
	
	// MARK: - Module
	
	func module(deeplink: Deeplink?) -> FlightsModule {
		FlightsModule(deeplink: deeplink)
	}
}
