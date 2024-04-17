//
//  ApplicationConfiguration.Constants.swift
//  travel-app
//
//  Created by Nikita on 26.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

extension ApplicationConfiguration {
	struct Constants {
		
		// MARK: - Internal properties
		
		let appsFlyerDevKey: String?
		let appodealApiKey: String?
		
		// MARK: - Initialization
		
		init(
			appsFlyerDevKey: String? = nil,
			appodealApiKey: String? = nil
		) {
			self.appsFlyerDevKey = appsFlyerDevKey
			self.appodealApiKey = appodealApiKey
		}
	}
}

// MARK: - Equatable

extension ApplicationConfiguration.Constants: Equatable { }
