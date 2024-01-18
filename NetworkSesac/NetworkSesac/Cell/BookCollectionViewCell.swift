//
//  BookCollectionViewCell.swift
//  NetworkSesac
//
//  Created by 김재석 on 1/18/24.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    @IBOutlet var bookImageLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        ratingLabel.font = .systemFont(ofSize: 13)
        bookImageLabel.contentMode = .scaleAspectFit
    }
    
    func setDataInCell(data: Document) {
        let imgUrl = URL(string: data.thumbnail)
        bookImageLabel.kf.setImage(with: imgUrl)
        ratingLabel.text = "9"
        titleLabel.text = data.title
    }

}
