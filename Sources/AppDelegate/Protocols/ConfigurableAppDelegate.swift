//
//  Copyright © 2020 CleverPumpkin. All rights reserved.
//

import UIKit
import NeedleFoundation

protocol ConfigurableAppDelegate: AnyObject {
	var window: UIWindow? { get set }
	var rootComponent: RootComponent? { get set }
	var rootCoordinator: Coordinator? { get set }
}
