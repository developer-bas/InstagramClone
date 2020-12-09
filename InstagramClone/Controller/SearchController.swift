//
//  SearchController.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 25/11/20.
//

import UIKit

private let reuseIdentifier = "UserCell"
class SearchController: UITableViewController {
    
//    MARK: - Properties
    private var users = [User]()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
      
    }
//    MARK: - API
    func fetchUsers(){
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
//    MARK: - Helpers
    func configureTableView(){
        view.backgroundColor = .white
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
    }
}

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        
        cell.backgroundColor = .white
        return cell
    }
    
    
}
