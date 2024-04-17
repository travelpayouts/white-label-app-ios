//
//  AdvertisingAppDelegatePlugin.swift
//  travel-app
//
//  Created by Nikita on 01.12.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import AppTrackingTransparency
import UIKit
import Appodeal

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
	
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		setup()
		
		return true
	}
	
	// MARK: - Private methods
	
	private func setup() {
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
			
			Appodeal.initialize(
				withApiKey: appodealKey,
				types: Constants.defaultAdTypes
			)
		}
	}
}

// MARK: - Constants

private extension AdvertisingAppDelegatePlugin {
	
	enum Constants {
	
		static let defaultAdTypes: AppodealAdType = [.banner, .interstitial]
	}
}