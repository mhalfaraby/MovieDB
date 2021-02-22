//
//  PopularCollectionViewCell.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 21/02/21.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
  
let popImage = UIImageView()
let popTitle = UILabel()
let popCast = UILabel()

  override init(frame: CGRect) {
      
      super.init(frame: frame)
      
//        featuredPhotoView.layer.cornerRadius = 10
    popImage.layer.masksToBounds = true
    popTitle.layer.masksToBounds = true
    popCast.layer.masksToBounds = true
    

    

  }

  required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
  }
  
  func configure(withImageName name: String, title: String) {
      
    popImage.translatesAutoresizingMaskIntoConstraints = false
    popTitle.translatesAutoresizingMaskIntoConstraints = false
    popCast.translatesAutoresizingMaskIntoConstraints = false

      contentView.addSubview(popImage)
    contentView.addSubview(popTitle)
    contentView.addSubview(popCast)

      NSLayoutConstraint.activate([
        popImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        popImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        popImage.topAnchor.constraint(equalTo: contentView.topAnchor),
        popImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
        popTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        popTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        popTitle.topAnchor.constraint(equalTo: popImage.bottomAnchor),
        popCast.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        popCast.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        popCast.topAnchor.constraint(equalTo: popTitle.bottomAnchor),
        
      ])
//    let urlToImage = NSURL.init(string: name)
//    popImage.af.setImage(withURL: urlToImage! as URL)
////
    let urlToImage = NSURL.init(string: name)
    popImage.af.setImage(withURL: urlToImage! as URL)
        
    popTitle.text = title
    popCast.text = "tes"
    popTitle.textColor = .white
    popCast.textColor = .white
  }
}
