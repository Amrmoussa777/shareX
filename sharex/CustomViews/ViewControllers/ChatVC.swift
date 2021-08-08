//
//  ChatVC.swift
//  sharex
//
//  Created by Amr Moussa on 29/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class ChatVC: UIViewController{
    
    
    let header = CellHeader(cellType: .conversation)
    
    var chatCollectionView:UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    let footerView = ChatFooterView()
    
    var conversationID:String?
    var messageArr:[Message] = []
    
    var footerConstrains:NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureLayout()
        setHeader()
        configureKeyboard()
        configureSendButton()
        configureHeader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMessages()
        configureDBListener()
        NetworkManager.Shared.setLastseen(convID: conversationID ?? "") {_ in }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NetworkManager.Shared.setLastseen(convID: conversationID ?? "") {_ in }
    }
    
    
    private func configure(){
        chatCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        chatCollectionView.register(SenderMessageCell.self, forCellWithReuseIdentifier: SenderMessageCell.cellID)
        chatCollectionView.register(ReceiverMessageCell.self, forCellWithReuseIdentifier: ReceiverMessageCell.cellID)
        chatCollectionView.showsVerticalScrollIndicator = false
        footerView.textFeild.delegate  = self
        chatCollectionView.backgroundColor = .systemBackground
        view.backgroundColor = .systemBackground
        view.layoutIfNeeded()
        
    }
    
    private func configureLayout(){
        view.addSubViews(header,chatCollectionView,footerView)
        chatCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let padding:CGFloat = 10
        let safeArea = view.safeAreaLayoutGuide
        
        footerConstrains = footerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant:-10)
        footerConstrains?.isActive = true
        
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            header.heightAnchor.constraint(equalToConstant: 60),
            
            //footerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -padding),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            footerView.heightAnchor.constraint(equalToConstant: 60),
            
            
            chatCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            chatCollectionView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: padding),
            chatCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            chatCollectionView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -padding),
        ])
        
    }
    
    private func setHeader(){
        guard let convID = conversationID else{return}
        NetworkManager.Shared.getSingleConversation(conversationID: convID) {[weak self] optConversation in
            guard let self = self else {return}
            guard let conv = optConversation else{
                return
            }
            self.header.setChatHeader(conversation: conv)
        }
        
    }
    
    private func getMessages(){
        guard let _ = NetworkManager.Shared.getCurrentUser() ,let convID = conversationID else{
            return
        }
        let loadingView = chatCollectionView.showLoadingView()
        NetworkManager.Shared.getMessages(convID: convID) {[weak self] Messages in
            loadingView.removeFromSuperview()
            guard let self = self else {return}
            guard !Messages.isEmpty else{
                return
            }
            self.messageArr = Messages
            DispatchQueue.main.async {
                self.chatCollectionView.reloadData()
                self.scrollToBottom()
            }
        }
        
        
    }
    
}

