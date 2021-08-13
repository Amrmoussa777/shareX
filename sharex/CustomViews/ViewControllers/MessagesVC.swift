//
//  MessagesVC.swift
//  sharex
//
//  Created by Amr Moussa on 18/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class MessagesVC: UIViewController{
    
    var convsCollectionView:UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var convArr:[String] = []
    var emptyStateView:EmptyStateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addObservers()
        getConversations()
    }
    
    deinit {deleteObesrvers()}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkManager.Shared.currentRootVC = self
    }
    

    private func configure(){
        convsCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        convsCollectionView.delegate = self
        convsCollectionView.dataSource = self
        convsCollectionView.collectionViewLayout = layout
        convsCollectionView.showsVerticalScrollIndicator = false
        convsCollectionView.register(ConversationCell.self, forCellWithReuseIdentifier: ConversationCell.cellID)
        convsCollectionView.backgroundColor = .systemBackground
        
        view.addSubview(convsCollectionView)
        convsCollectionView.pinToSuperViewEdges(in: self.view)
     
    }
    
    private func getConversations(){
        NetworkManager.Shared.getProductForCurrentUser {[weak self] products in
            guard let self = self else {return}
            self.emptyStateView?.removeFromSuperview()
            guard  products != [] else{
                self.emptyStateView =  self.view.showEmptyState(img: Images.loginImage!, message: "Please join sharings and the conversation will be added automatically here to discuss details with sharing's mates 😊")
                return
            }
            
            self.convArr = products
            DispatchQueue.main.async {
                self.convsCollectionView.reloadData()
            }
            
        }
    }
    
    

}

extension MessagesVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return convArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = convsCollectionView.dequeueReusableCell(withReuseIdentifier: ConversationCell.cellID, for: indexPath) as! ConversationCell
        cell.setData(conversationID: convArr[indexPath.row])
        cell.parent = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let conversation = convArr[indexPath.row]
        let chatVC = ChatVC()
        chatVC.conversationID = conversation
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}

extension MessagesVC{
    func addObservers(){
        addLoginObserever()
        addLoggOutObserever()
        addNewProductObserever()
        addNewProduuctShareAdded()
    }
    
    func deleteObesrvers(){
        deleteLoginObserver()
        deleteLoggOutObserver()
        deleteNewProductObserver()
        deleteNewProduuctShareAdded()
    }
    
    override func loggedIn(_ notification: Notification) {
        getConversations()
    }
    
    override func loggedOut(_ notification: Notification) {
        getConversations()
    }
    override func NewProductAdded(_ notification: Notification) {
        guard let data = notification.userInfo as? [String:String] else {
            return
        }
        
        guard let productID  = data["productID"] else {
            return
        }
        
        convArr.append(productID)
        convsCollectionView.reloadData()
    }
    
    override func newShareAdded(_ notification: Notification) {
        guard let data = notification.userInfo as? [String:String] else {
            return
        }
        
        guard let productID  = data["productID"] else {
            return
        }
        
        convArr.append(productID)
        convsCollectionView.reloadData()
    }
}
