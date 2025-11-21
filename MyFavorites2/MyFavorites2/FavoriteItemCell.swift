//
//  FavoriteItemCell.swift
//  MyFavorites2
//
//  Created by Amire Abdikadyr on 21.11.2025.
//

import UIKit

class FavoriteItemCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewLabel.numberOfLines = 0
        

        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        itemImageView.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
