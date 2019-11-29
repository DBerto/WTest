//
//  PostalCodeTableViewCell.swift
//  WTest
//
//  Created by David Berto on 28/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {
   
    // MARK: UI Properties
    @IBOutlet weak var articleItemView: ArticleItemView!
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
