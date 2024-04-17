//
//  ConfigurationAppDelegatePlugin.swift
//  travel-app
//
//  Created by Nikita on 05.06.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import UIKit
import WLConfig
import WLFlights
import WLHotels
import WLInformation
import WLUserInterface

// MARK: - Plugin

final class ConfigurationAppDelegatePlugin: AppDelegatePlugin {
	
	// MARK: - Private properties
	
	private weak var appDelegate: ConfigurableAppDelegate?
	
	// MARK: - Inititalization
	
	init(appDelegate: ConfigurableAppDelegate) {
		self.appDelegate = appDelegate
		
		super.init()
	}
	
	// MARK: - Internal methods
	
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		Configurator.configure()
		
		let configuration = Configuration.current
		let imagesProvider = configuration.imagesProvider
		let localizationProvider = configuration.localization
		
		registerImages(in: imagesProvider)
		registerLocalizations(in: localizationProvider)
		
		return true
	}
	
	// MARK: - Private methods
	
	private func registerImages(in imagesProvider: Configuration.ImagesProvider) {
		
		imagesProvider.register(
			source: .local(
				bundle: R.image.img_search_background.bundle,
				key: R.image.img_search_background.name,
				configuration: nil
			),
			forHotelsSink: .searchScreenBackground
		)
		
		imagesProvider.register(
			source: .local(
				bundle: R.image.img_search_background.bundle,
				key: R.image.img_search_background.name,
				configuration: nil
			),
			forFlightsSink: .searchScreenBackground
		)
	}
	
	private func registerLocalizations(in localizationProvider: Configuration.Localization) {
		
		WLFlights.LocalizationTable.allCases.forEach { table in
			localizationProvider.register(bundle: .main, flightsTable: table)
		}
		
		WLHotels.LocalizationTable.allCases.forEach { table in
			localizationProvider.register(bundle: .main, hotelsTable: table)
		}
		
		WLInformation.LocalizationTable.allCases.forEach { table in
			localizationProvider.register(bundle: .main, informationTable: table)
		}
		
		WLUserInterface.LocalizationTable.allCases.forEach { table in
			localizationProvider.register(bundle: .main, commonTable: table)
		}
	}
}
