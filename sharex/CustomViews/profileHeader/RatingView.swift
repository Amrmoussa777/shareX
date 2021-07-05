//
//  RatingView.swift
//  sharex
//
//  Created by Amr Moussa on 01/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import SwiftUI
import UIKit

class RatingUIView: UIView {
    
    var rating:Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(rating:Int){
        super.init(frame: .zero)
        self.rating = rating
        addRating(rating: rating)
        
    }
  
    
    
    func addRating(rating:Int = 1){
        
        let swiftUIView = RatingView(rating: .constant(rating))
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        hostingController.view.backgroundColor = .none
        addSubview(hostingController.view)
        
        /// Setup the constraints to update the SwiftUI view boundaries.
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: self.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            self.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        translatesAutoresizingMaskIntoConstraints = false

    }
    
    
}



struct RatingView: View {
    
    @Binding var rating: Int
    
    var maximumRating = 5
    // in case you neeed to change gary stars tp new image
    var offImage: Image?
    var onImage = Image(systemName: "star.fill").resizable()
    
    var offColor = Color.gray
    var onColor = Color.orange
    
    var body: some View {
        HStack(spacing:1) {
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor).frame(width: 15, height: 15, alignment: .leading)
                    
                /* .onTapGesture {
                 self.rating = number
                 }*/
            }
        }
        
    }
    
    private func image(for number: Int) -> Image {
        if number > rating {
            // assign iameg that you need to 
            return offImage?.resizable() ?? onImage
        } else {
            return onImage
        }
    }
}
struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RatingView(rating: .constant(3))
            
        }
    }
}


