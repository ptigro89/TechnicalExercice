//
//  TechnicalExerciceTests.swift
//  TechnicalExerciceTests
//
//  Created by Lambert Florent on 15/08/2022.
//

import XCTest
@testable import TechnicalExercice

class TechnicalExerciceTests: XCTestCase {
  
  let searchLeaguePresenter = SearchLeaguePresenter()
  var teamDetailsPresenter: TeamDetailsPresenter?
  
  override func setUpWithError() throws {
    searchLeaguePresenter.searchLeagueViewDelegate = self
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() throws {
    var league = League()
    league.id = TestDefaultValue.League.ligue1.identifier
    league.name = TestDefaultValue.League.ligue1.name
    
    searchLeaguePresenter.select(league)
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}

extension TechnicalExerciceTests: SearchLeagueViewDelegate {
  
  func updateLeague(_ title: String?, leagueDatas: [SearchLeagueViewData]) {
    XCTAssertTrue(title == TestDefaultValue.League.ligue1.name)
    XCTAssertTrue(leagueDatas.count == TestDefaultValue.League.ligue1.teamCount)
    XCTAssertNotNil(leagueDatas.first?.teamBadgeUrl)
    
    searchLeaguePresenter.selectTeam(at: 0)
  }
  
  func selectTeam(with presenter: TeamDetailsPresenter) {
    teamDetailsPresenter = presenter
    teamDetailsPresenter?.teamDetailsViewDelegate = self
    
    teamDetailsPresenter?.configureView()
  }
  
}

extension TechnicalExerciceTests: TeamDetailsViewDelegate {
  
  func updateDetails(name: String?, bannerUrl: URL?, country: String?, league: String?, description: String?) {
    XCTAssertTrue(name == TestDefaultValue.Team.ajaccio.name)
    XCTAssertNotNil(bannerUrl)
    XCTAssertTrue(country == TestDefaultValue.Team.ajaccio.country)
    XCTAssertTrue(league == TestDefaultValue.Team.ajaccio.league)
    XCTAssertNotNil(description)
  }
  
}
