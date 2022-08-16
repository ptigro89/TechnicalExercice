//
//  APIManager.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation
import Alamofire

class ServiceManager {
  
  private enum RequetType: Equatable {
    case allLeagues
    case leagueTeams(identifier: String)
    case team(identifier: String)
  }
  
  static let shared = ServiceManager()
  private let baseUrl: String?
  
  private var cancelableRequest: DataRequest?
  
  private init() {
    guard let apiBaseUrl = Bundle.appConfig?["apiBaseUrl"] as? String,
          let apiKey = Bundle.appConfig?["apiKey"] as? String else {
      baseUrl = nil
      return
    }
    
    baseUrl = "\(apiBaseUrl)/\(apiKey)"
  }
  
  func requestAllLeagues(_ completion: @escaping ((AllLeagues?) -> Void)) {
    cancelableRequest?.cancel()
    cancelableRequest = request(.allLeagues)
    
    cancelableRequest?.responseDecodable(of: AllLeagues.self) { response in
      completion(response.value)
    }
  }
  
  func requestLeague(_ identifier: String, completion: @escaping ((AllTeams?) -> Void)) {
    cancelableRequest?.cancel()
    cancelableRequest = request(.leagueTeams(identifier: identifier))
    
    cancelableRequest?.responseDecodable(of: AllTeams.self) { response in
      completion(response.value)
    }
  }
  
  func requestTeamDetails(_ identifier: String, completion: @escaping ((AllTeamDetails?) -> Void)) {
    cancelableRequest?.cancel()
    cancelableRequest = request(.team(identifier: identifier))
    
    cancelableRequest?.responseDecodable(of: AllTeamDetails.self) { response in
      completion(response.value)
    }
  }
  
  private func request(_ type: RequetType) -> DataRequest? {
    guard let baseUrl = baseUrl else {
      return nil
    }
    
    var requestUrl = "\(baseUrl)/"
    switch type {
    case .allLeagues:
      requestUrl.append(contentsOf: "all_leagues.php")
    case .leagueTeams(let identifier):
      requestUrl.append(contentsOf: "lookup_all_teams.php?id=\(identifier)")
    case .team(let identifier):
      requestUrl.append(contentsOf: "lookupteam.php?id=\(identifier)")
    }
    
    return AF.request(requestUrl)
  }
}
