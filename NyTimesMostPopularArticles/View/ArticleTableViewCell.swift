//
//  ArticleCell.swift
//  NYTimesMostPopularArticles
//
//  Created by Syed Faraz Haider Zaidi on 05/09/2022.
//

import Foundation
import UIKit
import Kingfisher


class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var dateIcon:UIImageView!
    @IBOutlet weak var articleIcon:UIImageView!
    @IBOutlet weak var bylineLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataForArticleListing(withArticle:Article){
        titleLabel.text = withArticle.title
        descriptionLabel.text = withArticle.abstract
        dateLabel.text = withArticle.published_date
        bylineLabel.text = withArticle.byline
        
        if let urlStr = withArticle.media?.first?.media_metadata?.first?.url {
            let url = URL(string: urlStr)
            
            let processor = RoundCornerImageProcessor(cornerRadius: 20)
            articleIcon.kf.indicatorType = .activity
            articleIcon.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeHolder"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        
        }
    
    }
    
}
