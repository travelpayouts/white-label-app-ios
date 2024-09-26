//
//  AdvertisingAppDelegatePlugin.swift
//  travel-app
//
//  Created by Nikita on 01.12.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import UIKit
#if canImport(Appodeal)
import Appodeal
import AppTrackingTransparency
#endif

// MARK: - Plugin

final class AdvertisingAppDelegatePlugin: AppDelegatePlugin {
	
	// MARK: - Private properties
	
	private weak var appDelegate: ConfigurableAppDelegate?
	
	// MARK: - Initialization
	
	init(appDelegate: ConfigurableAppDelegate) {
		self.appDelegate = appDelegate
		
		super.init()
	}
	
	// MARK: - Internal methods
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		setup()
	}
	
	// MARK: - Private methods
	
	private func setup() {
		#if canImport(Appodeal)
		guard let appodealKey = ApplicationConfiguration.current.constants.appodealApiKey else {
			return
		}
		
		ATTrackingManager.requestTrackingAuthorization { _ in
			Appodeal.setAutocache(
				true,
				types: Constants.defaultAdTypes
			)
			
			#if DEBUG
			Appodeal.setLogLevel(.verbose)
			#endif
			
			DispatchQueue.main.async {
				Appodeal.initialize(
					withApiKey: appodealKey,
					types: Constants.defaultAdTypes
				)
			}
		}
		#endif
	}
}

#if canImport(Appodeal)
// MARK: - Constants

private extension AdvertisingAppDelegatePlugin {
	
	enum Constants {
	
		static let defaultAdTypes: AppodealAdType = [.banner, .interstitial]
	}
}
#endif
