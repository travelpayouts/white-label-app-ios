//
//  Copyright © 2020 CleverPumpkin. All rights reserved.
//
// swiftlint:disable discouraged_optional_collection

import Foundation
import UIKit

class PluggableAppDelegate: UIResponder {
	var plugins: [AppDelegatePlugin] {
		return []
	}
	
	// MARK: - Internal methods
	
	override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		plugins.forEach {
			$0.motionEnded(motion, with: event)
		}
	}
}

// MARK: - UIApplicationDelegate protocol conformance

extension PluggableAppDelegate: UIApplicationDelegate {
	
	// MARK: - Startup
	
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		let results = plugins.compactMap { handler in
			handler.application?(application, didFinishLaunchingWithOptions: launchOptions)
		}

		return results.logicalAnd()
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		plugins.forEach {
			$0.applicationDidBecomeActive?(application)
		}
	}
	
	// MARK: - Notifications
	
	func application(
		_ application: UIApplication,
		didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
	) {
		plugins.forEach {
			$0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
		}
	}
	
	func application(
		_ application: UIApplication,
		didFailToRegisterForRemoteNotificationsWithError error: Error
	) {
		plugins.forEach {
			$0.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
		}
	}
	
	func application(
		_ application: UIApplication,
		didReceiveRemoteNotification userInfo: [AnyHashable: Any],
		fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
	) {
		plugins.forEach {
			$0.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
		}
	}
	
	// MARK: - Background URL session

	func application(
		_ application: UIApplication,
		handleEventsForBackgroundURLSession identifier: String,
		completionHandler: @escaping () -> Void
	) {
		plugins.forEach {
			$0.application?(
				application,
				handleEventsForBackgroundURLSession: identifier,
				completionHandler: completionHandler
			)
		}
	}
	
	// MARK: - Open URL
	
	func application(
		_ app: UIApplication,
		open url: URL,
		options: [UIApplication.OpenURLOptionsKey: Any] = [:]
	) -> Bool {
		let results = plugins.compactMap {
			$0.application?(app, open: url, options: options)
		}
		
		return results.logicalAnd()
	}
	
	func application(
		_ application: UIApplication,
		continue userActivity: NSUserActivity,
		restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
	) -> Bool {
		let results = plugins.compactMap {
			$0.application?(
				application,
				continue: userActivity,
				restorationHandler: restorationHandler
			)
		}
		
		return results.logicalAnd()
	}
		
	// MARK: - Shortcuts

	func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
		_ = plugins.compactMap {
			$0.application?(
				application,
				performActionFor: shortcutItem,
				completionHandler: completionHandler
			)
		}
	}
}
