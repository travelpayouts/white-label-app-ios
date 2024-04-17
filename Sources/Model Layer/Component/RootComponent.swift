//
//  RootComponent.swift
//
//  Created by Kristina Shevtsova on 13.07.2021.
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//

import NeedleFoundation
import UIKit

final class RootComponent: BootstrapComponent {
	
	// MARK: - Public properties
	
	//  swiftlint:disable:next lower_acl_than_parent
	public let rootWindow: UIWindow
	
	// MARK: - Internal properties
	
	var appCoordinatorProvider: AppCoordinatorProvider {
		coreComponent.servicesComponent.appCoordinatorComponent
	}
	
	var coreComponent: CoreComponent {
		shared {
			CoreComponent(parent: self)
		}
	}
	
	// MARK: - Inits
	
	init(rootWindow: UIWindow) {
		self.rootWindow = rootWindow
	}
}
