//
//  NotificationViewController.swift
//  NotificationViewController
//
//  Created by Domenico Tangredi on 10/05/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    
    @IBOutlet weak var discountedPrice: UILabel!
    @IBOutlet weak var fullPrice: UILabel!
    @IBOutlet weak var coffeName: UILabel!
    @IBOutlet weak var coffeShopName: UILabel!
    @IBOutlet weak var coffeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        let  size  = view.bounds.size
        preferredContentSize = CGSize(width: size.width, height: 94)
    }
    
    func didReceive(_ notification: UNNotification) {
       let content = notification.request.content
        
        // Check if there is there is an attachment and if not return.
        guard let attachment = notification.request.content.attachments.first else { return }
        
        // Get the attachment and set the image view.
        if attachment.url.startAccessingSecurityScopedResource(),
            let data = try? Data(contentsOf: attachment.url) {
            coffeImage.image = UIImage(data: data)
            attachment.url.stopAccessingSecurityScopedResource()
        }
        
        // Get the information sent through the payload.
        if let coffeName = content.userInfo["coffeName"] as? String,
            let coffeShopName = content.userInfo["coffeShopName"] as? String,
            let discountedPrice = content.userInfo["discountedPrice"] as? String,
            let fullPrice = content.userInfo["fullPrice"] as? String {
            
        // Create Custom Actions
        registerCoffeeDealNotificationActions()
        
        // Set the labels of the long-look notification
        self.coffeName.text = coffeName
        self.coffeShopName.text = coffeShopName
        self.discountedPrice.text = discountedPrice
        self.fullPrice.text = fullPrice
        }
    }
    
    // Handle the custom action when the long-look notification appear.
    // It is possible to update the notification appearance according to the selected action.
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        // You can here send also the response to the server, e.g., server.postEventResponse(response), if needed.
        if response.actionIdentifier == "likeAction"{
            self.view.backgroundColor = .green
                  completion(.doNotDismiss)
        } else if response.actionIdentifier == "dislikeAction" {
            self.view.backgroundColor = .red
            completion(.doNotDismiss)
        } else  { 
            completion(.doNotDismiss)
        }
    }
    
    

}

extension NotificationViewController {
    func registerCoffeeDealNotificationActions() {
        // 1.
        let likeAction =
            UNNotificationAction(identifier: "likeAction",
                                 title: "Like",
                                 options: [.authenticationRequired, .foreground])
        
        let dislikeAction =
            UNNotificationAction(identifier: "dislikeAction",
                                 title: "Dislike",
                                 options: [.authenticationRequired, .foreground])
        
        let commentAction =
            UNTextInputNotificationAction(identifier: "comment-action",
                                          title: "Comment",
                                          options: [.authenticationRequired, .foreground],
                                          textInputButtonTitle: "Post",
                                          textInputPlaceholder: "Comment")
        
        // 2.
        let dealCategory =
            UNNotificationCategory(identifier: "newCoffeeDealNotification",
                                   actions: [likeAction,dislikeAction, commentAction],
                                   intentIdentifiers: [],
                                   options: [])
        
        // 3.
        UNUserNotificationCenter.current()
            .setNotificationCategories([dealCategory])
    }
}



