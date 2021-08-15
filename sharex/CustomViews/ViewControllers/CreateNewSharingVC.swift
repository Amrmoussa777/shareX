//
//  CreateNewSharingVC.swift
//  sharex
//
//  Created by Amr Moussa on 01/08/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

import Photos

import PhotosUI
@available(iOS 14, *)
class CreateNewSharingVC: UIViewController{
  
    let imageView = AvatarImageView()
    let registerLabel = ProductItemLable(textAlignment: .left, NoOfLines: 2, size: 25)
    let confirmButton = ShareButton(text: "Next", bGColor: .orange, iconImage: Images.nextButton)
    
    var collectioView:UICollectionView!
    let layout = UICollectionViewFlowLayout()
    let pager = UIPageControl()
    
        // for picking multiple images
    var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
    var picker:PHPickerViewController!
    
    var counter = 0
    let padding:CGFloat = 10
    let outerPadding:CGFloat = 20
    
//    first cell views
    let nameTextFeild = ShareTextFeild(placeHolder: "sharing name", placeholderImage: Images.emailImage!)
    let descTextFeild = ShareTextFeild(placeHolder: "write you sharing descritption ...", placeholderImage: Images.commentImage!)
    
//  second cell
    let originalPrice = ShareTextFeild(placeHolder: "Original Price before Sharing", placeholderImage: Images.dollarSign!)
    let sharedPrice = ShareTextFeild(placeHolder: "Shared price ", placeholderImage: Images.dollarSign!)
    
//    third cell
    let totalShares = ShareTextFeild(placeHolder: "Toltal number of shares ...", placeholderImage: Images.commInfoImage!)

//    fourth cell
    let chooseImagesView = ChooseImagesView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureColectionView()
        configurePager()
        configureConfirmButton()
        configureCooseImagesButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkManager.Shared.currentRootVC = self
    }
    
    private func configureLayout(){
        view.backgroundColor = .systemBackground
        view.addSubViews(imageView,registerLabel,confirmButton)
        view.onTapDissmisKeyboard(VC: self)
        
        configuration.filter = .images
        configuration.selectionLimit = 4
        picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        registerLabel.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        registerLabel.setText(text: "New \nSharing")
        imageView.image = Images.createNewProductAvatar
        let imageHeight:CGFloat = DeviceTypes.isSmallSEAndMini ? 150:200
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor,constant: padding),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            imageView.widthAnchor.constraint(equalToConstant: imageHeight),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            
            registerLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            registerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            registerLabel.widthAnchor.constraint(equalToConstant: 200),
            registerLabel.heightAnchor.constraint(equalToConstant: 150),
            
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -outerPadding),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outerPadding),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private func configureColectionView(){
        
        
        layout.scrollDirection = .horizontal
        
        collectioView = UICollectionView(frame:view.bounds , collectionViewLayout: layout)
        collectioView.delegate = self
        collectioView.dataSource = self
        collectioView.collectionViewLayout = layout
        collectioView.showsHorizontalScrollIndicator = false
        collectioView.showsVerticalScrollIndicator = false
        collectioView.isPagingEnabled = true
        collectioView.isScrollEnabled  = false
        collectioView.register(CreateNewProductCVcell.self, forCellWithReuseIdentifier: CreateNewProductCVcell.cellID)
        
        
        
        
        view.addSubview(collectioView)
        collectioView.backgroundColor = .systemBackground
        collectioView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectioView.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: outerPadding),
            collectioView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            collectioView.leadingAnchor.constraint(equalTo:view.leadingAnchor,constant: padding),
            collectioView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -outerPadding),
            
            
        ])
        
        
        
    }
    
    private func configurePager(){
        
        view.addSubview(pager)
        pager.pageIndicatorTintColor = .systemGray5
        pager.currentPageIndicatorTintColor = .orange
        
        pager.numberOfPages = 4
        pager.currentPage = 0
        
        pager.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pager.leadingAnchor.constraint(equalTo: collectioView.leadingAnchor),
            pager.trailingAnchor.constraint(equalTo: collectioView.trailingAnchor),
            pager.bottomAnchor.constraint(equalTo: collectioView.bottomAnchor),
            pager.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}


