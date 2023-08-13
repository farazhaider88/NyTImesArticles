//
//  ArticleDetailViewController.swift
//  NYTimesMostPopularArticles
//
//  Created by Syed Faraz Haider Zaidi on 05/09/2022.
//

import Foundation
import UIKit
import Kingfisher

class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var byLineLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var dateIcon:UIImageView!
    @IBOutlet weak var articleIcon:UIImageView!
    @IBOutlet weak var descriptionLabel:UILabel!
    
    var article : Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    func setupData() {
        
        guard let article = article else {
            return
        }
        titleLabel?.text = article.title
        byLineLabel?.text = article.byline
        descriptionLabel?.text = article.abstract
        dateLabel?.text = article.published_date
        
        if let urlStr = article.media?.first?.media_metadata?.first?.url {
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
