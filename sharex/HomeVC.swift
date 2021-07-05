//
//  HomeVC.swift
//  sharex
//
//  Created by Amr Moussa on 18/11/2020.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

enum section {
    case main
}
class HomeVC: UIViewController {
    
    var products:[Product] = []
    
    var collectionView:UICollectionView!
    var dataSource:UICollectionViewDiffableDataSource<section, Product>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...10{
            products.append(Product(name: "\(i)", imageUrl: "", price:Double(i*100).rounded()))
        }
        
        configureViewController()
        configureCollectionView()
        configureDataSource()
        updateItems(with: products)
        ///

        
    }
    
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        
        
    }
    
    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: LayoutBuilder.createColumnsFlowLayout(in: view, columns: 2))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray6
        collectionView.register(ProductItemCell.self, forCellWithReuseIdentifier: ProductItemCell.cellIdentifier)
        
        
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexpath, product) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCell.cellIdentifier, for: indexpath) as! ProductItemCell
//            cell.downloadLink = product.imageUrl
//            cell.price = product.price
            cell.setProduct(product: product)
            
            return cell
            
            
        })
    }
    private func updateItems(with products:[Product]){
        var snapshot = NSDiffableDataSourceSnapshot<section,Product>()
        snapshot.appendSections([.main])
        snapshot.appendItems(products)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
}

extension HomeVC:UICollectionViewDelegate{
    
    
}
