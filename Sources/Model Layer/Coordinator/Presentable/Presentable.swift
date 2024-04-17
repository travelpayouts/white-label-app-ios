//
//  Presentable.swift
//  travel-app
//
//  Created by Nikita on 22.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

import UIKit

protocol Presentable: AnyObject {
	var toPresent: UIViewController? { get }
}

// MARK: - Default implementation

extension UIViewController: Presentable {
	
	// MARK: - Internal properties
	
	var toPresent: UIViewController? {
		self
	}
}
