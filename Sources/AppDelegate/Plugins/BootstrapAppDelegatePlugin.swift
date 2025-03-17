//
//  BootstrapAppDelegatePlugin.swift
//  travel-app
//
//  Created by Gleb on 15.03.2021.
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//
// swiftlint:disable discouraged_optional_collection

import Foundation
import UIKit
import NeedleFoundation

/// AppDelegate plugin for initial environment setup
/// Setups root component (DI) and application coordinator (navigation)
final class BootstrapAppDelegatePlugin: UIResponder {
	
	// MARK: - Private properties
	
	private weak var appDelegate: ConfigurableAppDelegate?
	
	// MARK: - Initialization/Deinitialization
	
	init(appDelegate: ConfigurableAppDelegate) {
		self.appDelegate = appDelegate
		super.init()
	}
}

// MARK: - UIApplicationDelegate protocol conformance

extension BootstrapAppDelegatePlugin: UIApplicationDelegate {
	
	// MARK: - Internal methods
	
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		registerProviderFactories()
		
		let window = UIWindow(frame: UIScreen.main.bounds)
		let rootComponent = RootComponent(rootWindow: window)
		
		appDelegate?.window = window
		appDelegate?.rootComponent = rootComponent
		appDelegate?.rootCoordinator = rootComponent.appCoordinatorProvider.appCoordinator
		
		appDelegate?.window?.makeKeyAndVisible()
		
		return true
	}
}
