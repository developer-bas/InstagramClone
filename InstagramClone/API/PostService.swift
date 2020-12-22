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

            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
            
        }
        
    }
    
    static func fetchPosts(completion: @escaping([Post])->Void){
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            
            guard let documents = snapshot?.documents else {return}
            
            let post = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            
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
}
