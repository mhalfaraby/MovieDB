//
//  PopularViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 15/02/21.
//

import UIKit
import Alamofire
import AlamofireImage

class PopularViewController: UIViewController {

  var selectedItem: Int?

  @IBOutlet weak var collectionView: UICollectionView!
  
  @IBOutlet weak var searchTextField: UITextField!
  
  let defaults = UserDefaults.standard
  
  var popularArray = [Movies]()
  var realPopularArray = [Movies]()

  
  override func viewDidLoad() {
            super.viewDidLoad()
    let imageView = UIImageView()
    let image = UIImage(systemName: "magnifyingglass")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
    image?.withTintColor(.white)
    imageView.image = image
//    searchTextField.rightView = imageView
//    searchTextField.rightViewMode = UITextField.ViewMode.always
//
//    searchTextField.rightViewMode = .always

    collectionView.dataSource = self
    collectionView.delegate = self
    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        layout.sectionHeadersPinToVisibleBounds = true
      
      navigationController?.isNavigationBarHidden = true

      
      
    }
    fetchPopular()
    
    
        }
  
  func fetchPopular () {
    let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
    let request =     AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&year=2021").validate(statusCode: 200...500)
    request.responseDecodable(of: MovieModel.self) { (response) in
      guard let result = response.value else { return }
      self.popularArray = result.results
      self.realPopularArray = result.results
//      self.popularArrayCount = result
//      print(result.results.count)
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }

    }

extension PopularViewController: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return popularArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popCell", for: indexPath) as! PopularCollectionViewCell
    let name = popularArray[indexPath.row].poster_path
    let url = "https://image.tmdb.org/t/p/w500/\(name)"
    let popTitle = popularArray[indexPath.row].title
//    let popCast = popularArray[indexPath.row].
    cell.configure(withImageName: url, title: popTitle)
//
//    cell.popImage.image = UIImage(named: "image1")
//    cell.titlePop.text = "maze runner"
//    cell.castPop.text = "obrina, kayak , will"
//as! PopularCollectionViewCell
    
    
    
    
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "popSearch", for: indexPath)
    
    return searchView
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

extension PopularViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    popularArray.removeAll()
    
    for item in realPopularArray {
      if (item.title.contains(searchBar.text!)) {
        popularArray.append(item)
      }
    }
    
    if (searchBar.text!.isEmpty) {
      popularArray = realPopularArray
    }
    
    collectionView.reloadData()
    
    
    
  }
}

extension PopularViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = popularArray[indexPath.row].id
    selectedItem = movie
    
    performSegue(withIdentifier: "toDetail", sender: self)
    
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDetail" {
      let detailVC = segue.destination as! DetailViewController
      detailVC.detailId = selectedItem!
    }
  }
  
}


  
