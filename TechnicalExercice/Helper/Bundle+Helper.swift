//
//  Bundle+Helper.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation

extension Bundle {
  
  static var appConfig: NSDictionary? {
    if let plistPath = Bundle.main.path(forResource: "Config", ofType: "plist") {
      return NSDictionary(contentsOfFile: plistPath)
    }
    
    return nil
  }

}
