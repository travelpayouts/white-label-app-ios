//
//  FirebaseAppDelegatePlugin.swift
//  travel-app
//
//  Created by Nikita on 31.05.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAnalytics
import FirebaseMessaging
import WLNetwork

// MARK: - Plugin

final class FirebaseAppDelegatePlugin: AppDelegatePlugin {
	
	// MARK: - Private properties
	
	private weak var appDelegate: ConfigurableAppDelegate?
	
	private var pushNotificationsService: PushNotificationsService? {
		appDelegate?.rootComponent?.coreComponent.servicesComponent.pushNotificationsService
	}
	
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
		
		FirebaseApp.configure()
		pushNotificationsService?.input.requestAuthorization(for: application)
		
		return true
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		pushNotificationsService?.input.update(apnsToken: deviceToken)
	}
}
