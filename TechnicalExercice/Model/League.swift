//
//  League.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation

struct AllLeagues: Decodable {
  var leagues: [League]?
  
  enum CodingKeys: String, CodingKey {
    case leagues
  }
}

struct League: Decodable {
  var id: String?
  var name: String?
  var sport: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "idLeague"
    case name = "strLeagueAlternate"
    case sport = "strSport"
  }
}
