//
//  PostService.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 15/12/20.
//

import Foundation
import UIKit
import Firebase


struct  PostService {
    static func uploadPost(caption:String,user: User, image: UIImage, completion: @escaping(FirestoreCompletion)){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let  data = ["caption": caption,
                         "timestamp": Timestamp(date: Date()),
                         "imageUrl":imageUrl,
                         "likes": 0,
                         "ownerImageUrl": user.profileImageUrl,
                         "ownerUsername": user.username,
                         "ownerUid": uid] as [String: Any]

            
                        
            let docRef =  COLLECTION_POSTS.addDocument(data: data, completion: completion)
            self.updateUserFeedAfterPost(postId: docRef.documentID)
            
        }
        
    }
    
    static func fetchPosts(completion: @escaping([Post])->Void){
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            
            guard let documents = snapshot?.documents else {return}
            
            let post = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            
            completion(post)
        }
    }
    
    static func fetchPost(withPostId postId: String, completion: @escaping(Post)->Void ){
        COLLECTION_POSTS.document(postId).getDocument { snapshot, error in
            guard let snapshot = snapshot else {return}
            guard let data = snapshot.data() else {return}
            
            let post = Post(postId: snapshot.documentID, dictionary: data )
                completion(post)
            
            
        }
    }
    
    static func fetchPost(forUser uid: String, completion: @escaping([Post])->Void){
        let query = COLLECTION_POSTS
            .whereField("ownerUid", isEqualTo: uid)
//            .order(by: "timestamp", descending: true)
        
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            
            var post = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            
            post.sort  { (post1, post2 ) -> Bool in
                return post1.timestamp.seconds > post2.timestamp.seconds 
            }
            
            completion(post)
        }
    }
    
    static func likePost(post: Post, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_POSTS.document(post.postId).updateData(["likes" : post.likes + 1 ] )
        
        COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).setData([:]){ _ in
            
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId)
                .setData([:], completion: completion)
        }
        
        
        
    }
    
    static func unlikePost(post: Post, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard post.likes > 0 else {return}
        
        COLLECTION_POSTS.document(post.postId).updateData(["likes":post.likes - 1])
        
        COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).delete(completion: completion)
        }
        
    }
    static func checkIfUserLikePost(post: Post, completion: @escaping(Bool)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}

        COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).getDocument { (snapshot, _) in
            guard let didLike = snapshot?.exists else {return}
            completion(didLike)
        }
    }
    static func fecthFeedPost(completion : @escaping([Post])->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var posts = [Post]()
        
        COLLECTION_USERS.document(uid).collection("user-feed").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                fetchPost(withPostId: document.documentID) { post in
                    posts.append(post)
                    
                    
//                    posts.sort(by: {$0.timestamp.seconds > $1.timestamp.seconds})
                    
                    posts.sort{ (post1,post2) -> Bool in
                        return post1.timestamp.seconds > post2.timestamp.seconds
                    }
                    
                    completion(posts)
                }
            })
        }
        
    }
    
    static func updateUserFeedAfterFollowing(user: User, didFollow: Bool){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: user.uid)
        query.getDocuments { (snapshot, error) in
            guard let document = snapshot?.documents else {return}
            
            let docIDs = document.map({$0.documentID})
            
           
                docIDs.forEach { id in
                    if didFollow{
                    COLLECTION_USERS.document(uid).collection("user-feed").document(id).setData([:])
                }else{
                    COLLECTION_USERS.document(uid).collection("user-feed").document(id).delete()
                }
            }
            
            
            
        }
    }
    private  static func updateUserFeedAfterPost(postId: String){
        guard let uid = Auth.auth().currentUser?.uid else {return}
            
        COLLECTION_FOLLOWERS.document(uid).collection("user-folloewrs").getDocuments { (snapshot, _) in
            
            guard let documents = snapshot?.documents else {return}
            
            documents.forEach { docucment in
                COLLECTION_USERS.document(docucment.documentID).collection("user-feed").document(postId).setData([:])
            }
            
            COLLECTION_USERS.document(uid).collection("user-feed").document(postId).setData([:])
            
        }
    }
}
