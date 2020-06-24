//
//  NotificationService.swift
//  NotificationServiceExtension
//
//  Created by Balu Naik on 6/23/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UserNotifications

final class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        // Action button on notification
        let likeButton = UNNotificationAction(identifier: "Like", title: "Like this", options: [])
        let openButton = UNNotificationAction(identifier: "Open", title: "Open Category", options: [])
        // Action should handle in AppDelegate class
        
        let category = UNNotificationCategory(identifier: "MyCategory", actions: [likeButton,openButton], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        defer {
            contentHandler(bestAttemptContent ?? request.content)
        }
        
        guard let attachemnt = request.attachment else {
            return
        }
        bestAttemptContent?.attachments = [attachemnt]
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}

/*
    * Check if an image URL exists
    * Download the image and save to disk
    * Attach the image file URL to the notification
    * Send back the modified notification
 */

extension UNNotificationRequest {
    var attachment: UNNotificationAttachment? {
        guard let attachmentURL = content.userInfo["image_url"] as? String, let imageData = try? Data(contentsOf: URL(string: attachmentURL)!) else {
            return nil
        }
        return try? UNNotificationAttachment(data: imageData, options: nil)
    }
}

extension UNNotificationAttachment {

    convenience init(data: Data, options: [NSObject: AnyObject]?) throws {
        let fileManager = FileManager.default
        let temporaryFolderName = ProcessInfo.processInfo.globallyUniqueString
        let temporaryFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(temporaryFolderName, isDirectory: true)

        try fileManager.createDirectory(at: temporaryFolderURL, withIntermediateDirectories: true, attributes: nil)
        let imageFileIdentifier = UUID().uuidString + ".jpg"
        let fileURL = temporaryFolderURL.appendingPathComponent(imageFileIdentifier)
        try data.write(to: fileURL)
        try self.init(identifier: imageFileIdentifier, url: fileURL, options: options)
    }
}
