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

  let defaults = UserDefaults.standard
  let encoder = JSONEncoder()

  @IBOutlet weak var genre1: UILabel!
  @IBOutlet weak var genre2: UILabel!
  @IBOutlet weak var genre3: UILabel!
  @IBOutlet weak var detailTitle: UILabel!
  @IBOutlet weak var runtime: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var imagePoster: UIImageView!
  @IBOutlet weak var detailOverview: UITextView!
  var detailId: Int?
  var stringToimage: Movies?
  var detail: Detail?
  var detailCast:[Cast] = []
  var countCast = [String]()
  var genre = [String?]()
  @IBOutlet weak var buttons: UIButton!
  
  var favoriteDetail: Detail?
  
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchDetail(id: detailId!)
    fetchCast(id: detailId!)
    
    
    
    collectionView.reloadData()

    
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if detailId == defaults.integer(forKey: favoriteDetail!.title) {
    
        buttons.isSelected = true
       buttons.backgroundColor = .systemYellow
      buttons.setTitle("Remove from Favorite", for: .selected)
       buttons.setTitleColor(.black, for: .selected)
    }

  }
  
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }
 
  // ketika di add save id
  // create array berdasarkan id nya
  // tambah ke tableview
  // setelah itu fetch di favorite?
  //
  @IBAction func addToFavorite(_ sender: Any?) {
    
   
    if let button : UIButton = sender as? UIButton
       {
      
      
      
      button.isSelected = !button.isSelected
            
           if (button.isSelected)
           {
            button.backgroundColor = .systemYellow
            button.setTitle("Remove from Favorite", for: .selected)
            button.setTitleColor(.black, for: .selected)
            
//                        var currentArray = defaults.array(forKey: "SavedMovie") as? [Int] ?? []
//                        currentArray.append(detailId!)
//            defaults.set([detailId], forKey: "SavedMovie")
            var currentArray:[Int] = defaults.array(forKey: "SavedMovie")as? [Int] ?? []
            var image:[String] = defaults.array(forKey: "image")as? [String] ?? []
            var title:[String] = defaults.array(forKey: "title")as? [String] ?? []

//
            currentArray.append(detailId!)
            image.append(favoriteDetail!.backdrop_path)
            title.append(favoriteDetail!.title)


//            print(currentArray)

            defaults.set(currentArray, forKey: "SavedMovie")
            defaults.set(image, forKey: "image")
            defaults.set(title, forKey: "title")


//            print(defaults.array(forKey: "SavedMovie") as Any)

            defaults.set(detailId, forKey: favoriteDetail!.title)

            
//            var array: [Any]?
//
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(favoriteDetail) {
//                let defaults = UserDefaults.standard
//              array?.append(encoded)
//                defaults.set(array, forKey: "SavedMovie")
//            }
            
//            let defaults = UserDefaults.standard
//
//            // Your new score:
//
//            let newScore = 75
//
//            // Get your current scores list from User Defaults:
//
//            var currentArray = defaults.array(forKey: "Scores") as? [Int] ?? []
//
//            // Append your new score to the current array:
//
//            let updatedArray = currentArray.append(newScore)
//
//            // And save your updated array to User Defaults:
//
//            defaults.set(updatedArray, forKey: "Scores")
//
//            // In this example, your User Defaults now contains the updated array [25, 50, 75
            
            
            
            
            
           }
           else 
           {
            button.backgroundColor = .clear

            button.setTitle("Add to Favorite", for: .selected)
            
            defaults.removeObject(forKey: favoriteDetail!.title)
            
            
            let currentArray:[Int] = defaults.array(forKey: "SavedMovie")as? [Int] ?? []
            let removed = currentArray.filter{$0 != detailId}
            
            let currentImage:[String] = defaults.array(forKey: "image")as? [String] ?? []
            let removedImage = currentImage.filter{$0 != favoriteDetail?.backdrop_path}

            defaults.removeObject(forKey: "SavedMovie")
            defaults.set(removed, forKey: "SavedMovie")
            
            defaults.removeObject(forKey: "image")
            defaults.set(removedImage, forKey: "image")

            
           }
    
       }
  }
  
  
  
 
 
  func fetchDetail(id: Int) {
    let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
    let request =     AF.request("https://api.themoviedb.org/3/movie/\(detailId!),?api_key=\(apiKey)&language=en-US").validate(statusCode: 200...500)
    request.responseDecodable(of: Detail.self) { (response) in
      guard let result = response.value else { return }
      
      self.favoriteDetail = result
//      print(self.favoriteDetail!.title)
//      print(self.favoriteDetail)

      

      
      
      let name = result.poster_path
      let url = "https://image.tmdb.org/t/p/w500//\(String(describing: name))"
      
      let urlToImage = NSURL.init(string: url)
      self.imagePoster.af.setImage(withURL: urlToImage! as URL)
//      self.favoriteDetail.append(contentsOf: [url])


      
      self.detailTitle.text = result.title
      self.detailOverview.text = result.overview
      
      
      
      let hours = result.runtime / 60
      let minutes = result.runtime % 60
      self.runtime.text = ("\(hours)h \(minutes)m")
      
      self.genre.append(contentsOf: result.genres.map{$0.name})
      
      self.genre1.text = self.genre[0]
      
      let intendedIndex: Int = 1
      
      if (intendedIndex >= 0 && self.genre.count > intendedIndex) {
        let genre2 = self.genre[intendedIndex]
        
        self.genre2.text = genre2
      } else {
        self.genre3.text = ""
      }
      
      let intendedIndex2: Int = 2
      
      if (intendedIndex >= 0 && self.genre.count > intendedIndex2) {
        let genre3 = self.genre[intendedIndex2]
        
        self.genre3.text = genre3
      } else {
        self.genre3.text = ""
      }

    }
    

    
    
    
  }
  
  
  
  func fetchCast(id: Int) {
    let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
    let request = AF.request("https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(apiKey)&language=en-US").validate(statusCode: 200...500)
    request.responseDecodable(of: Cast.self) { (response) in
      guard let result = response.value else { return }
      
      self.detailCast = [result]
      result.cast.forEach { (Casts) in
        if let cast = Casts.profile_path {
          self.countCast.append(cast)
        }
      }
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
    
    
    
    
    
    
  }
  
}



extension DetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return countCast.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! MoviesCollectionViewCell
    
    
    
    
    if let name = detailCast[0].cast[indexPath.row].profile_path {
      let url = "https://image.tmdb.org/t/p/w500/\(name)"
      let urlToImage = NSURL.init(string: url)
      cell.castImage.af.setImage(withURL: urlToImage! as URL)
      
    } else {
      cell.castImage.image = UIImage(systemName: "person.circle")
      
    }
    
    cell.castName.text = detailCast[0].cast[indexPath.row].name
    
    
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



