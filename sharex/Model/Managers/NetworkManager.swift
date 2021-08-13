//
//  NetworkManager.swift
//  sharex
//
//  Created by Amr Moussa on 06/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class NetworkManager {
    
    
    
    static let Shared = NetworkManager()
    private var cashe:[NSString:UIImage] = [:]
    
    var productsCache:[NSString:CommProduct] = [:]
     
    var currentRootVC:UIViewController?
    
    
    
    
    let db = Firestore.firestore()
    
    var productsRef:CollectionReference
    var usersRef:CollectionReference
    var commentRef:CollectionReference
    
    var userAuthCompletionHandler:((Bool) -> ())?
    
    private init(){ 
        productsRef = db.collection("Products")
        usersRef = db.collection("Users")
        commentRef = db.collection("Comments")
        
    }
    
    func getProduncts( completion: @escaping (Result<[CommProduct], networkError>)->Void){
        productsRef.getDocuments {[weak self]snapShot, error in
            
            guard let self = self else{return}
            
            var products:[CommProduct] = []
            
            
            if let error = error {
                print(error)
                completion(.failure(.noInternetConnection))
            }
            
            guard let snapShotData = snapShot  else{
                completion(.failure(.invalidResponse))
                return
            }
            
            for document in snapShotData.documents {
                let data = document.data()
                
                let productID = document.documentID
                let productName = data[FireStoreDB.Product.name]as? String ?? "Product"
                let productDesc = data[FireStoreDB.Product.descritption]as? String ?? "Description"
                let productInShares = data[FireStoreDB.Product.inShares]as? Int ?? 0
                let ProductToTalShares = data[FireStoreDB.Product.totalShares]as? Int ?? Int.max
                let sharePrice  = data[FireStoreDB.Product.sharePrice]as? Double ?? 0.0
                let originalPrice = data[FireStoreDB.Product.originalPrice] as? Double ?? 0.0
                let ownerId = data[FireStoreDB.Product.ownerID] as? String ?? ""
                let productDate = data[FireStoreDB.Product.date] as? Double ?? 0.0
                
                let product = CommProduct(id: productID, ownerID: ownerId, date: productDate, name: productName, descritption: productDesc, inShares: productInShares, totalShares: ProductToTalShares, sharePrice: sharePrice, originalPrice: originalPrice, likes: 0, CommentsCount: 0, liked: false)
                
                products.append(product)
                self.productsCache[NSString(string: product.id)] = product
                
            }
            
            completion(.success(products))
            
        }
        
    }
    
    func getSingleProduct(productID:String,completed:@escaping(CommProduct?)->()){
        let productRef = db.document("/Products/\(productID)/")
        
        productRef.getDocument { [weak self ]snapShot, error in
            guard let self  = self else {return}
            if let error = error {
                print(error)
                completed(nil)
            }
            
            guard let snapShotData = snapShot  else{
                completed(nil)
                return
            }
            
            guard let data = snapShotData.data()else{
                completed(nil)
                return
            }
            
            let productID = snapShotData.documentID
            let productName = data[FireStoreDB.Product.name]as? String ?? "Product"
            let productDesc = data[FireStoreDB.Product.descritption]as? String ?? "Description"
            let productInShares = data[FireStoreDB.Product.inShares]as? Int ?? 0
            let ProductToTalShares = data[FireStoreDB.Product.totalShares]as? Int ?? Int.max
            let sharePrice  = data[FireStoreDB.Product.sharePrice]as? Double ?? 0.0
            let originalPrice = data[FireStoreDB.Product.originalPrice] as? Double ?? 0.0
            let ownerId = data[FireStoreDB.Product.ownerID] as? String ?? ""
            let productDate = data[FireStoreDB.Product.date] as? Double ?? 0.0
            
            let product = CommProduct(id: productID, ownerID: ownerId, date: productDate, name: productName, descritption: productDesc, inShares: productInShares, totalShares: ProductToTalShares, sharePrice: sharePrice, originalPrice: originalPrice, likes: 0, CommentsCount: 0, liked: false)
            
            self.checkProductChanged(product:product)
            completed(product)
            
        }
        
        
    }
    
    
  
    
    func  getImagesUrlsForProduct(productID:String,completed:@escaping ([String])->()){
        
        let imagesRef = db.collection("/Products/\(productID)/imgUrls/")
        var imgArr:[String] = []
        
        
        imagesRef.getDocuments { QuerySnapshot, Err in
            if let error = Err {
                print(error)
                completed([])
                return
            }
            
            guard let data = QuerySnapshot else {
                completed([])
                return
            }
            
            for document in data.documents{
                imgArr.append(document.get("url") as! String)
                
            }
            
            completed(imgArr)
            
        }
        
        
        
        
        
    }
    
    
    
    
    func getCurrentUser () -> String?{
        guard let id = Auth.auth().currentUser?.uid else{
            print("No user signed in ")
            return nil
        }
        return id
    }
    
    func getCurrentUserInfo (completed:@escaping(User)->()){
        if let userID  = getCurrentUser(){
            // add product is to share()
            getUserInfo(userID: userID, completed: completed)
        }else{
            //No user signed in need to loggin or sign up .
            authenticateUser() { [weak self]isAuthenticated in
                guard let self = self else {return}
                switch (isAuthenticated){
                case false:
                    return
                case true:
                    guard let userID = self.getCurrentUser() else {
                        return
                    }
                    self.getUserInfo(userID: userID, completed: completed)
                }
            }
            
            
        }
        
    }

    
    func getUserInfo(userID:String,completed:@escaping(User)->()){
        
        let user = db.document(("/Users/\(userID)/"))
        
        user.getDocument { snapShot, err in
            if let error = err {
                print(error)
                return
            }
            
            guard let data = snapShot else {
                print(networkError.invalidData)
                return
            }
            
            
            guard  let userData = data.data()else{
                print(networkError.invalidData)
                return
            }
            
            
            let userName = userData[FireStoreDB.User.name] as! String
            let avatarLink = userData[FireStoreDB.User.avatarLink] as! String
            let rating =  userData[FireStoreDB.User.rating] as! Int
            let phoneNumber = userData[FireStoreDB.User.phoneNumber] as?  String ?? "N/A"
            let email = userData[FireStoreDB.User.email] as? String ?? "N/A"
            
            let user = User(id: userID, userName: userName, userRating: rating, avatarUrl: avatarLink, email: email, phoneNumber: phoneNumber)
            
            completed(user)
            
            
        }
        
        
        
    }
    
    func downloadImage(from url:String,completion:@escaping(UIImage)->()){
        
        let urlKey = NSString(string: url)
        if let cashedImage = cashe[urlKey]{
            completion(cashedImage)
            return
        }
        
        guard let validUrl = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: validUrl){(data,respose,error) in
            //check for error
            if let _ = error {}
            
            //check response status
            guard let resonse = respose as?HTTPURLResponse , resonse.statusCode == 200 else{return }
            
            //check if data is Valid
            guard let data = data else{return}
            
            
            guard  let image = UIImage(data: data) else {return}
            self.cashe[urlKey]  = image
            completion(image)
        }
        
        task.resume()
        
    }
    
    
    func getProductShares(productID:String,completion:@escaping (Result<[String],networkError>)->()){
        let sharesRef = db.collection("/Products/\(productID)/\(FireStoreDB.Product.sharesUsers)/")
        
        var sharesUsers:[String] = []
        
        sharesRef.getDocuments { QuerySnapshot, Err in
            if let error = Err {
                print(error)
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = QuerySnapshot else {
                completion(.failure(.invalidData))
                return
            }
            
            for document in data.documents{
                sharesUsers.append(document.documentID)
            }
            
            completion(.success(sharesUsers))
            
        }
        
        
        
    }
    
    
    func checkEmailExist(email:String,compledted: @escaping(Bool)->()){
        let usersCollection = db.collection(("/Users/"))
        
        usersCollection.whereField("email", isEqualTo: email)
            .getDocuments() { (querySnapshot, err) in
                if let _ = err {
                    compledted(false)
                    return
                }
                
                guard let documents = querySnapshot?.documents else{
                    compledted(false)
                    return
                }
                
                compledted(documents.count > 0 ? true:false)
            }
        
    }//
    
    
    func registerUserInDB(user:User,WithPAssword password:String,completed:@escaping(Bool)->()){
        
        signUpUser(user: user, password: password, completed: completed)
        
        //sign up using email and pass
    }
    
    private func signUpUser(user:User,password:String,completed:@escaping(Bool)->()){
        Auth.auth().createUser(withEmail: user.email, password: password) { [weak self] authResult, error in
            guard let self = self else {return}
            
            if let _ = error {
                completed(false)
                return
            }
            
            guard let _ = authResult?.user else{
                completed(false)
                return
            }
            
            self.storeUserInFireStore(userData: user, completed: completed)
            
        }
        
    }
    
    func signInUSer(email:String,pass:String,completed:@escaping(Bool)->()){
        Auth.auth().signIn(withEmail: email, password: pass) { authResult, error in
            
            if let _ = error {
                completed(false)
                return
            }
            
            guard let _ = authResult?.user else{
                completed(false)
                return
            }
            completed(true)
        }
        
        
    }//
    
    
    private func storeUserInFireStore( userData:User,completed:@escaping(Bool)->()){
        //check user added image ?
        if let userImage = userData.image{
            // store image in storage
            storeImageInStoregae(image: userImage, reference: "users") { [weak self]avatarUrl in
                guard let self = self else{return}
                var userDataWithImage  = userData
                userDataWithImage.avatarUrl = avatarUrl ?? ""
                self.addDataToUserCollection(user: userDataWithImage, completion: completed)
            }
            // save user with enpty user avatar url
        }else{
            self.addDataToUserCollection(user: userData, completion: completed)
        }
        
    }//
    
    private func storeImageInStoregae(image:UIImage,reference:String,completed:@escaping(String?)->()){
        let uniqueString = UUID().uuidString
        let storageRef = Storage.storage().reference().child("\(reference)/\(uniqueString)/")
        
        guard let uploadData = image.jpegData(compressionQuality: CGFloat(0.9))else{
            completed(nil)
            return
        }
        storageRef.putData(uploadData, metadata: nil) { metaData, error in
            if let _ = error{
                completed(nil)
                return
            }
            storageRef.downloadURL { url, error in
                if let _ = error{
                    completed(nil)
                    return
                }
                
                guard let imageUrl = url else{
                    completed(nil)
                    return
                }
                completed(imageUrl.absoluteString)
            }
        }
        
        
    }//
    
    private func  addDataToUserCollection(user:User,completion:@escaping(Bool)->()){
        
        guard let userID = getCurrentUser() else {
            completion(false)
            return
        }
        
        let userRef = db.collection(("/Users/"))
        
        let userData: [String: Any] = [
            FireStoreDB.User.email: user.email,
            FireStoreDB.User.name:user.userName,
            FireStoreDB.User.avatarLink: user.avatarUrl,
            FireStoreDB.User.rating:user.userRating,
            FireStoreDB.User.phoneNumber:user.phoneNumber
        ]
        
        // there is no need to cretae likes collescrion as it would create a random decument wedont want and
        // the collectioln would be created with firat real like added to product.
        
        userRef.document(userID).setData(userData) { err in
            if let _ = err{
                completion(false)
                return
            }
            completion(true)
        }
        
        
        
        
    }//m
    
    //MARK:- add share to current product .
    func addShare(productID:String , completed:@escaping(Bool)->()){
        if let _  = getCurrentUser(){
            // add product is to share()
            addShareToproduct(productID: productID, comletion: completed)
        }else{
            //No user signed in need to loggin or sign up .
            authenticateUser() { [weak self]isAuthenticated in
                guard let self = self else {return}
                switch (isAuthenticated){
                case false:
                    completed(false)
                case true:
                    self.addShareToproduct(productID: productID, comletion: completed)
                }
            }
            
            
        }
        
    }//
    
    private func addShareToproduct(productID:String,comletion:@escaping(Bool)->()){
        guard let currentUser = getCurrentUser() else {
            comletion(false)
            return
        }
        
        let productRef = db.collection("/Products/\(productID)/sharesUsers/")
        
        
        productRef.document(currentUser).setData([:]) { err in
            if  let _ = err {
                comletion(false)
                return
            }
            self.increaseSharesHolder(forProduct: productID, completed: comletion)
        }
        
        
    }//
    
    
    
    private  func increaseSharesHolder(forProduct productID:String,completed:@escaping(Bool)->()){
        let userSharesCollectrion = db.collection("/Products/\(productID)/sharesUsers/")
        getCollectionRefCount(ref: userSharesCollectrion) { count in
            guard let count = count else {
                completed(false)
                return
            }
            self.increaseShareInFirestore(productID: productID, count: count) { updated in
                if updated {
                    self.assignProductToCurrentUser(productID: productID,  completed: completed)
                }else{
                    completed(false)
                }
                
            }
            
        }
        
    }//
    
    private func getCollectionRefCount(ref:CollectionReference,completed:@escaping(Int?)->()){
        ref.getDocuments { snapShot, error in
            if let _ = error {
                completed(nil)
                return
            }
            
            guard let documents = snapShot?.documents else{
                completed(nil)
                return
            }
            
            let count  = documents.count
            completed(count)
            
        }
        
    }//
    
    func increaseShareInFirestore(productID:String,count:Int,completed:@escaping(Bool)->()){
        let ref = db.document("Products/\(productID)/")
        ref.updateData([FireStoreDB.Product.inShares:count]) { err in
            if  let _ = err {
                completed(false)
                return
            }
            completed(true)
        }
        
    }
    

    
   
    
    
    private func assignProductToCurrentUser(productID:String,completed:@escaping(Bool)->()){
        guard let currentUser = getCurrentUser() else {
            completed(false)
            return
        }
        
        let ref = db.collection("/Users/\(currentUser)/\(FireStoreDB.User.productsIn)/")
        
        let data:[String:Any] = [
            FireStoreDB.User.lastSeen:0
        ]
        ref.document(productID).setData(data) { err in
            if  let _ = err {
                completed(false)
                return
            }
            completed(true)
        }
    }
    
    
    private func authenticateUser(completion:@escaping(Bool)->()){
        self.userAuthCompletionHandler = completion
        currentRootVC?.presentLoginVC(delegateHandler: self)
    }
    
    
    
    func addComment(withProduct product:CommProduct,commentBody:String,completed:@escaping(Bool)->()){
        if let _  = getCurrentUser(){
            // add comment is to product
            self.addCommentToFireStore(withProduct: product, commentBody: commentBody, completed: completed)
        }else{
            //No user signed in need to loggin or sign up .
            authenticateUser() { [weak self]isAuthenticated in
                guard let self = self else {return}
                switch (isAuthenticated){
                case false:
                    completed(false)
                case true:
                    self.addCommentToFireStore(withProduct: product, commentBody: commentBody, completed: completed)
                }
            }
            
        }
        
        
    }
    
    private func addCommentToFireStore(withProduct product:CommProduct,commentBody:String,completed:@escaping(Bool)->()){
        guard let userID = getCurrentUser() else {
            completed(false)
            return
        }
        
        let ref = db.collection("Products/\(product.id)/\(FireStoreDB.Product.comments)")
        
        let data:[String:Any] = [
            FireStoreDB.Comment.body :commentBody,
            FireStoreDB.Comment.ownerId :userID,
            FireStoreDB.Comment.timeSTamp:Date().timeIntervalSince1970,
            FireStoreDB.Comment.likesCount : 0
        ]
        
        
        ref.addDocument(data: data) { error in
            if let _ = error{
                completed(false)
                return
            }
            
            completed(true)
            
        }
        
    }
    
    func getComments(withProduct product:CommProduct,completed:@escaping([Comment])->()){
        let ref = db.collection("Products/\(product.id)/\(FireStoreDB.Product.comments)")
        
        ref.getDocuments {snapShot, error in
            
            
            
            var comments:[Comment] = []
            
            
            if let error = error {
                print(error)
                completed([])
            }
            
            guard let snapShotData = snapShot  else{
                completed([])
                return
            }
            
            for document in snapShotData.documents {
                let data = document.data()
                
                let commentID = document.documentID
                let commentBody = data[FireStoreDB.Comment.body]as? String ?? "Comment"
                let commentOwnerID = data[FireStoreDB.Comment.ownerId]as? String ?? ""
                let commentTimeStamp = data[FireStoreDB.Comment.timeSTamp]as? Double ?? 0
                let commentlieksCount = data[FireStoreDB.Comment.likesCount]as? Int ?? 0
                
                let comment = Comment(commentID: commentID, commetOwnerID: commentOwnerID, commentDate: commentTimeStamp, commentBody: commentBody, favCount:commentlieksCount, favOrNot: false)
                
                comments.append(comment)
                
                
            }
            comments = comments.sorted { comm1, comm2 in
                comm1.commentDate > comm2.commentDate
            }
            completed(comments)
            
        }
        
    }
    
    func getCommentLike(product:CommProduct,comment:Comment,completion:@escaping(Bool)->()){
        guard let userID = getCurrentUser() else {
            print("returned")
            completion(false)
            return
        }
        
        let ref = db.collection("Products/\(product.id)/\(FireStoreDB.Product.comments)/\(comment.commentID)/\(FireStoreDB.Comment.likes)/")
        
        ref.document(userID).getDocument{ snapShot, error in
            
            if let _ = error {
                completion(false)
                return
            }
            
            guard let snap = snapShot  else{
                completion(false)
                return
            }
            
            guard let _ = snap.data()else{
                completion(false)
                return
            }
            
            completion(true)
            
        }
        
        
    }
    
    func addFavProduct(productID:String,completed:@escaping(Bool)->()){
        if let _  = getCurrentUser(){
            // add comment is to product
            self.addFavProductToFireStore(productID: productID, completed: completed)
        }else{
            //No user signed in need to loggin or sign up .
            authenticateUser() { [weak self]isAuthenticated in
                guard let self = self else {return}
                switch (isAuthenticated){
                case false:
                    completed(false)
                case true:
                    self.addFavProductToFireStore(productID: productID, completed: completed)
                }
            }
            
        }
        
    }
    
    private func addFavProductToFireStore(productID:String,completed:@escaping(Bool)->()){
        guard let userID = getCurrentUser() else {
            completed(false)
            return
        }
        
        let ref =  db.collection("Products/\(productID)/\(FireStoreDB.Product.likes)/")
        
        ref.document(userID).setData([:]) { err in
            if  let _ = err {
                completed(false)
                return
            }
            self.productsCache[NSString(string: productID)]?.liked = true
            self.checkProductChanged(productID: productID)
            completed(true)
            
        }
        
        
        
    }
    
    func disLikeProduct(productID:String,completed:@escaping(Bool)->()){
        guard let userID = getCurrentUser() else {
            completed(false)
            return
        }
        
        let ref =  db.collection("Products/\(productID)/\(FireStoreDB.Product.likes)/")
        ref.document(userID).delete { error in
            if let _ = error {
                completed(false)
                return
            }
            self.productsCache[NSString(string: productID)]?.liked = false
            self.checkProductChanged(productID: productID)
            completed(true)
            
        }
    }
    
    func addFavComment(commentID:String,productID:String,completed:@escaping(Bool)->()){
        if let _  = getCurrentUser(){
            // add comment is to product
            self.addFavCommentToFireStore(commentID: commentID, productID: productID, completed: completed)
        }else{
            //No user signed in need to loggin or sign up .
            authenticateUser() { [weak self]isAuthenticated in
                guard let self = self else {return}
                switch (isAuthenticated){
                case false:
                    completed(false)
                case true:
                    self.addFavCommentToFireStore(commentID: commentID, productID: productID, completed: completed)
                }
            }
            
        }
        
    }
    
    private func addFavCommentToFireStore(commentID:String,productID:String,completed:@escaping(Bool)->()){
        guard let userID = getCurrentUser() else {
            completed(false)
            return
        }
        
        let ref = db.collection("Products/\(productID)/\(FireStoreDB.Product.comments)/\(commentID)/\(FireStoreDB.Comment.likes)/")
        
        ref.document(userID).setData([:]) { [weak self] err in
            guard let self = self else {
                completed(false)
                return}
            if  let _ = err {
                completed(false)
                return
            }
            self.increaseCommentFav(commentID: commentID, productID: productID, completed: completed)
        }
        
    }
    
    private func increaseCommentFav(commentID:String,productID:String,incrementNumber:Int = 1,completed:@escaping(Bool)->()){
        let ref = db.document("Products/\(productID)/\(FireStoreDB.Product.comments)/\(commentID)/")
        ref.updateData([FireStoreDB.Comment.likesCount:FieldValue.increment(Int64(incrementNumber))]) { error in
            if  let _ = error {
                completed(false)
                return
            }
            
            completed(true)
        }
    }
    
    func disLikeComment(commentID:String,productID:String,completed:@escaping(Bool)->()){
        guard let userID = getCurrentUser() else {
            completed(false)
            return
        }
        
        let ref = db.collection("Products/\(productID)/\(FireStoreDB.Product.comments)/\(commentID)/\(FireStoreDB.Comment.likes)/")
        ref.document(userID).delete { error in
            if let _ = error {
                completed(false)
                return
            }
            self.increaseCommentFav(commentID: commentID, productID: productID, incrementNumber: -1, completed: completed)
        }
    }
    
    
    func getSingleComment(withProduct productID:String,commentID:String,completed:@escaping(Comment?)->()){
        let ref = db.document("Products/\(productID)/\(FireStoreDB.Product.comments)/\(commentID)/")
        
        ref.getDocument {snapShot, error in
            
            
            if let error = error {
                print(error)
                completed(nil)
            }
            
            guard let snapShotData = snapShot  else{
                completed(nil)
                return
            }
            
            guard let data = snapShotData.data()else{
                completed(nil)
                return
            }
            
            
            let commentID = snapShotData.documentID
            let commentBody = data[FireStoreDB.Comment.body]as? String ?? "Comment"
            let commentOwnerID = data[FireStoreDB.Comment.ownerId]as? String ?? ""
            let commentTimeStamp = data[FireStoreDB.Comment.timeSTamp]as? Double ?? 0
            let commentlieksCount = data[FireStoreDB.Comment.likesCount]as? Int ?? 0
            
            let comment = Comment(commentID: commentID, commetOwnerID: commentOwnerID, commentDate: commentTimeStamp, commentBody: commentBody, favCount:commentlieksCount, favOrNot: false)
            
            completed(comment)
            
        }
        
        
    }
    
    
    func getProductLikedOrNot(productID:String,completion:@escaping(Bool)->()){
        guard let userID = getCurrentUser() else {
            print("returned")
            completion(false)
            return
        }
        
        let ref = db.collection("Products/\(productID)/\(FireStoreDB.Product.likes)/")
        
        ref.document(userID).getDocument{ snapShot, error in
            
            if let _ = error {
                completion(false)
                return
            }
            
            guard let snap = snapShot  else{
                completion(false)
                return
            }
            
            guard let _ = snap.data()else{
                completion(false)
                return
            }
            
            completion(true)
            
        }
        
        
    }
    
    func getProductForCurrentUser(completed:@escaping([String])->()){
        
        var productsIDs:[String] = []
        guard let userID  = getCurrentUser() else {
            completed([])
            return
        }
        
        let ref = db.collection("/Users/\(userID)/\(FireStoreDB.User.productsIn)/")
        
        ref.getDocuments { snapShot, error in
            if let _ = error {
                completed([])
                return
            }
            
            guard let snap = snapShot  else{
                completed([])
                return
            }
            
            for document in snap.documents{
                
                productsIDs.append(document.documentID)
            }
            // get productsIn for user -> convID of these products
            completed(productsIDs)
            
        }
        
        
    }
    
    
    func getSingleConversation(conversationID:String,completed:@escaping(Conversation?)->()){
        let ref = db.collection("/conversations/\(conversationID)/\(FireStoreDB.conversation.messages)")
        //        get product data with conversation id as productID == conversationID in this case.
        ref.order(by: FireStoreDB.message.timeStamp, descending: true).limit(to: 1).addSnapshotListener {[weak self] snapShot, error in
            guard let self = self else {return}
            if let _ = error {
                completed(nil)
                return
            }
            guard let documents = snapShot?.documents else {
                completed(nil)
                return
            }
            
            guard documents.count > 0, let document = snapShot?.documents[0]  else{
                completed(nil)
                return
            }
            
            let data =  document.data()
            let lastDate  = data[FireStoreDB.message.timeStamp] as? Double ?? 0
            let lastMessage = data[FireStoreDB.message.messageBody] as? String ?? "Message"
            
            let conversation = Conversation(id: conversationID, name: "", lastMessageDate: lastDate, lastMessage: lastMessage)
            self.getConvProductInfo(conversation:conversation,completed:completed)
        }
        
    }
    
    private func getConvProductInfo( conversation: Conversation,completed:@escaping(Conversation?)->()){
        getSingleProduct(productID: conversation.id) { optproduct in
            guard let product = optproduct else{
                completed(nil)
                return
            }
            
            let conversation = Conversation(id: conversation.id, name: product.name, lastMessageDate: conversation.lastMessageDate, lastMessage: conversation.lastMessage)
            completed(conversation)
        }
    }
    
    func getNotSeenMessages(conversationID:String,completed:@escaping(Int)->()){
        guard let user = getCurrentUser() else {
            completed(0)
            return
        }
        // get message last seen timeStamp
        let ref = db.document("/Users/\(user)/\(FireStoreDB.User.productsIn)/\(conversationID)")
        ref.getDocument { snapShot, error in
            if let _ = error {
                completed(0)
                return
            }
            
            guard let snap = snapShot  else{
                completed(0)
                return
            }
            
            guard let data = snap.data()else{
                completed(0)
                return
            }
            
            let lastSeen  = data[FireStoreDB.User.lastSeen] as? Double ?? 0
            
            self.getLastMessages(conversationID:conversationID,lastSeen:lastSeen,completed:completed)
            
            
        }
        
        
    }
    
    private func getLastMessages(conversationID:String,lastSeen:Double,completed:@escaping(Int)->()){
        let ref = db.collection("/conversations/\(conversationID)/\(FireStoreDB.conversation.messages)")
        ref.whereField(FireStoreDB.message.timeStamp, isGreaterThan: lastSeen).getDocuments { snapShot, error in
            if let _ = error {
                completed(0)
                return
            }
            
            guard let snap = snapShot  else{
                completed(0)
                return
            }
            
            let count = snap.documents.count
            completed(count)
        }
    }
    
    func addMessage(message:Message,convID:String,completed:@escaping(Bool)->()){
        guard let userID = getCurrentUser() else {
            return
        }
        
        let ref = db.collection("/conversations/\(convID)/\(FireStoreDB.conversation.messages)")
        let data:[String:Any] = [
            FireStoreDB.message.senderID:userID,
            FireStoreDB.message.messageBody:message.textBody,
            FireStoreDB.message.timeStamp:message.timeStamp,
            
        ]
        
        ref.addDocument(data: data) { error in
            if let _ = error{
                completed(false)
                return
            }
            
            self.setLastseen(convID: convID,complteted: completed)
        }
    }
    
    func getMessages(convID:String,completed:@escaping([Message])->()){
        var messArr:[Message] = []
        let ref = db.collection("/conversations/\(convID)/\(FireStoreDB.conversation.messages)")
        ref.order(by: FireStoreDB.message.timeStamp, descending: false).getDocuments { snapShot, error in
            if let _ = error {
                completed([])
            }
            
            guard let snapShotData = snapShot  else{
                completed([])
                return
            }
            
            let documents = snapShotData.documents
            
            for document in documents{
                let data = document.data()
                let messageID = document.documentID
                let messageBody = data[FireStoreDB.message.messageBody] as? String ?? ""
                let senderID = data[FireStoreDB.message.senderID] as?  String ?? ""
                let timeStamp = data[FireStoreDB.message.timeStamp] as? Double ?? 0
                
                let message = Message(id: messageID, senderID: senderID, textBody: messageBody, timeStamp: timeStamp)
                
                messArr.append(message)
            }
            completed(messArr)
        }
    }
    
    func MessageListener(convID:String,completed:@escaping(Message)->()){
        
        let ref = db.collection("/conversations/\(convID)/\(FireStoreDB.conversation.messages)").whereField(FireStoreDB.message.timeStamp, isGreaterThanOrEqualTo: Date().timeIntervalSince1970)
        
        
        
        ref.addSnapshotListener { querySnapShot, error in
            if let _ = error{
                return
            }
            
            guard let snapShot = querySnapShot else{
                return
            }
            
            snapShot.documentChanges.forEach { change in
                let data = change.document.data()
                
                
                let messageID = change.document.documentID
                let messageBody = data[FireStoreDB.message.messageBody] as? String ?? ""
                let senderID = data[FireStoreDB.message.senderID] as?  String ?? "N/A"
                let timeStamp = data[FireStoreDB.message.timeStamp] as? Double ?? 0
                
                let message = Message(id: messageID, senderID: senderID, textBody: messageBody, timeStamp: timeStamp)
                
                completed(message)
            }
            
        }
    }
    
    func setLastseen(convID:String,complteted:@escaping(Bool)->()){
        guard let userID =  getCurrentUser() , convID != "" else {
            complteted(false)
            return
        }
        
        let ref = db.collection("/Users/\(userID)/\(FireStoreDB.User.productsIn)/")
        
        let data:[String:Any] = [
            FireStoreDB.User.lastSeen:Date().timeIntervalSince1970
        ]
        
        ref.document(convID).updateData(data) { err in
            if  let _ = err {complteted(false) ; return}
            complteted(true)
        }
        
        
    }
    
    //MARK:- add new product
    func addNewProduct(product:CommProduct,images:[UIImage],completed:@escaping(Bool)->()){
        let newDocument = productsRef.document()
        let newDocID = newDocument.documentID
        
        if let _  = getCurrentUser(){
            // add product is to share() 
            addNewProductToFireStore(product: product, images: images, documentID: newDocID) {[weak self] saved in
                guard let self = self else {return}
                completed(self.checkSavingNewProduct(productID: newDocID, saved: saved))
            }
        }else{
            //No user signed in need to loggin or sign up .
            authenticateUser() { [weak self]isAuthenticated in
                guard let self = self else {return}
                switch (isAuthenticated){
                case false:
                    self.removeLastFailedProductDoc(productID: newDocID)
                    completed(false)
                    
                case true:
                    self.addNewProductToFireStore(product: product, images: images, documentID: newDocID) { saved in
                        completed(self.checkSavingNewProduct(productID: newDocID, saved: saved))
                    }
                }
            }
            
            
        }
        
    }
    
    private func addNewProductToFireStore(product:CommProduct,images:[UIImage],documentID:String,completed: @escaping(Bool)->()){
        guard let userID = getCurrentUser() else {
            completed(false)
            return
        }
        
        let data:[String:Any] = [
            FireStoreDB.Product.name : product.name,
            FireStoreDB.Product.descritption : product.descritption,
            FireStoreDB.Product.originalPrice:product.originalPrice,
            FireStoreDB.Product.sharePrice:product.sharePrice,
            FireStoreDB.Product.ownerID:userID,
            FireStoreDB.Product.inShares:product.inShares,
            FireStoreDB.Product.totalShares:product.totalShares,
            FireStoreDB.Product.date:Date().timeIntervalSince1970
        ]
        
        productsRef.document(documentID).setData(data) {[weak self] error in
            guard let self = self else {return}
            if let  _ = error{
                completed(false)
            }
            self.addShareToNewProduct(prductID: documentID, images: images, completed: completed)
        }
        
        
        
    }
    
    private func addShareToNewProduct(prductID: String, images: [UIImage], completed:@escaping(Bool)->()){
        
        addShare(productID: prductID) { shareSaved in
            switch(shareSaved){
            case true:
                self.addImagesToStorage(prductID: prductID, images: images, completed: completed)
            case false:
                completed(false)
            }
        }
        
    }
    
    
    
    
    private func addImagesToStorage(prductID:String,images:[UIImage],completed: @escaping(Bool)->()){
        var imgsUrls:[String] = []
        let group = DispatchGroup()
        
        for image in images {
            group.enter()
            storeImageInStoregae(image: image, reference: "products") { downUrl in
                guard let url = downUrl else{group.leave() ;  return}
                imgsUrls.append(url)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.createNewConversation(convID: prductID, images: imgsUrls, completed: completed)
        }
        
    }
    
    func createNewConversation(convID:String,images:[String],completed: @escaping(Bool)->()){
        let ref =  db.collection("/conversations/")
        ref.document(convID).setData([:]) { error in
            if let _ = error{
                completed(false)
            }
            self.addWelecomeMessage(convID: convID, urls: images, comletetion: completed)
        }
    }
    
    private func  addWelecomeMessage(convID:String,urls:[String],comletetion: @escaping(Bool)->()){
        guard  let userID = getCurrentUser() else {
            comletetion(false)
            return
        }
        //        convID == ProductID
        let data:[String:Any] = [
            FireStoreDB.message.messageBody : "Welcome to new sharing feel free to ask and interact with mates 🎗",
            FireStoreDB.message.senderID :  userID ,
            FireStoreDB.message.timeStamp : Date().timeIntervalSince1970
        ]
       let ref =  db.collection("/conversations/\(convID)/\(FireStoreDB.conversation.messages)")
        ref.addDocument(data: data) { error in
            if let _ = error {
                comletetion(false)
                return
            }
            self.addImagesUrlToProduct(productID: convID, urls: urls, comletetion: comletetion)
        }

    }
    
    private func addImagesUrlToProduct(productID:String,urls:[String],comletetion: @escaping(Bool)->()){
        var completedFlag = true
        guard urls != [] else {
            comletetion(false)
            return
        }
        
        let group = DispatchGroup()
        let imgUrlsRef = productsRef.document(productID).collection(FireStoreDB.Product.imageUrls)
        
        
        for url in urls{
            group.enter()
            let data:[String:Any] = [FireStoreDB.Product.imageUrlsChild:url]
            
            imgUrlsRef.addDocument(data: data) { error in
                if let _ = error{ completedFlag = false
                    group.leave() ;return}
                group.leave()
            }
            
        }
        
        group.notify(queue: .main) {
            comletetion(completedFlag)
        }
        
    }
    
    private func checkSavingNewProduct(productID:String,saved:Bool)->Bool{
        switch (saved) {
        case true:
            let data:[String:String] = ["productID":productID]
            NotificationCenter.default.post(name: .newProductAdded, object: nil, userInfo: data)
            return true
        case false:
            removeLastFailedProductDoc(productID: productID)
            return false
        }
    }
    
    
    
    func removeLastFailedProductDoc(productID:String){
        productsRef.document(productID).delete { error in
            if let _ = error{
                print("Not deleted")
            }
            
            print("deleted")
        }
        
        
    }
    
    func getUsersOrders(completed:@escaping([CommProduct])->()){
        var ordersArr:[CommProduct] = []
        let dispatch = DispatchGroup()
        getProductForCurrentUser { orders in
            guard orders != [] else{
                completed([])
                return
            }
            for orderID in orders {
                dispatch.enter()
                self.getSingleProduct(productID: orderID) { optProduct in
                    guard let product = optProduct else{dispatch.leave() ; return}
                    ordersArr.append(product)
                    dispatch.leave()
                }
            }
            
            dispatch.notify(queue: .main) {
                completed(ordersArr)
            }
            
        }
    }
    
    func logOutUser(completed:@escaping(Bool)->()){
        guard let _ = getCurrentUser() else {
            completed(false)
            return
        }
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completed(true)
        } catch {
            completed(false)
            return
        }
    }
    
    func  restoreAppDefaultState(){
        currentRootVC?.parent?.tabBarController?.selectedIndex = 0
        NotificationCenter.default.post(name: .loggedOut, object: nil)
        
    }
    
    
}//c

