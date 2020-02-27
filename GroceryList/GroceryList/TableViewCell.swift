//
//  TableViewCell.swift
//  GroceryList
//
//  Created by Jokela, Benjamin on 2020-02-27.
//  Copyright © 2020 Jokela, Benjamin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
