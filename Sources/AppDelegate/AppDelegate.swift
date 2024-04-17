//
//  Copyright © 2020 CleverPumpkin. All rights reserved.
//

import Foundation
import UIKit

@UIApplicationMain
final class AppDelegate: PluggableAppDelegate, ConfigurableAppDelegate {
	
	// MARK: - Internal properties
	
	var window: UIWindow?
	var rootComponent: RootComponent?
	var rootCoordinator: Coordinator?
	
	lazy var privatePlugins: [AppDelegatePlugin] = {
		var plugins: [AppDelegatePlugin] = [
			ConfigurationAppDelegatePlugin(appDelegate: self),
			BootstrapAppDelegatePlugin(appDelegate: self),
			DebugAppDelegatePlugin(appDelegate: self),
			FirebaseAppDelegatePlugin(appDelegate: self),
			AdvertisingAppDelegatePlugin(appDelegate: self),
			AppsFlyerAppDelegatePlugin(appDelegate: self)
		]
		
		return plugins
	}()
	
	override var plugins: [AppDelegatePlugin] {
		return self.privatePlugins
	}
}
