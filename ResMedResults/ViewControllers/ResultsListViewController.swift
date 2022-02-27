//
//  ResultsListViewController.swift
//  ResMedResults
//
//  Created by matt rooney on 27/02/2022.
//

import UIKit

class ResultsListViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var activityView: UIActivityIndicatorView?
    
    var sportsResults = [SportResult]()
    let resultsService: ResultsService
    
    init(_ resultsService: ResultsService = ResultsService()) {
        self.resultsService = resultsService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        retrieveResults()
    }
    
    func retrieveResults() {
        showLoadingSpinner()
        resultsService.getResults(completion: { result in
            switch result {
            case .success(let resultResponse):
                self.view = self.tableView
                self.sportsResults = resultResponse.listResults()
                self.tableView.reloadData()
            case .failure(let error):
                self.removeLoadingSpinner()
                self.showAlert(for: error, tryAgainHandler: self.retryResultsRetrieval)
                print(error.localizedDescription)
            }
        })
    }
    
    func showLoadingSpinner(){
        activityView = UIActivityIndicatorView(style: .large)
        activityView!.startAnimating()
        view.addSubview(activityView!)
        activityView!.center = view.center
    }
    
    func removeLoadingSpinner(){
        activityView!.removeFromSuperview()
    }
    
    func showAlert(for error: Error, tryAgainHandler: @escaping ((UIAlertAction) -> Void)) {
        let message = "\(error.localizedDescription) \nPlease try again."
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let actionTryAgain = UIAlertAction(title: "Try again",
                                     style: .default,
                                     handler: tryAgainHandler)
        
        let actionCancel = UIAlertAction(title: "Cancel",
                                     style: .cancel,
                                     handler: nil)
        
        alertController.addAction(actionCancel)
        alertController.addAction(actionTryAgain)
        present(alertController, animated: true, completion: nil)
    }
    
    func retryResultsRetrieval(alert: UIAlertAction!){
        self.retrieveResults()
    }

}

extension ResultsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportsResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let result = sportsResults[indexPath.row]
        cell.textLabel?.text = result.titleText()
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
}
