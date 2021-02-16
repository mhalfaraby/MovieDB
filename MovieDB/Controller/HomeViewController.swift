//
//  ViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 15/02/21.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeViewController: UIViewController {

  var movies: String?
  var urlImage: String?
 
  override func viewDidLoad() {
    
    
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = false

    fetchNews()
    
    // Do any additional setup after loading the view.
  }
  func fetchNews() {
  let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
  let request =     AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1").validate(statusCode: 200...500)
    request.responseDecodable(of: MovieModel.self) { (response) in
    guard let result = response.value else { return }
      self.movies = result.results[0].poster_path
      self.urlImage = "https://image.tmdb.org/t/p/w500\(String(describing: self.movies!))"
      print(self.urlImage!)

      
//      if let image = result.
      
//      if let image = result. {
//              let urlToImage = NSURL.init(string: image)
//              cell.imageNews.af.setImage(withURL: urlToImage! as URL)
//      }
      
  }
}


}



  


