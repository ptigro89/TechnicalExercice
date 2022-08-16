//
//  SearchLeagueResultsPresenter.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation

protocol SearchLeagueResultsViewDelegate: AnyObject {
  func updateLeagues(_ titles: [String])
  func selectedLeague()
}

class SearchLeagueResultsPresenter {
  
  weak var searchLeagueResultsViewDelegate: SearchLeagueResultsViewDelegate?
  private weak var searchParentPresenter: SearchLeaguePresenter?
  
  private var leagues = [League]()
  private var filterLeagues = [League]()
  
  init(searchParentPresenter: SearchLeaguePresenter) {
    self.searchParentPresenter = searchParentPresenter
    
    ServiceManager.shared.requestAllLeagues { [weak self] allLeagues in
      if let leagues = allLeagues?.leagues?.filter({ $0.sport == "Soccer" && ($0.name?.count ?? 0) > 0 }) {
        self?.leagues = leagues
      }
    }
  }
  
  func filterLeagues(_ query: String?) {
    if let query = query, query.count > 0 {
      filterLeagues = leagues.filter({ $0.name?.uppercased().contains(query.uppercased()) ?? false })
    } else {
      filterLeagues = leagues
    }
    
    searchLeagueResultsViewDelegate?.updateLeagues(filterLeagues.compactMap({ $0.name }))
  }
  
  func selectLeague(at index: Int) {
    guard index < filterLeagues.count else { return }
    
    searchParentPresenter?.select(filterLeagues[index])
    searchLeagueResultsViewDelegate?.selectedLeague()
  }
  
}
