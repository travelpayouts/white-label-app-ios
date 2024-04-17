//
//  Array+Logical.swift
//  travel-app
//
//  Created by Nikita on 25.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

extension Array where Element == Bool {
	
	// MARK: - Public methods
	
	func logicalAnd() -> Bool {
		allSatisfy { $0 == true }
	}
	
	func logicalOr() -> Bool {
		first { $0 } ?? false
	}
}
