//
//  PusheNotificationsService.swift
//  travel-app
//
//  Created by Nikita on 29.11.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import Foundation
import FirebaseMessaging
import WLUserInterface

typealias PushNotificationsServiceDeeplinkHandler = (Deeplink) -> Void

// MARK: - Interface

protocol PushNotificationsService: AnyObject {
	var input: PushNotificationsServiceInput { get }
	var output: PushNotificationsServiceOutput { get }
}

protocol PushNotificationsServiceInput: AnyObject {
	func requestAuthorization(for application: UIApplication)
	func update(apnsToken: Data)
	func set(deeplinkHandler: @escaping PushNotificationsServiceDeeplinkHandler)
}

protocol PushNotificationsServiceOutput: AnyObject {
	
	var fcmToken: String? { get }
}

// MARK: - Implementation

final class PushNotificationsServiceImpl: NSObject, PushNotificationsService {
	
	// MARK: - Internal properties
	
	var input: PushNotificationsServiceInput { self }
	var output: PushNotificationsServiceOutput { self }
	
	// MARK: - Private properties
	
	private var firebaseDeviceToken: String?
	
	private var notificationCenter: UNUserNotificationCenter {
		.current()
	}
	
	private var firebaseMessaging: Messaging {
		.messaging()
	}
	
	private var deeplinkHandler: PushNotificationsServiceDeeplinkHandler?
	
	// MARK: - Initialization
	
	override init() {
		super.init()
		
		setup()
	}
	
	// MARK: - Private methods
	
	private func setup() {
		
		notificationCenter.delegate = self
		firebaseMessaging.delegate = self
	}
}

// MARK: - UNUserNotificationCenterDelegate

extension PushNotificationsServiceImpl: UNUserNotificationCenterDelegate {
	
	// MARK: - Internal methods
	
	func userNotificationCenter(
		_ center: UNUserNotificationCenter,
		willPresent notification: UNNotification,
		withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
	) {
		completionHandler(Constants.defaultNotificationPresentationOptions)
	}
	
	func userNotificationCenter(
		_ center: UNUserNotificationCenter,
		didReceive response: UNNotificationResponse,
		withCompletionHandler completionHandler: @escaping () -> Void
	) {
		if let deeplink = Deeplink.build(with: response) {
			deeplinkHandler?(deeplink)
		}
		
		completionHandler()
	}
}

// MARK: - MessagingDelegate

extension PushNotificationsServiceImpl: MessagingDelegate {
	
	// MARK: - Internal methods
	
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
		firebaseDeviceToken = fcmToken
	}
}

// MARK: - PushesServiceInput

extension PushNotificationsServiceImpl: PushNotificationsServiceInput {
	
	// MARK: - Internal methods
	
	func requestAuthorization(for application: UIApplication) {
		
		notificationCenter.requestAuthorization(
			options: Constants.defaultAuthorizationOptions,
			completionHandler: { _, _ in }
		)
		
		application.registerForRemoteNotifications()
	}
	
	func update(apnsToken: Data) {
		firebaseMessaging.apnsToken = apnsToken
	}
	
	func set(deeplinkHandler: @escaping PushNotificationsServiceDeeplinkHandler) {
		self.deeplinkHandler = deeplinkHandler
	}
}

// MARK: - PushesServiceOutput

extension PushNotificationsServiceImpl: PushNotificationsServiceOutput {
	
	// MARK: - Internal properties
	
	var fcmToken: String? {
		firebaseDeviceToken
	}
}

// MARK: - Constants

private extension PushNotificationsServiceImpl {
	
	enum Constants {
		
		static let defaultAuthorizationOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
		static let defaultNotificationPresentationOptions: UNNotificationPresentationOptions = [.banner, .sound]
	}
}
