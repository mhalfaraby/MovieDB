//
//  DetailViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 15/02/21.
//

import UIKit
import AlamofireImage
import Alamofire

class DetailViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var imagePoster: UIImageView!
  var detailId: Int?
  var stringToimage: Movies?
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    if let name = stringToimage?.poster_path {
//      let url = "https://image.tmdb.org/t/p/w500//\(String(describing: name))"
//      let urlToImage = NSURL.init(string: url)
//          imagePoster.af.setImage(withURL: urlToImage! as URL)
//
//
//
//    }
    fetchDetail()
    print(detailId!)
//    imagePoster.af.setImage(withURL: urlToImage! as URL)

    
//    print(stringToimage?.backdrop_path)
//    if let url = "https://image.tmdb.org/t/p/w500//\(name)" {
//          let urlToImage = NSURL.init(string: url)
//
//    }
    
//
//
//      imagePoster.af.setImage(withURL: urlToImage! as URL)

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    self.navigationItem.setHidesBackButton(true, animated: true)

    self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController!.navigationBar.shadowImage = UIImage()
    self.navigationController!.navigationBar.isTranslucent = true
    navigationController?.navigationBar.tintColor = .yellow
    navigationController?.navigationBar.backgroundColor = .clear
  }
  
  func fetchDetail() {
//    https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key=0bc0b44455920f6f519ea6cf9094f2c4&language=en-US
    let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
    let request =     AF.request("https://api.themoviedb.org/3/movie/\(String(describing: detailId))/credits?api_key=\(apiKey)&language=en-US").validate(statusCode: 200...500)
    request.responseDecodable(of: Detail.self) { (response) in
      guard let result = response.value else { return }
      print(result)
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    
    
  }
  
  
  
}
}


extension DetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath)
    
    
    
    return cell
  }
  
  
  
  
}
extension UIView {
 
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }
  
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    get {
      return UIColor(cgColor: layer.borderColor!)
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
}



