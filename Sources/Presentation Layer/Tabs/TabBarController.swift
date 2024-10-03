//
//  TabBarController.swift
//
//  Created by Kristina Shevtsova on 13.07.2021.
//  Copyright © 2021 CleverPumpkin. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import WLSupport

final class TabBarController: ESTabBarController, ConfigurableTabBar {
	
	// MARK: - Initialization
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		setupUI()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Internal methods
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		
		guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
		
		configureTabBar(for: traitCollection)
	}
	
	// MARK: - Private methods
	
	private func setupUI() {
		configureTabBar(for: traitCollection)
	}
}
