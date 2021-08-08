//
//  MessageCell.swift
//  sharex
//
//  Created by Amr Moussa on 30/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class SenderMessageCell:UICollectionViewCell{
    
    static let cellID = "SenderMessageCell"
    
    
    let messageLabel    = MessageLabel()
    let dateLabel     = ShareDateLabel()
    lazy var statusImage = AvatarImageView()
    
    let padding:CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout(){
        addSubViews(messageLabel,dateLabel)
        
        
        NSLayoutConstraint.activate([
            
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 250 ),
            dateLabel.heightAnchor.constraint(equalToConstant: 20 ),
            
            messageLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            messageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.7),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setMessage(message:Message){
        dateLabel.setDate(userName: "You", timaStamp: message.timeStamp)
        messageLabel.configureAsSender()
        messageLabel.setMessage(messagebody: message.textBody)
    }
    
    func sendMessage(message:Message,conversationID:String){
        NetworkManager.Shared.addMessage(message: message, convID: conversationID) {[weak self] isSaved in
            guard let self = self else {return}
            isSaved ? self.messageUploaded():self.messageNotUploaded()
        }
    }
    
     private func messageUploaded(){
        
    }
    
    private func messageNotUploaded(){
        addSubview(statusImage)
        NSLayoutConstraint.activate([
            statusImage.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor),
            statusImage.trailingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -padding),
            
            statusImage.widthAnchor.constraint(equalToConstant: 20),
            statusImage.heightAnchor.constraint(equalToConstant: 20),
        ])
        statusImage.setImage(image:  Images.faildAndReloadImage!)
        statusImage.backgroundColor = .red
        statusImage.tintColor = .white
    }
}

class ReceiverMessageCell:UICollectionViewCell{
    
    static let cellID = "ReceiverMessageCell"
    
    let userAvatar      = AvatarImageView()
    let messageLabel    = MessageLabel()
    let dateLabel     = ShareDateLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func configureLayout(){
        addSubViews(userAvatar,messageLabel,dateLabel)
        let padding:CGFloat = 10
        
        NSLayoutConstraint.activate([
            
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 250 ),
            dateLabel.heightAnchor.constraint(equalToConstant: 20 ),
            
            userAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            userAvatar.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            userAvatar.widthAnchor.constraint(equalToConstant: 50),
            userAvatar.heightAnchor.constraint(equalToConstant: 50),
            
            messageLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            messageLabel.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: padding),
            messageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.7),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
      
        ])
    }
    
    func setMessage(message:Message){
        getSenderInfos(message:message)
        messageLabel.configureAsReciever()
        messageLabel.setMessage(messagebody: message.textBody)
    }
    
    private func getSenderInfos(message:Message){
        NetworkManager.Shared.getUserInfo(userID: message.senderID) {[weak self] user in
            guard let self = self else {return}
            self.dateLabel.setDate(userName: user.userName, timaStamp: message.timeStamp)
            self.userAvatar.downloadImage(fromURL: user.avatarUrl)
        }
    }
    
}
