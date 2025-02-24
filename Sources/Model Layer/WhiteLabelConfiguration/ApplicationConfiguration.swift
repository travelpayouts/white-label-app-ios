//
//  WhiteLabelConfiguration.swift
//  travel-app
//
//  Created by Nikita on 07.06.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import Foundation
import os
import WLInformation

struct ApplicationConfiguration {
	
	// MARK: - Internal properties
	
	let tabsToDisplay: [OptionalTab]
	let informationScreenConfiguration: InformationScreenConfiguration
	let constants: Constants
	
	// MARK: - Private static properties
	
	private static let configurationLock = NSLock()
	private static var activeConfiguration: ApplicationConfiguration?
	private static let logger = Logger()
	
	// MARK: - Initialization
	
	init(
		tabs tabsContainer: TabsConfigurationContainer,
		informationScreenConfiguration: InformationScreenConfiguration,
		constants: Constants
	) {
		self.tabsToDisplay = tabsContainer.tabs
		self.informationScreenConfiguration = informationScreenConfiguration
		self.constants = constants
	}
	
	// MARK: - Private initialization
	
	private init() {
		self.tabsToDisplay = OptionalTab.visibleByDefault
		self.informationScreenConfiguration = InformationScreenConfiguration()
		self.constants = .init()
	}
}

// MARK: - Current

extension ApplicationConfiguration {
	
	// MARK: - Internal static properties
	
	static var current: ApplicationConfiguration {
		if let activeConfiguration {
			return activeConfiguration
		}
		
		logger.critical("⚠️ The Application is not configured. Please set up the configuration using the ApplicationConfiguration.setup(with:) method at the application startup.")
		
		let emptyConfiguration = ApplicationConfiguration()
		
		setup(with: emptyConfiguration)
		
		return emptyConfiguration
	}
	
	// MARK: - Private static methods
	
	static func setup(with configuration: ApplicationConfiguration) {
		configurationLock.lock()
		defer { configurationLock.unlock() }
		
		guard activeConfiguration == nil else {
			return
		}
		
		activeConfiguration = configuration
	}
}

// MARK: - Equatable

extension ApplicationConfiguration: Equatable { }
