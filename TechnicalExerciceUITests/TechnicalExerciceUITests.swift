//
//  TechnicalExerciceUITests.swift
//  TechnicalExerciceUITests
//
//  Created by Lambert Florent on 15/08/2022.
//

import XCTest

class TechnicalExerciceUITests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()
    
    testSearchLeague(app: app)
    
    testTeam(type: .ajaccio, app: app)
    
    sleep(1)
    
    if !teamIsVisible(type: .clermont, app: app) {
      app.swipeUp()
    }
    
    testTeam(type: .clermont, app: app)
  }
  
  func testSearchLeague(app: XCUIApplication) {
    let searchBar = app.searchFields[AccessibilityIdentifier.leaguesSearchBar.rawValue]
    
    searchBar.tap()
    searchBar.typeText("ligue 1")
    
    sleep(3)
    
    XCTAssertTrue(app.tables.cells.count > 0)
    
    let ligue1LeagueCell = app.tables.cells[AccessibilityIdentifier.leagueTableViewCell.rawValue].firstMatch
    XCTAssertTrue(ligue1LeagueCell.exists)
    
    let ligue1TitleLabel = ligue1LeagueCell.staticTexts.matching(identifier: TestDefaultValue.League.ligue1.name).firstMatch
    XCTAssertTrue(ligue1TitleLabel.exists)
    
    ligue1LeagueCell.tap()
    
    sleep(1)
    
    XCTAssertTrue(app.collectionViews.cells.count > 0)
  }
  
  func testTeam(type: TestDefaultValue.Team, app: XCUIApplication) {
    let teamCell = app.collectionViews.cells["\(AccessibilityIdentifier.teamCollectionViewCell.rawValue)_\(type.identifier)"].firstMatch
    XCTAssertTrue(teamCell.exists)
    
    let teamCellBadge = teamCell.images[AccessibilityIdentifier.teamCollectionViewCellBadge.rawValue].firstMatch
    XCTAssertTrue(teamCellBadge.exists)
    
    teamCell.tap()
    
    sleep(3)
    
    testTeamDetails(type: type, app: app)
    
    app.navigationBars.buttons.element(boundBy: 0).tap()
  }
  
  func teamIsVisible(type: TestDefaultValue.Team, app: XCUIApplication) -> Bool {
    return app.collectionViews.cells["\(AccessibilityIdentifier.teamCollectionViewCell.rawValue)_\(type.identifier)"].firstMatch.exists
  }
  
  func testTeamDetails(type: TestDefaultValue.Team, app: XCUIApplication) {
    let navigationTitleElement = app.navigationBars.matching(identifier: type.name).firstMatch
    XCTAssertTrue(navigationTitleElement.exists)
    
    let teamBannerImage = app.images[AccessibilityIdentifier.teamDetailsBanner.rawValue].firstMatch
    XCTAssertTrue(teamBannerImage.exists == type.hasBanner)
    
    let teamCountryLabel = app.staticTexts[AccessibilityIdentifier.teamDetailsCountry.rawValue].firstMatch
    XCTAssertTrue(teamCountryLabel.exists)
    XCTAssertTrue(teamCountryLabel.label == type.country)
    
    let teamLeagueLabel = app.staticTexts[AccessibilityIdentifier.teamDetailsLeague.rawValue].firstMatch
    XCTAssertTrue(teamLeagueLabel.exists)
    XCTAssertTrue(teamLeagueLabel.label == type.league)
    
    let teamDescriptionLabel = app.staticTexts[AccessibilityIdentifier.teamDetailsDescription.rawValue].firstMatch
    XCTAssertTrue(teamDescriptionLabel.exists)
  }
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
