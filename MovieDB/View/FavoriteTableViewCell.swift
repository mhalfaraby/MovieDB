//
//  FavoriteTableViewCell.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 22/02/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

  @IBOutlet weak var label: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
