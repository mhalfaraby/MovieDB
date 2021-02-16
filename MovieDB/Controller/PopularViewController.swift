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
    
    let image:UIImage = UIImage(named: "Search")!
    let imageV:UIImageView = UIImageView.init(image: image)
    searchTextField.rightView = imageV
    searchTextField.rightViewMode = .always
        }

    }

  
