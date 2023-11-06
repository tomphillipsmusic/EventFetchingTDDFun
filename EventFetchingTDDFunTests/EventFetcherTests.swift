//
//  EventFetcherTests.swift
//  EventFetchingTDDFunTests
//
//  Created by Tom Phillips on 11/6/23.
//

import XCTest
import EventKit

class EventFetcher {
    func fetchDates(between startDate: Date, and endDate: Date) -> [Event] {
        []
    }
}

struct Event: Equatable {
    
}

final class EventFetcherTests: XCTestCase {

    func test_fetchEvents_returnsEmptyIfNoDatesScheduledInGivenRange() {
        let sut = EventFetcher()
        let startDate = Calendar.autoupdatingCurrent.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
        let endDate = Calendar.autoupdatingCurrent.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        
        let scheduledEvents = sut.fetchDates(between: startDate, and: endDate)
        XCTAssertEqual(scheduledEvents, [Event]())
    }
    
//    func test_fetchEvents_returnsAllScheduledEventsInTheGivenDateRange() {
//        let sut = EventFetcher()
//        let startDate = Calendar.autoupdatingCurrent.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
//        let endDate = Calendar.autoupdatingCurrent.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
//        
//        let allScheduledEvents: [EKEvent] = EKEv
//        
//        let scheduledEvents = sut.fetchDates(between: startDate, and: endDate)
//        XCTAssertEqual(scheduledEvents, [EKEvent]())
//    }
}
