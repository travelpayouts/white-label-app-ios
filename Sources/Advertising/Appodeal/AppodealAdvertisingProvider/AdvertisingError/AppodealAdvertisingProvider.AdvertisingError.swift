//  swiftlint:disable:this file_name
//
//  AppodealAdvertisingProvider.AdvertisingError.swift
//  travel-app
//
//  Created by Nikita on 08.12.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

extension AppodealAdvertisingProvider {
	
	enum AdvertisingError: Error {
		case cantShowAdForGivenPlacement
		case adNotReadyForGivenPlacement
	}
}
