//
//  OtherModuleComponent.swift
//  travel-app-ios
//
//  Created by Nikita on 25/03/2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import NeedleFoundation

// MARK: - Dependencies

protocol OtherModuleDependency: Dependency {}

// MARK: - Provider

protocol OtherModuleProvider {
	func module(for otherParameters: ApplicationConfiguration.OptionalTab.OtherParameters) -> OtherModule
}

// MARK: - Component

final class OtherModuleComponent: Component<OtherModuleDependency>, OtherModuleProvider {
	
	// MARK: - Module
	
	func module(for otherParameters: ApplicationConfiguration.OptionalTab.OtherParameters) -> OtherModule {
		OtherModule(for: otherParameters)
	}
}
