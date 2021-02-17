//
//  AlbumItemCell.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 16/02/21.
//

import UIKit
import AlamofireImage
class AlbumItemCell: UICollectionViewCell {
    
  static let reuseIdentifer = "album-item-cell-reuse-identifier"
  let featuredPhotoView = UIImageView()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
//        featuredPhotoView.layer.cornerRadius = 10
        featuredPhotoView.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withImageName name: String) {
        
        featuredPhotoView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(featuredPhotoView)
        
        NSLayoutConstraint.activate([

            featuredPhotoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featuredPhotoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            featuredPhotoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            featuredPhotoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
      let urlToImage = NSURL.init(string: name)
      featuredPhotoView.af.setImage(withURL: urlToImage! as URL)
//
//        featuredPhotoView.image = UIImage(named: name)
    }
}




