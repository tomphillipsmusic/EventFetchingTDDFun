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
        let startDate = makeDate(hour: 8, minute: 0)
        let endDate = makeDate(hour: 12, minute: 0)
        
        let scheduledEvents = sut.fetchDates(between: startDate, and: endDate)
        XCTAssertEqual(scheduledEvents, [Event]())
    }
    
    func test_fetchEvents_returnsAllScheduledEventsInTheGivenDateRange() {
        let allScheduledEvents = allScheduledEvents()
        let store = MockEventStore(scheduledEvents: allScheduledEvents)
        let sut = EventService(store: store)
    
        let startDate = makeDate(hour: 8, minute: 0)
        let endDate = makeDate(hour: 12, minute: 0)
        
        let scheduledEvents = sut.fetchDates(between: startDate, and: endDate)
        XCTAssertEqual(scheduledEvents, allScheduledEvents)
    }
    
    // MARK: Helper Methods
    private func makeEvent(startDate: (hour: Int, minute: Int), endDate: (hour: Int, minute: Int)) -> Event {
        Event(
            startDate: makeDate(hour: startDate.hour, minute: startDate.minute),
            endDate: makeDate(hour: endDate.hour, minute: endDate.minute)
        )
    }
    
    private func makeDate(hour: Int, minute: Int) -> Date {
        Calendar.autoupdatingCurrent.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
    }
    
    private func allScheduledEvents() -> [Event] {
        let firstEvent = makeEvent(startDate: (hour: 8, minute: 0), endDate: (hour: 8, minute: 30))
        
        let secondEvent = makeEvent(startDate: (hour: 9, minute: 0), endDate: (hour: 9, minute: 15))
        
        
        return [firstEvent, secondEvent]
    }
}
