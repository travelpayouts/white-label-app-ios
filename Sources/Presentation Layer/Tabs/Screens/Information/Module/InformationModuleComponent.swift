//
//  InformationModuleComponent.swift
//  travel-app-ios
//
//  Created by Nikita on 25/03/2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import NeedleFoundation
import WLInformation

// MARK: - Dependencies

protocol InformationModuleDependency: Dependency {}

// MARK: - Provider

protocol InformationModuleProvider {
	func module(for informationScreenConfiguration: InformationScreenConfiguration) -> InformationModule
}

// MARK: - Component

final class InformationModuleComponent: Component<InformationModuleDependency>, InformationModuleProvider {
	
	// MARK: - Module
	
	func module(for informationScreenConfiguration: InformationScreenConfiguration) -> InformationModule {
		InformationModule(for: informationScreenConfiguration)
	}
}
