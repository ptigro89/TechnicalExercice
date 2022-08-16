//
//  TestDefaultValue.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 16/08/2022.
//

import Foundation

struct TestDefaultValue {
  
  enum League {
    case ligue1
    
    var name: String {
      switch self {
      case .ligue1: return "Ligue 1 Uber Eats"
      }
    }
    
    var identifier: String {
      switch self {
      case .ligue1: return "4334"
      }
    }
    
    var teamCount: Int {
      switch self {
      case .ligue1: return 20
      }
    }
  }
  
  enum Team {
    case ajaccio, clermont
    
    var name: String {
      switch self {
      case .ajaccio: return "Ajaccio"
      case .clermont: return "Clermont Foot"
      }
    }
    
    var identifier: String {
      switch self {
      case .ajaccio: return "133702"
      case .clermont: return "134713"
      }
    }
    
    var league: String {
      switch self {
      case .ajaccio, .clermont: return "French Ligue 1"
      }
    }
    
    var country: String {
      switch self {
      case .ajaccio, .clermont: return "France"
      }
    }
    
    var hasBanner: Bool {
      switch self {
      case .clermont: return false
      default: return true
      }
    }
  }
}
