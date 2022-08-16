//
//  SearchLeaguePresenter.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation

struct SearchLeagueViewData {
  var teamBadgeUrl: URL?
  var teamIdentifier: String?
}

protocol SearchLeagueViewDelegate: AnyObject {
  func updateLeague(_ title: String?, leagueDatas: [SearchLeagueViewData])
  func selectTeam(with presenter: TeamDetailsPresenter)
}

class SearchLeaguePresenter {
  
  weak var searchLeagueViewDelegate: SearchLeagueViewDelegate?
  
  private var teams = [Team]()
  
  func select(_ league: League) {
    guard let identifier = league.id else { return }
    
    ServiceManager.shared.requestLeague(identifier) { [weak self] allTeams in
      guard let teams = allTeams?.teams else { return }
      
      self?.teams = teams
      
      var leagueDatas = [SearchLeagueViewData]()
      teams.forEach {
        var teamBadgeUrl: URL?
        if let badgeUrl = $0.badgeUrl {
          teamBadgeUrl = URL(string: badgeUrl)
        }
        
        leagueDatas.append(SearchLeagueViewData(teamBadgeUrl: teamBadgeUrl, teamIdentifier: $0.id))
      }
      
      self?.searchLeagueViewDelegate?.updateLeague(league.name, leagueDatas: leagueDatas)
    }
  }
  
  func selectTeam(at index: Int) {
    guard index < teams.count, let teamIdentifier = teams[index].id else { return }
    
    let teamDetailsPresenter = TeamDetailsPresenter(identifier: teamIdentifier)
    searchLeagueViewDelegate?.selectTeam(with: teamDetailsPresenter)
  }
  
}
