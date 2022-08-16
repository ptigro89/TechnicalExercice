//
//  TeamCollectionViewCell.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation
import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  
  static var nib: UINib {
    return UINib(nibName: String(describing: TeamCollectionViewCell.self), bundle: nil)
  }
  
  func configure(with item: SearchLeagueViewData) {
    let placeholderImage = UIImage(named: "teamPlaceholder")
    
    if let teamBadgeurl = item.teamBadgeUrl {
      imageView.af.setImage(withURL: teamBadgeurl, placeholderImage: placeholderImage)
      imageView.contentMode = .scaleAspectFit
    } else {
      imageView.image = placeholderImage
      imageView.contentMode = .center
    }
    
    if let teamIdentifier = item.teamIdentifier {
      accessibilityIdentifier = "\(AccessibilityIdentifier.teamCollectionViewCell.rawValue)_\(teamIdentifier)"
      imageView.accessibilityIdentifier = AccessibilityIdentifier.teamCollectionViewCellBadge.rawValue
    }
  }
  
}
