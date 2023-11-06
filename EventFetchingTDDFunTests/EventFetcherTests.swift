//
//  EventFetcherTests.swift
//  EventFetchingTDDFunTests
//
//  Created by Tom Phillips on 11/6/23.
//

import XCTest
import EventKit

protocol EventStore {
    func events(between startDate: Date, and endDate: Date) -> [Event]
}

struct MockEventStore: EventStore {
    let scheduledEvents: [Event]
    
    func events(between startDate: Date, and endDate: Date) -> [Event] {
        scheduledEvents
    }
}

class EventService {
    let store: EventStore
    
    init(store: EventStore) {
        self.store = store
    }
    
    func fetchDates(between startDate: Date, and endDate: Date) -> [Event] {
        return store.events(between: startDate, and: endDate)
    }
}

struct Event: Equatable {
    let startDate: Date
    let endDate: Date
}

final class EventFetcherTests: XCTestCase {

    func test_fetchEvents_returnsEmptyIfNoDatesScheduledInGivenRange() {
        let store = MockEventStore(scheduledEvents: [])
        let sut = EventService(store: store)
        let startDate = Calendar.autoupdatingCurrent.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
        let endDate = Calendar.autoupdatingCurrent.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        
        let scheduledEvents = sut.fetchDates(between: startDate, and: endDate)
        XCTAssertEqual(scheduledEvents, [Event]())
    }
    
    func test_fetchEvents_returnsAllScheduledEventsInTheGivenDateRange() {
        let firstEvent = Event(
            startDate: Calendar.autoupdatingCurrent.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!,
            endDate: Calendar.autoupdatingCurrent.date(bySettingHour: 8, minute: 30, second: 0, of: Date())!)
        
        let secondEvent = Event(
            startDate: Calendar.autoupdatingCurrent.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!,
            endDate: Calendar.autoupdatingCurrent.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!)
        
        
        let allScheduledEvents: [Event] = [firstEvent, secondEvent]
        let store = MockEventStore(scheduledEvents: allScheduledEvents)
        let sut = EventService(store: store)
        let startDate = Calendar.autoupdatingCurrent.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
        let endDate = Calendar.autoupdatingCurrent.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        
        let scheduledEvents = sut.fetchDates(between: startDate, and: endDate)
        XCTAssertEqual(scheduledEvents, allScheduledEvents)
    }
}
