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
  override init(frame: CGRect) {
      
      super.init(frame: frame)
      
//        featuredPhotoView.layer.cornerRadius = 10
    popImage.layer.masksToBounds = true
    popTitle.layer.masksToBounds = true

  }

  required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
  }
  
  func configure(withImageName name: String) {
      
    popImage.translatesAutoresizingMaskIntoConstraints = false
    popTitle.translatesAutoresizingMaskIntoConstraints = false

      contentView.addSubview(popImage)
    contentView.addSubview(popTitle)

      NSLayoutConstraint.activate([
        popImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        popImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        popImage.topAnchor.constraint(equalTo: contentView.topAnchor),
        popImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
        popTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        popTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        popTitle.topAnchor.constraint(equalTo: popImage.bottomAnchor),
        
      ])
//    let urlToImage = NSURL.init(string: name)
//    popImage.af.setImage(withURL: urlToImage! as URL)
////
        popImage.image = UIImage(named: name)
    popTitle.text = "tes"
  }
}
