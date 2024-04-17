//
//  AppsFlyerService.swift
//  travel-app
//
//  Created by Daniil on 28.02.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

#if canImport(AppsFlyerLib)
import AppsFlyerLib
import WLConfig

protocol AppsFlyerService {
	func setup()
	func start()
}

final class AppsFlyerServiceImpl: AppsFlyerService {
	
	// MARK: - Internal methods
	
	func setup() {
		guard
			let appsFlyerDevKey = ApplicationConfiguration.current.constants.appsFlyerDevKey,
			let appStoreId = Configuration.current.constants.appStoreId
		else { return }
		
		AppsFlyerLib.shared().appsFlyerDevKey = appsFlyerDevKey
		AppsFlyerLib.shared().appleAppID = appStoreId
	}
	
	func start() {
		AppsFlyerLib.shared().start()
	}
}
#endif
