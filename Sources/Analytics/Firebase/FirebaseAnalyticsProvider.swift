//
//  FirebaseAnalyticsProvider.swift
//  travel-app
//
//  Created by Nikita on 12.12.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import FirebaseAnalytics
import WLConfig

final class FirebaseAnalyticsProvider: AnalyticsProvider {
	
	// MARK: - Internal methods
	
	func log(event: String, with parameters: [String: Any]?) {
		
		FirebaseAnalytics.Analytics.logEvent(
			event,
			parameters: parameters
		)
	}
}
