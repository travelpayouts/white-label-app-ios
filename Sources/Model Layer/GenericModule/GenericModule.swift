//
//  GenericModule.swift
//  travel-app
//
//  Created by Nikita on 26.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import UIKit

final class GenericModule: Presentable {
	
	// MARK: - Internal properties
	
	var toPresent: UIViewController?
	
	// MARK: - Initialization
	
	init(toPresent: UIViewController) {
		self.toPresent = toPresent
	}
}
