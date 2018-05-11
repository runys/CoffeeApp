//
//  NotificationService.swift
//  NotificationsService
//
//  Created by Domenico Tangredi on 16/04/2018.
//  Copyright © 2018 Domenico Tangredi. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent  = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        guard let bestAttemptContent = bestAttemptContent, //
          
            let attachmentURLAsString = bestAttemptContent.userInfo["attachment-url"] as? String, // get the attachment-url
            let coffeShopName = bestAttemptContent.userInfo["coffeShopName"] as? String,
            let coffeName = bestAttemptContent.userInfo["coffeName"]  as? String,
            let attachmentURL = URL(string: attachmentURLAsString) else { // parse attachment to URL
                
            return
        }
        
        
        bestAttemptContent.title    = "New Deal!"
        bestAttemptContent.subtitle = coffeName
        bestAttemptContent.body     = coffeShopName
        
//    You can add also here customAction
//        //        .customDismissAction new options in ios 10
        
        // Download the image and pass it to attachments if not nil
        downloadImageFrom(url: attachmentURL) { (attachment) in
            if attachment != nil {
                bestAttemptContent.attachments = [attachment!]
                contentHandler(bestAttemptContent)
            }
        }
        
    }
    
}

// MARK: - Helper Functions
// FROM https://medium.com/flawless-app-stories/ios-remote-push-notifications-in-a-nutshell-d05f5ccac252
// to  be adapted
extension NotificationService {

    /// Use this function to download an image and present it in a notification
    ///
    /// - Parameters:
    ///   - url: the url of the picture
    ///   - completion: return the image in the form of UNNotificationAttachment to be added to the bestAttemptContent attachments eventually
    private func downloadImageFrom(url: URL, with completionHandler: @escaping (UNNotificationAttachment?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { (downloadedUrl, response, error) in
            // Test URL and escape if URL not OK
            guard let downloadedUrl = downloadedUrl else {
                completionHandler(nil)
                return
            }
            
            // Get current's user temporary directory path
            var urlPath = URL(fileURLWithPath: NSTemporaryDirectory())
            // Add proper ending to url path, in the case .jpg (The system validates the content of attached files before scheduling the corresponding notification request. If an attached file is corrupted, invalid, or of an unsupported file type, the notification request is not scheduled for delivery. )
            let uniqueURLEnding = ProcessInfo.processInfo.globallyUniqueString + ".jpg"
            urlPath = urlPath.appendingPathComponent(uniqueURLEnding)
            
            // Move downloadedUrl to newly created urlPath
            try? FileManager.default.moveItem(at: downloadedUrl, to: urlPath)
            
            // Try adding getting the attachment and pass it to the completion handler
            do {
                let attachment = try UNNotificationAttachment(identifier: "picture", url: urlPath, options: nil)
                completionHandler(attachment)
            }
            catch {
                completionHandler(nil)
            }
        }
        task.resume()
    }
}
