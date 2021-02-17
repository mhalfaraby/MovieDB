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
  
  @IBOutlet weak var collectionView: UICollectionView!
  //  var movies: String?
  var urlBackdropPath = [[MovieModel]]()
//
//  var simpleDataSource: [[String]] = [
//    ["image1", "image2"],
//    ["image3", "image4"],
//    ["image5", "image6"]
//  ]
  
  let headerId = "headerId"
  let arrImages = ["image1", "image2", "image3", "image4", "image5", "image6"]
  let categoryHeaderId = "categoryHeaderId"
  
  override func viewDidLoad() {
    fetchBanner()
    
    fetchPopular()
    fetchUpcoming()
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = false
    
    collectionView.register(AlbumItemCell.self, forCellWithReuseIdentifier: AlbumItemCell.reuseIdentifer)
    collectionView.register(CategoryHeaderView.self, forSupplementaryViewOfKind: categoryHeaderId, withReuseIdentifier: headerId)
    collectionView.register(Coba.self, forSupplementaryViewOfKind: "tes", withReuseIdentifier: headerId)
    
    
    collectionView.collectionViewLayout = createCompositionalLayout()

    
  }
  func fetchBanner() {
    
    
    let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
    let request =  AF.request("https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1").validate(statusCode: 200...500)
    request.responseDecodable(of: MovieModel.self) { (response) in
      guard let result = response.value else { return }
      
      self.urlBackdropPath.append([result])
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
      
    }
  }
  func fetchPopular() {
    let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
    let request =     AF.request("https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1").validate(statusCode: 200...500)
    request.responseDecodable(of: MovieModel.self) { (response) in
      guard let result = response.value else { return }
      self.urlBackdropPath.append([result])
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
      
     
      
    }
  }
  func fetchUpcoming() {
    let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
    let request =     AF.request("https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1").validate(statusCode: 200...500)
    request.responseDecodable(of: MovieModel.self) { (response) in
      guard let result = response.value else { return }
      self.urlBackdropPath.append([result])
      //      print(self.urlBackdropPath)
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
//      DispatchQueue.main.async {
//      }
      
//      print(self.urlBackdropPath[0][0].results.count)
      
    }
  }
  
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      
      switch sectionNumber {
      
      case 0: return self.firstLayoutSection()
      case 1: return self.secondLayoutSection()
      default: return self.thirdLayoutSection()
      //          case 2: return self.thirdLayoutSection()
      //          default: return self.fourthLayoutSection()
      }
    }
  }
  
  private func firstLayoutSection() -> NSCollectionLayoutSection {
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets.bottom = 15
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    let section = NSCollectionLayoutSection(group: group)
    
    section.orthogonalScrollingBehavior = .groupPagingCentered
    
    return section
  }
  
  private func secondLayoutSection() -> NSCollectionLayoutSection {
    
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets.bottom = 30
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.5))
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets.leading = 15
    section.orthogonalScrollingBehavior = .continuous
    
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: categoryHeaderId, alignment: .top)
    ]
    
    return section
  }
  
  private func thirdLayoutSection() -> NSCollectionLayoutSection {
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.8))
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets.bottom = 30
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.5))
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets.leading = 15
    section.contentInsets.top = 15
    
    
    
    section.orthogonalScrollingBehavior = .continuous
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: "tes", alignment: .top)
    ]
    return section
  }
  
  
}

//MARK: - UICollectionViewDataSource Methods
extension HomeViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    
    return urlBackdropPath.count
    //    return simpleDataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //    return urlBackdropPath.count
//    return urlBackdropPath[section][0].results.count
    
    switch section {
    case 0: return urlBackdropPath[section][0].results.count
    case 1: return urlBackdropPath[section][0].results.count-10
    case 2: return urlBackdropPath[section][0].results.count-10
    default:
      return urlBackdropPath[section][0].results.count
    }
    
    //    return urlBackdropPath[section].count
    //    return simpleDataSource[section].count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumItemCell.reuseIdentifer, for: indexPath) as! AlbumItemCell
    
   
    
    
    switch indexPath.section {
    case 0:
      let name = urlBackdropPath[indexPath.section][0].results[indexPath.row].backdrop_path
          let url = "https://image.tmdb.org/t/p/w500//\(name)"
      
      cell.configure(withImageName: url)
      
    case 1:
      let name = urlBackdropPath[indexPath.section][0].results[indexPath.row].poster_path
          let url = "https://image.tmdb.org/t/p/w500//\(name)"
      
      cell.configure(withImageName: url)
    case 2:  let name = urlBackdropPath[indexPath.section][0].results[indexPath.row].poster_path
      let url = "https://image.tmdb.org/t/p/w500//\(name)"
  
  cell.configure(withImageName: url)
    default:
      let name = urlBackdropPath[indexPath.section][0].results[indexPath.row].poster_path
          let url = "https://image.tmdb.org/t/p/w500//\(name)"
      
      cell.configure(withImageName: url)
    }
    
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
    
    return header
  }
}









