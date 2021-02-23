//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 15/02/21.
//

import UIKit



class FavoriteViewController: UIViewController {
  
  
  @IBOutlet weak var searchTable: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  var tableData = ["One","Two","Three","Twenty-One"]
  var realTableData = ["One","Two","Three","Twenty-One"]

  var filteredTableData = [String]()
  var favorite = DetailViewController()
  
  override func viewDidLoad() {
     super.viewDidLoad()
    cetak()
 }
  
  func cetak() {
    print(favorite.favoriteDetail)
  }
  
 
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    cetak()

  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    cetak()


  }
  
  
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
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
    return tableData.count
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteTableViewCell
    
    cell.label.text = tableData[indexPath.section]
    
    
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



 
