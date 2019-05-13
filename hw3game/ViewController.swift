//
//  ViewController.swift
//  hw3game
//
//  Created by User16 on 2019/5/8.
//  Copyright © 2019 User16. All rights reserved.
//v

import UIKit
import SafariServices
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let debitOverdraftNotifCategory = UNNotificationCategory(identifier: "debitOverdraftNotification", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([debitOverdraftNotifCategory])
    }

    
    
    @IBAction func doNotTouch(_ sender: Any) {
        
        let controller = UIAlertController(title: "就叫你別點了！", message: "下次別再按囉！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "...好...", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    
    
    @IBAction func author(_ sender: Any) {
        if let url = URL(string: "https://medium.com/@happy199955"){
            let Controller = SFSafariViewController(url: url)
            Controller.delegate = self as? SFSafariViewControllerDelegate
            self.present(Controller, animated: true, completion: nil)
            
        }
    }
    
    
    
    @IBAction func sendNotificationButtonTapped(_ sender: Any) { UNUserNotificationCenter.current().getNotificationSettings { (settings) in
        
            guard settings.authorizationStatus == .authorized else { return }
        
            let content = UNMutableNotificationContent()
        
            content.categoryIdentifier = "debitOverdraftNotification"
        
            content.title = "快來手速一下吧！"
            content.subtitle = "好久沒玩了！手都生疏了！"
            content.body = "點點點touch touch touch~快來找回感覺呀！"
            content.sound = UNNotificationSound.default
        
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 100, repeats: false)
        
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
        
    }
}