extension NetworkManager:loginStatusProtocol{
    
    func userLoginStatusChanged(ststus: userLoginStatus) {
        switch (ststus) {
        case .loggedin:
            self.userAuthCompletionHandler?(true)
            NotificationCenter.default.post(name: .loggedIn, object: nil)
        case .tappedRegisterButton:
            currentRootVC?.showRegisterVC(delegateHandler: self)
        case .registered:
            print("registered")
            self.userAuthCompletionHandler?(true)
            NotificationCenter.default.post(name: .loggedIn, object: nil)
        // handle action veforesign up
        }
    }
    
    
    
}
//MARK:- Posting Notification
extension  NetworkManager{
    private func checkProductChanged(product:CommProduct){
        guard productsCache[NSString(string: product.id)] != product else {
            return
        }
        
        let data:[String:CommProduct] = ["product":product]
        NotificationCenter.default.post(name: .recievedProduct, object: nil, userInfo: data)
        self.productsCache[NSString(string: product.id)] = product
    }
    
    private func checkProductChanged(productID:String){
        guard let product =  productsCache[NSString(string: productID)] else {
            return
        }
        
        let data:[String:CommProduct] = ["product":product]
        NotificationCenter.default.post(name: .recievedProduct, object: nil, userInfo: data)

    }
    
    
}

   
