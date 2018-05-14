//
//  NotificationService.swift
//  NotificationsService
//
//  Created by Domenico Tangredi on 16/04/2018.
//  Copyright © 2018 Domenico Tangredi. All rights reserved.
//

import UserNotifications
import MobileCoreServices

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    var currentDownloadTask: URLSessionDownloadTask?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent  = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let mutableContent = bestAttemptContent,
            let attachmentURLAsString = mutableContent.userInfo["attachment-url"] as? String, // get the attachment-url
            let coffeShopName = mutableContent.userInfo["coffeShopName"] as? String,
            let coffeName = mutableContent.userInfo["coffeName"]  as? String,
            let url = URL(string: attachmentURLAsString){
            // Create a download task using the url passed in the push payload.
            currentDownloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { fileURL, _, error in
                if let error = error {
                    // Handle the case where the download task fails.
                    NSLog("download task failed with \(error)")
                } else {
                    // Handle the case where the download task succeeds.
                    if let fileURL = fileURL,
                        // Temporary files usually do not have a type extension, so get the type of the original url.
                        let fileType = NotificationService.fileType(fileExtension: url.pathExtension),
                        // Pass the type as type hint key to help out.
                        let attachment = try? UNNotificationAttachment(identifier: "pushAttachment", url: fileURL, options: [UNNotificationAttachmentOptionsTypeHintKey: fileType]) {
                        // Add the attachment to the notification content.
                        mutableContent.attachments = [attachment]
                    }
                }
                // Serve the notification ASAP so we don't block notification delivery for our app.
                contentHandler(mutableContent)
            })
            
            // Begin download task.
            currentDownloadTask?.resume()
            mutableContent.title    = "New Deal!"
            mutableContent.subtitle = coffeName
            mutableContent.body     = coffeShopName
        }
    }
    
    
    override func serviceExtensionTimeWillExpire() {
        // Cancel running download task.
        if let downloadTask = currentDownloadTask {
            downloadTask.cancel()
        }
    }
    
    // Helper function to get a kUTType from a file extension.
    class func fileType(fileExtension: String) -> CFString? {
        return UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension as CFString, nil)?.takeRetainedValue()
    }
}


