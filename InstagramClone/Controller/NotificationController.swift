//
//  NotificationController.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 25/11/20.
//

import UIKit

private let reuseIdentifier = "NotificationCell"

class NotificationController: UITableViewController {
    
//    MARK: - Properties
    private var notifications = [Notification]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchNotifications()
    }
//    MARK: - API
    func fetchNotifications(){
        NotificationService.fetchNotification { notifications in
            self.notifications = notifications
            print("DEBUG: NOTIFICATIONS")
        }
    }
    
    
//    MARK: - Helpers
    func configureTableView(){
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        
    }
    
    
    
}

extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  notifications.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        
        cell.backgroundColor = .systemPurple
        
        return cell
    }
}
