//
//  ApplicationConfiguration.TabsConfigurationContainer.swift
//  travel-app
//
//  Created by Nikita on 07.06.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

extension ApplicationConfiguration {
	
	struct TabsConfigurationContainer {
		
		// MARK: - Internal properties
		
		let tabs: [OptionalTab]
		
		// MARK: - Initialization
		
		init(_ tabs: OptionalTab...) {
			
			var tabsToDisplay = [OptionalTab]()
			var otherTabCount: Int = 0
			
			tabs.forEach { tab in
				
				var shouldAppendTab = true
				
				if case .other = tab {
					
					shouldAppendTab = otherTabCount < Constants.maximumOtherTabsCount
					otherTabCount += shouldAppendTab ? 1 : 0
				}
				
				guard shouldAppendTab else {
					return
				}
				
				tabsToDisplay.append(tab)
			}
			
			self.tabs = tabsToDisplay
		}
	}
}

// MARK: - Constants

private extension ApplicationConfiguration.TabsConfigurationContainer {
	
	enum Constants {
		
		static let maximumOtherTabsCount: Int = 2
	}
}
