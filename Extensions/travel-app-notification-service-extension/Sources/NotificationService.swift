//
//  NotificationService.swift
//  travel-app-notification-service-extension
//
//  Created by Nikita on 29.11.2023.
//  Copyright © 2023 CleverPumpkin. All rights reserved.
//

import UserNotifications
import FirebaseMessaging

final class NotificationService: UNNotificationServiceExtension {
		
	// MARK: - Private properties

	private var contentHandler: ((UNNotificationContent) -> Void)?
	private var bestAttemptContent: UNMutableNotificationContent?
	
	// MARK: - Internal methods

	override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
		self.contentHandler = contentHandler
		self.bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
		
		guard let bestAttemptContent else {
			return
		}
		
		Messaging.serviceExtension().populateNotificationContent(
			bestAttemptContent, 
			withContentHandler: contentHandler
		)
	}
	
	override func serviceExtensionTimeWillExpire() {
		guard let contentHandler, let bestAttemptContent else {
			return
		}
		
		contentHandler(bestAttemptContent)
	}
}
