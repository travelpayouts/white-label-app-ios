//
//  FlightsModuleComponent.swift
//  travel-app-ios
//
//  Created by Nikita on 25/03/2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import NeedleFoundation

// MARK: - Dependencies

protocol FlightsModuleDependency: Dependency {}

// MARK: - Provider

protocol FlightsModuleProvider {
	var module: FlightsModule { get }
}

// MARK: - Component

final class FlightsModuleComponent: Component<FlightsModuleDependency>, FlightsModuleProvider {
	
	// MARK: - Module
	
	var module: FlightsModule {
		FlightsModule()
	}
}
