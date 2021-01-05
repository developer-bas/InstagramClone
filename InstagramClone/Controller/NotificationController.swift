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
            
        }
    }
    
    func  checkIfUserIsFollowed(){
        notifications.forEach { notification in
            UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
                if let index = self.notifications.firstIndex(where: { $0.id == notification.id}){
                    self.notifications[index].userIsFollowed = isFollowed
                }
            }
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

    //MARK: - UITableViewDataSource

extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  notifications.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        
        cell.viewModel = NotificationsViewModel(notification: notifications[indexPath.row])
        cell.delegate = self
        return cell
    }
}

    //MARK: - UITableViewDelegate

extension NotificationController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

    //MARK: - NotificationCellDelegate
extension NotificationController: NotificationCellDelegate{
    func cell(_ cell: NotificationCell, wantsToFollow uid: String) {
        print("DEBUG: FOLLOW USER here")
    }
    
    func cell(_ cell: NotificationCell, wantsToUnfollow uid: String) {
        print("DEBUG: UNFOLLOW USER here")
    }
    
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String) {
        print("DEBUG: POST USER here")
    }
    
    
}
