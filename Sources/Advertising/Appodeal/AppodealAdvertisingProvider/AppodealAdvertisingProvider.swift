//
//  AppodealAdvertisingProvider.swift
//  travel-app
//
//  Created by Nikita on 01.12.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import UIKit
import Appodeal
import WLConfig

final class AppodealAdvertisingProvider: NSObject, AdvertisingProvider {
	
	// MARK: - Private properties
	
	private var bannerCompletions = [UIView: AdvertisingProviderBannerCompletion]()
	
	// MARK: - Internal methods
	
	func bannerView(for placement: String, complition: @escaping AdvertisingProviderBannerCompletion) {
		
		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
			
			guard
				Appodeal.isInitialized(for: .banner),
				Appodeal.canShow(.banner, forPlacement: placement)
			else {
				complition(
					.failure(AdvertisingError.cantShowAdForGivenPlacement)
				)
				
				return
			}
			
			let bannerView = makeBannerView(for: placement)
			
			bannerCompletions[bannerView] = complition
		}
	}
	
	func showInterstitial(for placement: String, in context: UIViewController) {
		
		guard
			Appodeal.isInitialized(for: .interstitial),
			Appodeal.canShow(.interstitial, forPlacement: placement)
		else {
			return
		}
		
		Appodeal.showAd(
			.interstitial,
			forPlacement: placement,
			rootViewController: context
		)
	}
}

// MARK: - APDBannerViewDelegate

extension AppodealAdvertisingProvider: APDBannerViewDelegate {
	
	// MARK: - Internal properties
	
	func bannerView(_ bannerView: APDBannerView, didFailToLoadAdWithError error: Error) {
		
		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
		
			let completion = bannerCompletions.removeValue(forKey: bannerView)
			
			completion?(
				.failure(error)
			)
		}
	}
	
	func bannerViewDidLoadAd(_ bannerView: APDBannerView, isPrecache precache: Bool) {
		
		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
		
			let completion = bannerCompletions.removeValue(forKey: bannerView)
			
			completion?(
				.success(bannerView)
			)
		}
	}
}

// MARK: - Factory

private extension AppodealAdvertisingProvider {
	
	// MARK: - Fileprivate methods
	
	func makeBannerView(for placement: String?) -> APDBannerView {
		let bannerView = APDBannerView()
		
		bannerView.placement = placement
		bannerView.delegate = self
		bannerView.loadAd()
		
		return bannerView
	}
}
