//
//  PopularViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 15/02/21.
//

import UIKit

class PopularViewController: UIViewController {

  
  @IBOutlet weak var collectionView: UICollectionView!
  
  @IBOutlet weak var searchTextField: UITextField!
  
  override func viewDidLoad() {
            super.viewDidLoad()
    let imageView = UIImageView()
    let image = UIImage(systemName: "magnifyingglass")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
    image?.withTintColor(.white)
    imageView.image = image
    searchTextField.rightView = imageView
    searchTextField.rightViewMode = UITextField.ViewMode.always

    searchTextField.rightViewMode = .always

    collectionView.dataSource = self
    collectionView.delegate = self
        }
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }

    }

extension PopularViewController: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popCell", for: indexPath) as! PopularCollectionViewCell
    cell.configure(withImageName: "image1")
//
//    cell.popImage.image = UIImage(named: "image1")
//    cell.titlePop.text = "maze runner"
//    cell.castPop.text = "obrina, kayak , will"
//as! PopularCollectionViewCell
    
    return cell
  }
  
  
}

extension PopularViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
    let size1:CGFloat = (collectionView.frame.size.width - space) * 0.75

           return CGSize(width: size, height: size1)
      }
}


  
