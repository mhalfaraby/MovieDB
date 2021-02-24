//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 15/02/21.
//

import UIKit
import Alamofire
import AlamofireImage



class FavoriteViewController: UIViewController {
  let defaults = UserDefaults.standard
  
  @IBOutlet weak var searchTable: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  var tableData = ["One","Two","Three","Twenty-One"]
  var realTableData = ["One","Two","Three","Twenty-One"]

  var filteredTableData = [String]()
  var favorite: Detail?
  
  
  override func viewDidLoad() {
     super.viewDidLoad()
   
 }
  
  
  
 
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)


  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()


  }
  
  // kita mau ngapain ini
  // fetch id detail ?
  // terus gimane?
  // masukin satu satu?
  // 
  
  
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }
  func fetchDetail(id: Int) {
    let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
    let request =     AF.request("https://api.themoviedb.org/3/movie/\(id),?api_key=\(apiKey)&language=en-US").validate(statusCode: 200...500)
    request.responseDecodable(of: Detail.self) { (response) in
      guard let result = response.value else { return }
      self.favorite = result
    }
  }

  
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UIView()
    header.isUserInteractionEnabled = false
    header.backgroundColor = UIColor.clear
        return header
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
   
    if let data = defaults.array(forKey: "SavedMovie") {
      return data.count
    }
    else {
      return 0
    }
    
    
    
    
    
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteTableViewCell
    
    cell.label.text = "yow"
    
    let name = defaults.array(forKey: "image")
    let url = "https://image.tmdb.org/t/p/w500//\(String(describing: name![indexPath.section]))"
    
    let urlToImage = NSURL.init(string: url)
    
    cell.imagefavorite.af.setImage(withURL: urlToImage! as URL)
    
     return cell
  }
  
  
  
  
}


extension FavoriteViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    tableData.removeAll()
    
    for item in realTableData {
      if (item.contains(searchBar.text!)) {
        tableData.append(item)
      }
    }
    
    if (searchBar.text!.isEmpty) {
      tableData = realTableData
    }
    
    tableView.reloadData()
    
    
    
  }
}



 