extension ChatVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = getCellType(indexpath:indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = getCellHeight(inedxPath:indexPath)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    private func getCellType(indexpath:IndexPath)->UICollectionViewCell{
        guard let userID = NetworkManager.Shared.getCurrentUser() ,let convID = conversationID else{
            return UICollectionViewCell()
        }
        
        
        //if message.sender == cuurentUserID -> sender cell
        if messageArr[indexpath.row].senderID == userID &&  messageArr[indexpath.row].id == "" {
            let cell = chatCollectionView.dequeueReusableCell(withReuseIdentifier: SenderMessageCell.cellID, for: indexpath) as! SenderMessageCell
            cell.setMessage(message: messageArr[indexpath.row])
            cell.sendMessage(message: messageArr[indexpath.row], conversationID: convID)
            messageArr[indexpath.row].id = "sended"
            return cell
        }
        else  if messageArr[indexpath.row].senderID == userID{
            let cell = chatCollectionView.dequeueReusableCell(withReuseIdentifier: SenderMessageCell.cellID, for: indexpath) as! SenderMessageCell
            cell.setMessage(message: messageArr[indexpath.row])
            return cell
        }
        
        else{
            let cell = chatCollectionView.dequeueReusableCell(withReuseIdentifier: ReceiverMessageCell.cellID, for: indexpath) as! ReceiverMessageCell
            cell.setMessage(message: messageArr[indexpath.row])
            return cell
        }
    }
    
    private func  getCellHeight(inedxPath:IndexPath)->CGSize{
        
        let width = chatCollectionView.frame.width
        let text = messageArr[inedxPath.row].textBody
        let messageWidth = width*0.7 - 15 // 15 for box padding inside message label
        let messageLabelFont = UIFont.systemFont(ofSize: 15, weight:.medium)
        
        let height = heightForView(text: text, font: messageLabelFont, width: messageWidth) + 60
        return CGSize(width: width, height: height)
    }
    
    private func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:MessageLabel = MessageLabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    private func scrollToBottom(){
        guard messageArr.count > 0 else {
            return
        }
        let lastIndex = IndexPath(item: self.messageArr.count-1, section: 0)
        self.chatCollectionView.scrollToItem(at: lastIndex, at: .bottom, animated: true)
    }
    
    private func configureDBListener(){
        guard let convID = conversationID else {
            return
        }
        NetworkManager.Shared.MessageListener(convID: convID) {[weak self] message in
            guard let userID = NetworkManager.Shared.getCurrentUser()else{return}
            guard let self = self else {return}
            guard (message.senderID != userID) else{
                return
            }
            DispatchQueue.main.async {
                self.messageArr.append(message)
                self.insertItemInlast()
                SoundManager.shared.playMessageSound()
            }
          
        }
    }
    
}

extension ChatVC{
    
    private func configureKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        chatCollectionView.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        var height:CGFloat = 10
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        height = keyboardViewEndFrame.height
        footerConstrains?.constant = -height + (view.safeAreaInsets.bottom-10)
        self.view.layoutIfNeeded()
        scrollToBottom()
    }
    
    @objc func keyboardWillHide(notification: Notification){
        footerConstrains?.constant = -10
        view.layoutIfNeeded()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    private func  configureSendButton(){
        footerView.sendButton.addTarget(self, action: #selector(sendTapepd), for: .touchUpInside)
    }
    
    @objc func sendTapepd(){
        SendMessage()
        SoundManager.shared.playSendSound()
    }
    
}

extension ChatVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        SendMessage()
        return true
    }
    
    private func SendMessage(){
        defer{
            footerView.textFeild.text = ""
        }
        guard footerView.textFeild.text != "" , let userid = NetworkManager.Shared.getCurrentUser() else {
            return
        }
        let text = footerView.textFeild.text ?? ""
        let message = Message(id: "", senderID: userid, textBody: text, timeStamp: Date().timeIntervalSince1970)
        messageArr.append(message)
        //        Network call to
        insertItemInlast()
    }
    
    private func insertItemInlast() {
        let index  = IndexPath(item: messageArr.count-1, section: 0)
        chatCollectionView.insertItems(at: [index])
        scrollToBottom()
    }
    
    private func configureHeader(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(openDetailedProduct))
        header.addGestureRecognizer(tap)
    }
    
    @objc func  openDetailedProduct(){
        guard let convID = conversationID else {
            return
        }
        let overViewVC = ProductOverViewVC()
        let  product   = NetworkManager.Shared.productsCache[NSString(string: convID)]
        overViewVC.product = product
        overViewVC.delegate = self
        overViewVC.configureAsJoined()
        present(overViewVC, animated: true)   
    }
    
}

extension ChatVC: viewDetailedViewProtocol {
  
    func showDetailedWith(product: CommProduct) {
        guard let convID = conversationID else {
            return
        }
        let detaieldView = DetailedProductVC()
        detaieldView.product = NetworkManager.Shared.productsCache[NSString(string: convID)]
        navigationController?.pushViewController(detaieldView, animated: true)
    }
    
}
