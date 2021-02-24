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
  let defaults = UserDefaults.standard

  @IBOutlet weak var collectionView: UICollectionView!
  var urlBackdropPath = [[MovieModel]]()
  var selectedItem: Int?
  var favoriteDetail: Detail?

  
  let headerId = "headerId"
  let categoryHeaderId = "categoryHeaderId"
  
  override func viewDidLoad() {
    
//    if let savedMovie = defaults.array(forKey: "SavedMovie") as? Data {
//        let decoder = JSONDecoder()
//        if let loadedMovie = try? decoder.decode(Detail.self, from: savedMovie) {
//          print(savedMovie)
//        }
//    }
    print(defaults.array(forKey: "image"))
    
   
    
    fetchBanner()
    
    fetchPopular()
    fetchUpcoming()
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = false
    
    collectionView.register(AlbumItemCell.self, forCellWithReuseIdentifier: AlbumItemCell.reuseIdentifer)
    collectionView.register(CategoryHeaderView.self, forSupplementaryViewOfKind: categoryHeaderId, withReuseIdentifier: headerId)
    collectionView.register(CategoryHeaderView1.self, forSupplementaryViewOfKind: "Header1", withReuseIdentifier: headerId)
    
    
    collectionView.collectionViewLayout = createCompositionalLayout()
    
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController!.navigationBar.isTranslucent = false
    
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
    let request =     AF.request("https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1&region=ID").validate(statusCode: 200...500)
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
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
      
    }
  }
  
  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      
      switch sectionNumber {
      
      case 0: return self.firstLayoutSection()
      case 1: return self.secondLayoutSection()
      default: return self.thirdLayoutSection()
        
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
    section.contentInsets.top = 15
    
    section.orthogonalScrollingBehavior = .continuous
    
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: categoryHeaderId, alignment: .top)
    ]
    
    return section
  }
  
  private func thirdLayoutSection() -> NSCollectionLayoutSection {
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    
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
      NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: "Header1", alignment: .top)
    ]
    return section
  }
  
  
}

//MARK: - UICollectionViewDataSource Methods
extension HomeViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    
    return urlBackdropPath.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    
    switch section {
    case 0: return urlBackdropPath[section][0].results.count
    case 1: return urlBackdropPath[section][0].results.count-10
    case 2: return urlBackdropPath[section][0].results.count-10
    default:
      return urlBackdropPath[section][0].results.count
    }
    
    
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

extension HomeViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = urlBackdropPath[indexPath.section][0].results[indexPath.row].id
    selectedItem = movie
    
  
    performSegue(withIdentifier: "toDetail", sender: self)
    
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDetail" {
      let detailVC = segue.destination as! DetailViewController
      detailVC.detailId = selectedItem!
      
      
//      if let selected = selectedItem  {
//        if selected == defaults.integer(forKey: selectedTitle) {
//        detailVC.buttons.isSelected = true
//        detailVC.buttons.backgroundColor = .systemYellow
//        detailVC.buttons.setTitle("Remove from Favorite", for: .selected)
//        detailVC.buttons.setTitleColor(.black, for: .selected)
//        }
//      }
      
    }
  }
  
}










