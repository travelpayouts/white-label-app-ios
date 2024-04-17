//
//  DebugAppDelegatePlugin.swift
//  travel-app
//
//  Created by Gleb on 16.03.2021.
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//
// swiftlint:disable discouraged_optional_collection

import Foundation
import UIKit

#if canImport(WLDebug)
import WLDebug
#endif

final class DebugAppDelegatePlugin: UIResponder {
	
	// MARK: - Private properties
	
	private weak var appDelegate: ConfigurableAppDelegate?
	
	// MARK: - Initialization
	
	init(appDelegate: ConfigurableAppDelegate) {
		self.appDelegate = appDelegate
		
		super.init()
	}
	
	// MARK: - Internal methods
	
#if canImport(WLDebug)
	override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		let viewController = WLDebug.ScreenProvider.shared.debugViewController { [weak self] in
			guard let self else {
				return nil
			}
			
			return appDelegate?
				.rootComponent?
				.coreComponent
				.servicesComponent
				.pushNotificationsService
				.output
				.fcmToken
		}
		
		let debugModule = GenericModule(
			toPresent: viewController
		)
		
		appDelegate?
			.rootCoordinator?
			.router
			.present(module: debugModule)
	}
#endif
}

// MARK: - UIApplicationDelegate

extension DebugAppDelegatePlugin: UIApplicationDelegate {
	
	// MARK: - Internal methods
	
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		return true
	}
}
