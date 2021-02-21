//
//  PopularViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 15/02/21.
//

import UIKit

class PopularViewController: UIViewController {

  

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
//    let image:UIImage = UIImage(named: "Search")!
//    let imageV:UIImageView = UIImageView.init(image: image)
//    searchTextField.rightView = imageV
//    searchTextField.rightViewMode = .always
        }
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }

    }



  
