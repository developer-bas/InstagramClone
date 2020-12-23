//
//  CommentService.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 22/12/20.
//

import Firebase

struct CommentService {
    
    static func uploadComment(comment: String, postID: String, user: User, completion: @escaping(FirestoreCompletion)){
        
        let data : [String:Any] = ["uid": user.uid,
                                   "comment": comment,
                                   "timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "profileImageUrl": user.profileImageUrl]
        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data,completion: completion)
        
    }
    
    static func fetchComments(postID: String, completion: @escaping([Comment])->Void){
        var comments = [Comment]()
        let query = COLLECTION_POSTS.document(postID).collection("comments").order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { (snapshat, error) in
            snapshat?.documentChanges.forEach({ change in
                if change.type == .added{
                    let data = change.document.data()
                    let comment = Comment(dictionary: data)
                    comments.append(comment)
                }
            })
            completion(comments)
        }
        
        
        
    }
    
}
