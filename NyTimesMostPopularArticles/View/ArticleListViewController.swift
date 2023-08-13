//
//  ArticleListViewController.swift
//  NyTimesMostPopularArticles
//
//  Created by Syed Faraz Haider Zaidi on 13/08/2023.
//

import UIKit
import Combine

class ArticleListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let activityIndicator = UIActivityIndicatorView(style:.large)
    
    
    private var viewModel = ArticleViewModel(networking: Networking())
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        self.view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        viewModel.$articles
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    if self?.viewModel.articles?.count ?? 0 > 0 {
                        self?.activityIndicator.stopAnimating()
                    }
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: APPConstants.kArticleCellIdentifier, for: indexPath) as! ArticleTableViewCell
        if let article = viewModel.articles,article.count > 0{
            cell.setDataForArticleListing(withArticle: article[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
        nextViewController.article = viewModel.articles?[indexPath.row]
        self.present(nextViewController, animated:true, completion:nil)
    }
}
