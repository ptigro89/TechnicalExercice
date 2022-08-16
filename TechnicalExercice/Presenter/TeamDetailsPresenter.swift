//
//  TeamDetailsPresenter.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation

protocol TeamDetailsViewDelegate: AnyObject {
  func updateDetails(name: String?, bannerUrl: URL?, country: String?, league: String?, description: String?)
}

class TeamDetailsPresenter {
  
  weak var teamDetailsViewDelegate: TeamDetailsViewDelegate?
  
  private let teamIdentifier: String
  
  init(identifier: String) {
    self.teamIdentifier = identifier
  }
  
  func configureView() {
    ServiceManager.shared.requestTeamDetails(teamIdentifier) { [weak self] allTeamDetails in
      guard let teamDetails = allTeamDetails?.teams?.first else { return }
      
      var bannerUrl: URL?
      if let url = teamDetails.bannerUrl {
        bannerUrl = URL(string: url)
      }
      
      self?.teamDetailsViewDelegate?.updateDetails(name: teamDetails.name, bannerUrl: bannerUrl, country: teamDetails.country, league: teamDetails.league, description: teamDetails.description)
    }
  }
  
}
