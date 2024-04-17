//
//  Coordinator.swift
//  travel-app
//
//  Created by Nikita on 22.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

protocol Coordinator: AnyObject {
	var router: Routable { get }
	
	func start()
}
