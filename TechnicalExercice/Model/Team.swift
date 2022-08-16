//
//  Team.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation

struct AllTeams: Decodable {
  var teams: [Team]?
  
  enum CodingKeys: String, CodingKey {
    case teams
  }
}

struct AllTeamDetails: Decodable {
  var teams: [TeamDetails]?
  
  enum CodingKeys: String, CodingKey {
    case teams
  }
}

struct Team: Decodable {
  var id: String?
  var badgeUrl: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "idTeam"
    case badgeUrl = "strTeamBadge"
  }
}

struct TeamDetails: Decodable {
  var name: String?
  var bannerUrl: String?
  var country: String?
  var league: String?
  var description: String?
  
  enum CodingKeys: String, CodingKey {
    case name = "strTeam"
    case bannerUrl = "strTeamBanner"
    case country = "strCountry"
    case league = "strLeague"
    case description = "strDescriptionEN"
  }
}
