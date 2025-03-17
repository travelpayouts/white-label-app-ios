//
//  DeeplinkAppDelegatePlugin.swift
//  travel-app
//
//  Created by Daniil D on 04.02.2025.
//  Copyright © 2025 CleverPumpkin. All rights reserved.
//

import UIKit

@_spi(CleverPumpkinInternal)
import WLUserInterface

final class DeeplinkAppDelegatePlugin: AppDelegatePlugin {
	
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
		appDelegate?.rootCoordinator?.start(with: .build(with: launchOptions))
		
		bind()
		
		return true
	}
	
	func application(
		_ application: UIApplication,
		continue userActivity: NSUserActivity,
		restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
	) -> Bool {
		appDelegate?.rootCoordinator?.handle(deeplink: .build(with: userActivity))
		
		return true
	}
	
	func application(
		_ app: UIApplication,
		open url: URL,
		options: [UIApplication.OpenURLOptionsKey: Any] = [:]
	) -> Bool {
		appDelegate?.rootCoordinator?.handle(deeplink: .build(with: url))
		
		return true
	}
	
	// MARK: - Private methods
	
	private func bind() {
		appDelegate?.rootComponent?.coreComponent.servicesComponent.pushNotificationsService.input
			.set(
				deeplinkHandler: { [weak appDelegate] deeplink in
					appDelegate?.rootCoordinator?.handle(deeplink: deeplink)
				}
			)
	}
}
