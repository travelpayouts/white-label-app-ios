//
//  UIWindow+MotionEnded.swift
//  travel-app
//
//  Created by Nikita on 26.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import Foundation
import UIKit

#if DEBUG

extension UIWindow {
	// Overrides in extensions are bad, but acceptable for this particular case (debug use only).
	// swiftlint:disable:next override_in_extension
	open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		UIApplication.shared.next?.motionEnded(motion, with: event)
	}
}

#endif
