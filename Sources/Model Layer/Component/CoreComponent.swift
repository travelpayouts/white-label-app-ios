//
//  CoreComponent.swift
//
//  Created by Kristina Shevtsova on 13.07.2021.
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//

import WLCommon
import WLNetwork
import WLPersistence
import Moya
import NeedleFoundation

protocol CoreDependency: Dependency { }

final class CoreComponent: Component<CoreDependency> {
	
	// MARK: - Internal properties
	
	var servicesComponent: ServicesComponent {
		shared {
			ServicesComponent(parent: self)
		}
	}
}
