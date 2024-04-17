//
//  Bindable.swift
//  travel-app
//
//  Created by Nikita on 25.03.2024.
//  Copyright © 2024 CleverPumpkin. All rights reserved.
//

protocol Bindable: AnyObject {
	associatedtype ViewModel
	
	var viewModel: ViewModel { get }
	
	init(viewModel: ViewModel)
}
