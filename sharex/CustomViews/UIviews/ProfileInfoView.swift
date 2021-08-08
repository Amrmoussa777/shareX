//
//  ProfileInfoView.swift
//  sharex
//
//  Created by Amr Moussa on 06/08/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class ProfileInfoView: UIView {
    let favouritesView = UIView()
    let ordersView = UIView()
    
    let favsLabelSubHeader = ProductItemLable(textAlignment: .center)
    let orderLabelSubHeader = ProductItemLable(textAlignment: .center)
    
    let orderCoutnLabel = ProductItemLable(textAlignment: .center, NoOfLines: 1, size: 25)
    let favCountLabel = ProductItemLable(textAlignment: .center, NoOfLines: 1, size: 25)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor = .systemGray6
        configureSubView()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureSubView(){
        addSubViews(favouritesView,ordersView)
        favouritesView.translatesAutoresizingMaskIntoConstraints = false
        ordersView.translatesAutoresizingMaskIntoConstraints = false
        let padding:CGFloat = 2
        
        NSLayoutConstraint.activate([
        
            favouritesView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            favouritesView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            favouritesView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            favouritesView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            
            ordersView.leadingAnchor.constraint(equalTo: favouritesView.trailingAnchor, constant: padding),
            ordersView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            ordersView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            ordersView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
        favouritesView.backgroundColor = .systemBackground
        ordersView.backgroundColor = .systemBackground
        configureFisrtView()
        ConfidureSecondView()
        
    }
    private func configureFisrtView(){
        favouritesView.addSubViews(favsLabelSubHeader,favCountLabel)
        favCountLabel.configureAsProfileHeadline()
        favsLabelSubHeader.textColor = .tertiaryLabel
        
        NSLayoutConstraint.activate([
            favCountLabel.centerXAnchor.constraint(equalTo: favouritesView.centerXAnchor),
            favCountLabel.centerYAnchor.constraint(equalTo: favouritesView.centerYAnchor,constant: -15),
            favCountLabel.widthAnchor.constraint(equalTo: favouritesView.widthAnchor,multiplier: 0.7),
            favCountLabel.heightAnchor.constraint(equalToConstant: 25),
            
            favsLabelSubHeader.centerXAnchor.constraint(equalTo: favouritesView.centerXAnchor),
            favsLabelSubHeader.topAnchor.constraint(equalTo: favCountLabel.bottomAnchor,constant: 10),
            favsLabelSubHeader.widthAnchor.constraint(equalTo: favouritesView.widthAnchor,multiplier: 0.7),
            favsLabelSubHeader.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        favsLabelSubHeader.text = "Favourites"
        favCountLabel.text = "0"
        
    }
    
    private func ConfidureSecondView(){
        ordersView.addSubViews(orderLabelSubHeader,orderCoutnLabel)
        orderCoutnLabel.configureAsProfileHeadline()
        orderLabelSubHeader.textColor = .tertiaryLabel
        
        NSLayoutConstraint.activate([
            orderCoutnLabel.centerXAnchor.constraint(equalTo: ordersView.centerXAnchor),
            orderCoutnLabel.centerYAnchor.constraint(equalTo: ordersView.centerYAnchor,constant: -15),
            orderCoutnLabel.widthAnchor.constraint(equalTo: ordersView.widthAnchor,multiplier: 0.7),
            orderCoutnLabel.heightAnchor.constraint(equalToConstant: 25),
            
            orderLabelSubHeader.centerXAnchor.constraint(equalTo: ordersView.centerXAnchor),
            orderLabelSubHeader.topAnchor.constraint(equalTo: orderCoutnLabel.bottomAnchor,constant: 10),
            orderLabelSubHeader.widthAnchor.constraint(equalTo: ordersView.widthAnchor,multiplier: 0.7),
            orderLabelSubHeader.heightAnchor.constraint(equalToConstant: 15),
        ])
        orderLabelSubHeader.text = "Orders"
        orderCoutnLabel.text = "0"
    }
    
    func setDate(favCount:Int,orderCount:Int){
        favCountLabel.text = String(favCount)
        orderCoutnLabel.text = String(orderCount)
        
    }
}
