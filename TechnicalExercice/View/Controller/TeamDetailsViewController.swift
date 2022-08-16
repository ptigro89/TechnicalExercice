//
//  TeamDetailsViewController.swift
//  TechnicalExercice
//
//  Created by Lambert Florent on 15/08/2022.
//

import Foundation
import UIKit
import AlamofireImage

class TeamDetailsViewController: UIViewController {
  
  private static let storyboardIdentifier = "DetailsTeam"
  
  private var presenter: TeamDetailsPresenter?
  
  @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var bannerImageView: UIImageView!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var leagueLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBOutlet weak var bannerImageViewHeightConstraint: NSLayoutConstraint!
  
  static func create(with presenter: TeamDetailsPresenter) -> TeamDetailsViewController {
    let teamDetailsViewController = TeamDetailsViewController(nibName: String(describing: TeamDetailsViewController.self), bundle: nil)
    
    presenter.teamDetailsViewDelegate = teamDetailsViewController
    teamDetailsViewController.presenter = presenter
    
    return teamDetailsViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bannerImageView.accessibilityIdentifier = AccessibilityIdentifier.teamDetailsBanner.rawValue
    countryLabel.accessibilityIdentifier = AccessibilityIdentifier.teamDetailsCountry.rawValue
    leagueLabel.accessibilityIdentifier = AccessibilityIdentifier.teamDetailsLeague.rawValue
    descriptionLabel.accessibilityIdentifier = AccessibilityIdentifier.teamDetailsDescription.rawValue
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    presenter?.configureView()
  }
  
}

extension TeamDetailsViewController: TeamDetailsViewDelegate {
  
  func updateDetails(name: String?, bannerUrl: URL?, country: String?, league: String?, description: String?) {
    loadingActivityIndicator.stopAnimating()
    
    navigationItem.title = name
    
    if let country = country {
      countryLabel.text = country
    }
    if let league = league {
      leagueLabel.text = league
    }
    if let description = description {
      descriptionLabel.text = description
    }
    if let bannerUrl = bannerUrl {
      bannerImageView.af.setImage(withURL: bannerUrl)
      bannerImageViewHeightConstraint.constant = view.frame.width * 0.25
    } else {
      bannerImageViewHeightConstraint.constant = 0.0
    }
  }

}
