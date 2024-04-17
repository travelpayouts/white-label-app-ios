//
//  TabBarItemContentView.swift
//  travel-app
//
//  Created by Daniil D on 07.03.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import ESTabBarController_swift
import WLConfig

final class TabBarItemContentView: ESTabBarItemContentView {
	
	// MARK: - Initialization
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		commonInit()
	}
	
	// MARK: - Private methods
	
	private func commonInit() {
		guard
			let defaultColor = WLConfig.R.configColors.onSurfaceSecondary,
			let highlightColor = WLConfig.R.configColors.primary
		else {
			return
		}
		
		iconColor = defaultColor
		textColor = defaultColor
		highlightIconColor = highlightColor
		highlightTextColor = highlightColor
	}
}
