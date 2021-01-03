//
//  FeedController.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 25/11/20.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {
    
//    MARK: - Properties
    
    private var posts = [Post]()
    var post : Post?
    
//  MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchPosts()
    }
//    MARK: - Actions
    @objc func handleRefresh(){
        posts.removeAll()
        fetchPosts()
    }
    @objc  func handleLogout(){
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch{
            print("")
        }
    }
//    MARK: - API
    
    func fetchPosts(){
        
        guard post == nil else{return}
        
        PostService.fetchPosts { posts in
            
            self.posts = posts
            
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
            
        }
    }
    
//    MARK: - Helpers
    
    func configureUI(){
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if post == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        }
        
       
        
        navigationItem.title = "Feed"
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
}

//     MARK: - UICollectionViewDataSource
extension FeedController  {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ?  posts.count : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        cell.delegate = self
        
        if let post = post{
            cell.viewModel = PostViewModel(post: post)
            
        }else{
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
            
          
        }
        
        return cell
    }
    
}


//      MARK: - UICollectionViewDelegateFlowLayout
extension FeedController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width =  view.frame.width
        var height = width + 8 + 40 + 8
        height += 110
        
        return CGSize(width: width, height: height)
    }
}
//  MARK: - FeedCellDelegate
extension FeedController: FeedCellDelegate{
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    func cell(_ cell: FeedCell, didLike post: Post) {
        cell.viewModel?.post.didLike.toggle()
        
        if post.didLike {
            PostService.unlikePost(post: post) { error in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
                cell.likeButton.tintColor = .black
            }
        }else{
            PostService.likePost(post: post) { error in
                if let error = error {
                    print("Algo salio mal \(error.localizedDescription)")
                }
                
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_selected"), for: .normal)
                cell.likeButton.tintColor = .red
                
            }
        }
    }
}



