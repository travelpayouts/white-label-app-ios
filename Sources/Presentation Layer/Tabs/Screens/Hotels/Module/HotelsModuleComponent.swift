//
//  HotelsModuleComponent.swift
//  travel-app-ios
//
//  Created by Nikita on 25/03/2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import NeedleFoundation

// MARK: - Dependencies

protocol HotelsModuleDependency: Dependency {}

// MARK: - Provider

protocol HotelsModuleProvider {
	var module: HotelsModule { get }
}

// MARK: - Component

final class HotelsModuleComponent: Component<HotelsModuleDependency>, HotelsModuleProvider {
	
	// MARK: - Module
	
	var module: HotelsModule {
		HotelsModule()
	}
}
