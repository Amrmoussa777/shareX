//
//  UIView+Ext.swift
//  sharex
//
//  Created by Amr Moussa on 20/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit
import SwiftUI

extension UIView {
    
    
    func addSubViews(_ views:UIView...){
        for view in views {addSubview(view)}
    }
    
    
    func pinToSuperViewEdges(in view:UIView){
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func pinToSuperViewSafeArea(in view:UIView){
        let safeArea = view.safeAreaLayoutGuide
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            topAnchor.constraint(equalTo: safeArea.topAnchor),
            trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
    }
    
    func pinToSuperViewEdgesWithPadding(in view:UIView,padding:CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            topAnchor.constraint(equalTo: view.topAnchor,constant: padding),
            trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -padding)
        ])
    }
    
    func RoundCorners(){
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.masksToBounds = true
        
        
    }
    
    
    func AddStroke(color:UIColor){
       layer.borderWidth = 2
        layer.borderColor = color.cgColor
        
    }
    func changeStroke(color:UIColor){
        layer.borderColor = color.cgColor
        
    }
    
    func roundShape(){
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        layer.masksToBounds = true
    }
    
    func showLoadingView() -> UIView {
        let containerView = UIView(frame: bounds)
        addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        return containerView
    }
   
    
    func showEmptyState(img:UIImage,message:String) -> EmptyStateView{
        let emptyStateView  = EmptyStateView(img: img, message: message)
        addSubview(emptyStateView)
        emptyStateView.pinToSuperViewEdges(in: self)
        return emptyStateView
    }
    
    func anchorWithPadding(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func showAlertView(avatarImage:UIImage = AlertImages.topAlertImage! ,Message:String,buttonLabel:String,buttonImage:UIImage = Images.nextButton!,actionButtonColor:UIColor = .orange){
        
        let containerView = UIView(frame: bounds)
        containerView.RoundCorners()
        containerView.addShadow()
        containerView.backgroundColor = .systemBackground
        containerView.clipsToBounds = false
        
        
        let imageAvatar  = AvatarImageView()
        let desc         = ProductItemLable(textAlignment: .center, NoOfLines: 3, size: 18)
        let actionButton = ShareButton(text: buttonLabel, bGColor: actionButtonColor,iconImage: buttonImage)
        
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        
        
        containerView.addSubViews(imageAvatar,desc,actionButton)

        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
        
            imageAvatar.centerXAnchor.constraint(equalTo: centerXAnchor ),
            imageAvatar.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -35),
            imageAvatar.widthAnchor.constraint(equalToConstant: 100),
            imageAvatar.heightAnchor.constraint(equalToConstant: 100),
            
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding*2),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding*2),
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -padding*2),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            desc.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            desc.topAnchor.constraint(equalTo: imageAvatar.bottomAnchor,constant: padding),
            desc.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            desc.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -padding)
    
        
        ])
        
        imageAvatar.image = avatarImage
        imageAvatar.contentMode = .scaleToFill
        imageAvatar.tintColor = .tertiaryLabel
        imageAvatar.backgroundColor = .systemGray6
        imageAvatar.layer.borderColor = UIColor.systemGray6.cgColor
        imageAvatar.layer.borderWidth = 3
        bringSubviewToFront(imageAvatar)
        
       
        
        desc.text = Message
        desc.textColor = .secondaryLabel
        
        actionButton.addTarget(self, action: #selector(handleErrorAlert), for: .touchUpInside)
        
        
        
        
    }
    
    @objc func handleErrorAlert(){
        let view = subviews.last
        view?.removeFromSuperview()
    }
    
    func addShadow(){
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
    
    func onTapDissmisKeyboard(VC:UIViewController){
        let tap = UITapGestureRecognizer(target: VC, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        addGestureRecognizer(tap)
    }
    
    func removeAllSubViews(){
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
