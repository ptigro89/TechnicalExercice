//
//  SearchLeagueResultsViewController.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation
import UIKit

class SearchLeagueResultsViewController: UIViewController {
  
  private let tableViewCellIdentifier = "ResultTableViewCellIdentifier"
  
  private var presenter: SearchLeagueResultsPresenter?
  
  private var leagueTitles = [String]()
  
  @IBOutlet weak var tableView: UITableView!
  
  static func create(with searchParentPresenter: SearchLeaguePresenter) -> SearchLeagueResultsViewController {
    let presenter = SearchLeagueResultsPresenter(searchParentPresenter: searchParentPresenter)
    let searchLeagueResultsViewController = SearchLeagueResultsViewController(nibName: String(describing: SearchLeagueResultsViewController.self), bundle: nil)
    
    searchLeagueResultsViewController.presenter = presenter
    presenter.searchLeagueResultsViewDelegate = searchLeagueResultsViewController
    
    return searchLeagueResultsViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(LeagueSearchResultTableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
  }
  
}

extension SearchLeagueResultsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return leagueTitles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? LeagueSearchResultTableViewCell else {
      return UITableViewCell()
    }
    
    cell.configure(with: leagueTitles[indexPath.row])
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.selectLeague(at: indexPath.row)
  }
  
}

extension SearchLeagueResultsViewController: SearchLeagueResultsViewDelegate {
  
  func updateLeagues(_ titles: [String]) {
    leagueTitles = titles
    tableView.reloadData()
  }
  
  func selectedLeague() {
    dismiss(animated: true)
  }

}

extension SearchLeagueResultsViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    presenter?.filterLeagues(searchController.searchBar.text)
  }

}
