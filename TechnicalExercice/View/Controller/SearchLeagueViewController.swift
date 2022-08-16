//
//  File.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation
import UIKit
import AlamofireImage

class SearchLeagueViewController: UICollectionViewController {
  
  private let collectionViewCellIdentifier = "TeamCollectionViewCellIdentifier"
  private let collectionViewItemSpacing = 10.0
  
  private var presenter: SearchLeaguePresenter?
  var searchController: UISearchController?
  
  var items = [SearchLeagueViewData]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "search_league_title".localized
    
    configurePresenter()
    
    if let presenter = presenter {
      let searchResultViewController = SearchLeagueResultsViewController.create(with: presenter)
                                                                                
      searchController = UISearchController(searchResultsController: searchResultViewController)
      searchController?.searchResultsUpdater = searchResultViewController
      searchController?.obscuresBackgroundDuringPresentation = false
      searchController?.searchBar.placeholder = "search_league_placeholder".localized
      navigationItem.searchController = searchController
      
      searchController?.searchBar.searchTextField.accessibilityIdentifier = AccessibilityIdentifier.leaguesSearchBar.rawValue
    }
    
    collectionView.register(TeamCollectionViewCell.nib, forCellWithReuseIdentifier: collectionViewCellIdentifier)
  }
  
  func configurePresenter() {
    presenter = SearchLeaguePresenter()
    presenter?.searchLeagueViewDelegate = self
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as? TeamCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    cell.configure(with: items[indexPath.row])
    
    return cell
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    
    collectionView.collectionViewLayout.invalidateLayout()
  }
  
}

extension SearchLeagueViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemsNumber = view.traitCollection.horizontalSizeClass == .compact ? 2.0 : 5.0
    let width = (collectionView.frame.width - collectionViewItemSpacing * (itemsNumber + 1)) / itemsNumber
    
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return collectionViewItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return collectionViewItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: collectionViewItemSpacing, left: collectionViewItemSpacing, bottom: collectionViewItemSpacing, right: collectionViewItemSpacing)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter?.selectTeam(at: indexPath.row)
  }
  
}

extension SearchLeagueViewController: SearchLeagueViewDelegate {
  
  func updateLeague(_ title: String?, leagueDatas: [SearchLeagueViewData]) {
    searchController?.searchBar.text = title
    items = leagueDatas
    collectionView.reloadData()
  }
  
  func selectTeam(with presenter: TeamDetailsPresenter) {
    let teamDetailsViewController = TeamDetailsViewController.create(with: presenter)
            
    navigationController?.pushViewController(teamDetailsViewController, animated: true)
  }
  
}