@available(iOS 14, *)
extension CreateNewSharingVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreateNewProductCVcell.cellID, for: indexPath) as! CreateNewProductCVcell
        let (views,constrains,Message) = getUIViewForCpecificCell(cellindex: indexPath.row, cell: cell)
        cell.addContentViews(views, constrains: constrains, topMessage: Message)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width , height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pager.currentPage = counter
    }
}

@available(iOS 14, *)
extension CreateNewSharingVC{
    private func getUIViewForCpecificCell(cellindex:Int,cell:UICollectionViewCell)->([UIView],[NSLayoutConstraint],message:String){
        switch cellindex {
        case 0:
            return firstCVSCreenConfiguration(cellindex: cellindex, cell: cell)
        case 1:
            return secondCVScreenConfigure(cellindex: cellindex, cell: cell)
        case 2:
            return thirdCVScreenConfigure(cellindex: cellindex, cell: cell)
        case 3:
            return fourthCVScreenConfigure(cellindex: cellindex, cell: cell)
            //return fourthCVScreenConfigure(cellindex: cellindex, cell: cell)
        default:
            return ([],[],"Please add vaild infos ... ")
        }
     
    }
    private func configureConfirmButton(){
        confirmButton.addTarget(self, action: #selector(ConfirmTapped), for: .touchUpInside)
        
    }
    
    @objc func ConfirmTapped(){

        if counter < 4 {
                //check valid items email  and password
                switch (counter) {
                case 0:
                    if !(nameTextFeild.text?.isEmpty ?? true) && !(descTextFeild.text?.isEmpty ?? true){
                       scrollToNext()
                    }else{
                        view.showAlertView( Message: "Please add valid name  and description of your sharing", buttonLabel: "OK")
                        }
                case 1:
                    if !(originalPrice.text?.isEmpty ?? true) && !(sharedPrice.text?.isEmpty ?? true) {
                        scrollToNext()
                    }else{
                        view.showAlertView( Message: "Please add original price and share price.", buttonLabel: "OK")
                        }
                    
                case 2:
                    if !(totalShares.text?.isEmpty ?? true) {
                        scrollToNext()
                        confirmButton.setTitle("Upload", for: .normal)
                    }else{
                        view.showAlertView(Message: "Please add a valid photos of your sharing..", buttonLabel: "OK")
                        }
                case 3:
                    if !(chooseImagesView.getImages().isEmpty) {
                        addNewShareToDB()
                    }else{
                        view.showAlertView(Message: "Please add a valid photos of your sharing.. ", buttonLabel: "OK")
                        }
                    
                default:
                    print("error")
                }
                
            }
    }
    private func firstCVSCreenConfiguration(cellindex:Int,cell:UICollectionViewCell)->([UIView],[NSLayoutConstraint],message:String){
        var views:[UIView] = []
        var constrains:[NSLayoutConstraint] = []
        let descritptionHeight:CGFloat = DeviceTypes.isSmallSEAndMini ? 100:150
        let firstCellConstrains = [
            nameTextFeild.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: 50),
            nameTextFeild.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            nameTextFeild.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor,constant: -padding),
            nameTextFeild.heightAnchor.constraint(equalToConstant: 50),
            
            descTextFeild.topAnchor.constraint(equalTo: nameTextFeild.bottomAnchor,constant: padding*2),
            descTextFeild.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            descTextFeild.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor,constant: -padding),
            descTextFeild.heightAnchor.constraint(equalToConstant: descritptionHeight)
        ]
        
        views.append(nameTextFeild)
        views.append(descTextFeild)
        constrains = constrains + firstCellConstrains
        return (views,constrains, """
                please add proper name and description
                of your Sharing with location and
                payment process.
            """ )
    }
    
    private func secondCVScreenConfigure(cellindex:Int,cell:UICollectionViewCell)->([UIView],[NSLayoutConstraint],message:String){
        var views:[UIView] = []
        var constrains:[NSLayoutConstraint] = []
        let topPadding:CGFloat = DeviceTypes.isSmallSEAndMini ? 50:100
        
        let CellConstrains = [
            originalPrice.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: topPadding),
            originalPrice.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            originalPrice.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor,constant: -padding),
            originalPrice.heightAnchor.constraint(equalToConstant: 50),
            
            sharedPrice.topAnchor.constraint(equalTo: originalPrice.bottomAnchor,constant: outerPadding),
            sharedPrice.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            sharedPrice.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor,constant: -padding),
            sharedPrice.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        originalPrice.keyboardType = .phonePad
        sharedPrice.keyboardType = .phonePad
        views.append(originalPrice)
        views.append(sharedPrice)
        constrains = constrains + CellConstrains
        return (views,constrains,"""
            please add actual original and shared price.
            """)
    }
    
    private func thirdCVScreenConfigure(cellindex:Int,cell:UICollectionViewCell)->([UIView],[NSLayoutConstraint],message:String){
        var views:[UIView] = []
        var constrains:[NSLayoutConstraint] = []
        
        let CellConstrains = [
            
            totalShares.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: 100),
            totalShares.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            totalShares.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor,constant: -padding),
            totalShares.heightAnchor.constraint(equalToConstant: 50)
        ]
        totalShares.keyboardType = .phonePad
        views.append(totalShares)
        
        constrains = constrains + CellConstrains
        return (views,constrains,"""
                Number of shares that of your
                sharing .
                """)
    }
    
    private func fourthCVScreenConfigure(cellindex:Int,cell:UICollectionViewCell)->([UIView],[NSLayoutConstraint],message:String){
        var views:[UIView] = []
        var constrains:[NSLayoutConstraint] = []
        
        let CellConstrains = [
            chooseImagesView.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: padding),
            chooseImagesView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            chooseImagesView.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor,constant: -padding),
            chooseImagesView.heightAnchor.constraint(equalTo:cell.contentView.heightAnchor)
        ]
        
        views.append(chooseImagesView)
        
        constrains = constrains + CellConstrains
        return (views,constrains,"""
                please choose Max 4 Images of your sharing
                """)
    }
    
    private func addNewShareToDB(){
        
        let name = nameTextFeild.text ?? ""
        let desc = descTextFeild.text ?? ""
        let totalShares = totalShares.text ?? ""
        let sharePrice = sharedPrice.text ?? ""
        let originalPrice = originalPrice.text ?? ""
        let images = chooseImagesView.getImages()
        
        let product = CommProduct(id: "", ownerID: "", date: 0, name: name, descritption: desc, inShares: 0, totalShares: Int(totalShares) ?? 0, sharePrice: Double(sharePrice) ?? 0.0, originalPrice: Double(originalPrice) ?? 0.0, likes: 0, CommentsCount: 0, liked: false)
        
        let loadingView = view.showLoadingView()
        NetworkManager.Shared.addNewProduct(product: product, images: images) {[weak self] isUploaded in
            loadingView.removeFromSuperview()
            guard let self = self else {return}
            switch(isUploaded){
            case true:
                self.dismiss(animated: true) {}
            case false:
                self.view.showAlertView(Message: "there was a problem uploading your sharing please try again", buttonLabel: "Done")
            }
        }
    }
    
    private func scrollToNext(){
        self.counter += 1
        let index = IndexPath.init(item: counter , section: 0)
        self.collectioView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    
    private func configureCooseImagesButton(){
        chooseImagesView.chooseButton.addTarget(self, action: #selector(chooseImagesTapped), for: .touchUpInside)
        
    }
    
    @objc func chooseImagesTapped(){
        present(picker, animated: true)
    }
    
}


@available(iOS 14, *)
extension CreateNewSharingVC :PHPickerViewControllerDelegate{
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    // notified when choose images or cancel touced
        picker.dismiss(animated: true)
        var images:[UIImage] = []
    
        guard !results.isEmpty else {
            return
        }
        // DIspatch group to handle asnc to wait until images loads
        let group = DispatchGroup()
        

        for item in results{
            group.enter()
            
            loadImageFromLibarary(item: item) { image in
                guard let image = image else {
                    group.leave()
                    return
                }
                
                images.append(image)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            // this notified when all images laodded or failed.
            self.chooseImagesView.setImages(imgs: images)
        }
        
    }
    
    
    
    
    
    private  func loadImageFromLibarary(item:PHPickerResult,completion:@escaping(UIImage?)->()){
        
        guard item.itemProvider.canLoadObject(ofClass: UIImage.self) else {
           completion(nil)
            return
        }
        
        item.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            guard let image = image as? UIImage else {
                return
            }
            completion(image)
            print("image added")
        }
    }
    
    // keyboard handling
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}



