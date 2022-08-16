//
//  LeagueSearchResultTableViewCell.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 16/08/2022.
//

import Foundation
import UIKit

class LeagueSearchResultTableViewCell: UITableViewCell {
  
  func configure(with title: String) {
    var content = defaultContentConfiguration()
    content.text = title
    contentConfiguration = content
    
    accessibilityIdentifier = AccessibilityIdentifier.leagueTableViewCell.rawValue
  }
  
}
