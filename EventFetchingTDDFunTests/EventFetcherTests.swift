//
//  EventFetcherTests.swift
//  EventFetchingTDDFunTests
//
//  Created by Tom Phillips on 11/6/23.
//

import XCTest
import EventKit

class EventFetcher {
    func fetchDates(between startDate: Date, and endDate: Date) -> [EKEvent] {
        []
    }
}

final class EventFetcherTests: XCTestCase {

    func test_fetchEvents_returnsEmptyIfNoDatesScheduledInGivenRange() {
        let sut = EventFetcher()
        let startDate = Calendar.autoupdatingCurrent.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
        let endDate = Calendar.autoupdatingCurrent.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        
        let scheduledEvents = sut.fetchDates(between: startDate, and: endDate)
        XCTAssertEqual(scheduledEvents, [EKEvent]())
    }
}
