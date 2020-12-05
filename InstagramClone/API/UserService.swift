//
//  UserService.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 04/12/20.
//

import Firebase

struct UserService {
    static func fetchUser(completion: @escaping(User)-> Void ){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_USERS.document(uid).getDocument { snapshot, error  in
            guard let dictionary = snapshot?.data() else {return}
            
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
