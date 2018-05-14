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
        
        guard let attachment = notification.request.content.attachments.first else { return }
        
        // Get the attachment and set the image view.
        if attachment.url.startAccessingSecurityScopedResource(),
            let data = try? Data(contentsOf: attachment.url) {
//            coffeImage.contentMode = .scaleAspectFit
            coffeImage.image = UIImage(data: data)
            attachment.url.stopAccessingSecurityScopedResource()
        }
        

        if let coffeName = content.userInfo["coffeName"] as? String,
            let coffeShopName = content.userInfo["coffeShopName"] as? String,
            let discountedPrice = content.userInfo["discountedPrice"] as? String,
            let fullPrice = content.userInfo["fullPrice"] as? String {
        
        self.coffeName.text = coffeName
        self.coffeShopName.text = coffeShopName
        self.discountedPrice.text = discountedPrice
        self.fullPrice.text = fullPrice
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
//        server.postEventResponse(response)
        if response.actionIdentifier == "likeAction"{
            self.view.backgroundColor = .green
                  completion(.doNotDismiss)
        } else if response.actionIdentifier == "dislikeAction" {
            self.view.backgroundColor = .red
            completion(.doNotDismiss)
        } else  { // comment
            completion(.doNotDismiss)
        }
    }
    
    

}
