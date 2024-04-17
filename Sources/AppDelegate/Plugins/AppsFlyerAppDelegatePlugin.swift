//
//  AppsFlyerAppDelegatePlugin.swift
//  travel-app
//
//  Created by Daniil on 04.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import UIKit

final class AppsFlyerAppDelegatePlugin: AppDelegatePlugin {
	
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
		#if canImport(AppsFlyerLib)
		appDelegate?.rootComponent?.coreComponent.servicesComponent.appsFlyerService.setup()
		#endif
		
		return true
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		#if canImport(AppsFlyerLib)
		appDelegate?.rootComponent?.coreComponent.servicesComponent.appsFlyerService.start()
		#endif
	}
}
