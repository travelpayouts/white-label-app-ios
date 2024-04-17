//
//  ServicesComponent.swift
//
//  Created by Kristina Shevtsova on 13.07.2021.
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//

import WLNetwork
import WLPersistence
import NeedleFoundation

protocol ServicesDependency: Dependency { }

final class ServicesComponent: Component<ServicesDependency> {
	
	// MARK: - Services
	
	//  swiftlint:disable:next lower_acl_than_parent
	public var pushNotificationsService: PushNotificationsService {
		shared {
			PushNotificationsServiceImpl()
		}
	}
	
	#if canImport(AppsFlyerLib)
	//  swiftlint:disable:next lower_acl_than_parent
	public var appsFlyerService: AppsFlyerService {
		shared { AppsFlyerServiceImpl() }
	}
	#endif
	
	// MARK: - Child components
	
	var appCoordinatorComponent: AppCoordinatorComponent {
		AppCoordinatorComponent(parent: self)
	}
}
