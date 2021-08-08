//
//  ConversationCell.swift
//  sharex
//
//  Created by Amr Moussa on 28/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class ConversationCell: UICollectionViewCell {
    
    static let cellID = "ConversationCell"
    let cellHeader = CellHeader(cellType: .conversation)
    let lastMessages = ProductItemLable(textAlignment: .left, NoOfLines: 2, size: 16)
    let dateLabel = DateLabel()
    var parent:MessagesVC?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        backgroundColor = .systemBackground
        addSubViews(cellHeader,lastMessages,dateLabel)
        let padding:CGFloat  = 10
        
        NSLayoutConstraint.activate([
            cellHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cellHeader.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            cellHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            cellHeader.heightAnchor.constraint(equalToConstant: 60),
            
            lastMessages.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            lastMessages.topAnchor.constraint(equalTo: cellHeader.bottomAnchor, constant: -30),
            lastMessages.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding*2),
            
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            dateLabel.bottomAnchor .constraint(equalTo: bottomAnchor ),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 10),
        ])
        
        
    }
    
    func setData(conversationID:String){
        //get conversation using id
        NetworkManager.Shared.getSingleConversation(conversationID: conversationID) {[weak self] optConversation in
            guard let self = self else {return}
            guard let conversation  = optConversation else{
                guard let indexPath = self.collectionView?.indexPath(for: self) else{
                    return
                }
                self.parent?.convArr.remove(at: indexPath.row)
                self.collectionView?.deleteItems(at: [indexPath])
                return
            }
            self.cellHeader.setConversation(conversation: conversation)
            self.getLastMessage(conversation: conversation)
        }
    }
    
    private func getLastMessage(conversation:Conversation){
        lastMessages.text = conversation.lastMessage
        lastMessages.configureAsConversationMessage()
        dateLabel.setDate(date: conversation.lastMessageDate.getDateAndTimedFormated(),alignment: .center,textClr: .secondaryLabel)
    }
    
}//c
