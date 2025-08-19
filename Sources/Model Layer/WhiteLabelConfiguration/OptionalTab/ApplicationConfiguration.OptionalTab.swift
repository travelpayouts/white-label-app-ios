//
//  ApplicationConfiguration.OptionalTab.swift
//  travel-app
//
//  Created by Nikita on 07.06.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import UIKit
import WLConfig

extension ApplicationConfiguration {
	
	enum OptionalTab: Equatable {
		case flights
		case other(parameters: OtherParameters)
	}
}

// MARK: - Nested types

extension ApplicationConfiguration.OptionalTab {
	
	struct OtherParameters: Equatable {
		
		// MARK: - Internal properties
		
		let icon: UIImage?
		let title: LocalizedStringContainer
		let url: LocalizedUrlContainer
	}
}

// MARK: - Visible by default

extension ApplicationConfiguration.OptionalTab {
	static let visibleByDefault: [ApplicationConfiguration.OptionalTab] = [.flights]
}
