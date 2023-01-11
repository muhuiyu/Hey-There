//
//  CacheManager.swift
//  Ohana
//
//  Created by Mu Yu on 6/25/22.
//

import Foundation

class CacheManager {
    var appCoordinator: AppCoordinator?
    private var dataProvider = FirebaseDataProvider()
    
    // MARK: - Cached data
//    private var cachedSessions: [SessionID: Session] = [:]
//    private var cachedSessionsGroupedByDate: [YearMonthDay: Set<SessionID>] = [:]
//    private var cachedBookedSessions: Set<SessionID> = []
    
    // MARK: - Variables
    private let defaults = UserDefaults.standard
    private let preferredLanguageKey = "preferredLanguage"
    private let preferredTimeFormatKey = "preferredTimeFormat"
    
    init() {
        
    }
    
    enum CacheManagerError: Error {
        case updateAPIClientFailure
    }
}
// MARK: - Interfaces
extension CacheManager {
//    func updateData(at noteID: NoteID, _ content: String) async throws {
//        try await dataProvider.updateData(at: noteID, content)
//    }
//    func getData(at noteID: NoteID) async throws -> Note? {
//        try await dataProvider.getData(at: noteID)
//    }
    
    
    
//    func getUpcomingBookedSessions(defaultFacility: SessionFacility) async -> [Session] {
//        // TODO: - Fetch from all facility to check
//        let today = YearMonthDay.today()
//        if hasData(on: today, at: defaultFacility) {
//            return upcomingSessions
//        } else {
//            await fetchSessions(on: today, at: defaultFacility)
//            return upcomingSessions
//        }
//    }
//    func getSessions(on yearMonthDay: YearMonthDay,
//                     at facility: SessionFacility) async -> [Session] {
//        if hasData(on: yearMonthDay, at: facility) {
//            return getSortedSessions(on: yearMonthDay, at: facility)
//        } else {
//            await fetchSessions(on: yearMonthDay, at: facility)
//            return getSortedSessions(on: yearMonthDay, at: facility)
//        }
//    }
//    func getNotes() async throws -> [Note] {
//        return []
//    }
//    func updateAPIClient(with token: String) {
//        dataProvider = EvolveDataProvider(token: token)
//    }
//    func restorePreviousSignIn(with token: String) async throws -> Membership {
    func restorePreviousSignIn(with token: String) async throws {
//        return try await dataProvider.restorePreviousSignIn(with: token)
    }
//    func signIn(email: String, password: String) async throws -> (token: String, membership: Membership){
    func signIn(email: String, password: String) async throws{
        return try await dataProvider.signIn(email: email, password: password)
    }
//    func bookSession(_ memberID: Membership.ID,
//                     _ sessionID: SessionID,
//                     _ sessionRawID: String,
//                     on yearMonthDay: YearMonthDay) async throws {
//        try await dataProvider.bookSession(memberID, sessionRawID, on: yearMonthDay)
//        cachedSessions[sessionID]?.isBookedByMe = true
//    }
//    func cancelSession(_ memberID: Membership.ID,
//                       _ sessionID: SessionID,
//                       _ sessionRawID: String,
//                       on yearMonthDay: YearMonthDay) async throws {
//        try await dataProvider.cancelSession(memberID, sessionRawID, on: yearMonthDay)
//        cachedSessions[sessionID]?.isBookedByMe = false
//    }
}
// MARK: - Internal
extension CacheManager {
//    private func hasData(on yearMonthDay: YearMonthDay, at facility: SessionFacility) -> Bool {
//        guard
//            let sessions = cachedSessionsGroupedByDate[yearMonthDay],
//            let _ = sessions.firstIndex(where: { cachedSessions[$0]?.facility == facility })
//        else {
//            return false
//        }
//        return true
//    }
//    private func getSortedSessions(on yearMonthDay: YearMonthDay, at facility: SessionFacility) -> [Session] {
//        return cachedSessionsGroupedByDate[yearMonthDay, default: Set<SessionID>()]
//            .compactMap({ cachedSessions[$0] })
//            .filter({ $0.facility == facility })
//            .sorted(by: { $0.startTime < $1.startTime })
//    }
//    private var upcomingSessions: [Session] {
//        return cachedBookedSessions
//            .compactMap { cachedSessions[$0] }
//            .filter { $0.startTime >= Date() }   // start time is later than current time
//            .sorted(by: { $0.startTime < $1.startTime })
//    }
//    private func fetchSessions(on yearMonthDay: YearMonthDay,
//                               at facility: SessionFacility) async {
//        guard
//            let appCoordinator = appCoordinator,
//            let memberID = appCoordinator.userManager.memberID
//        else { return }
//
//        do {
//            let result = try await dataProvider.fetchSessions(memberID, on: yearMonthDay, at: facility)
//            updateCachedSessions(result.sessions)
//        } catch {
//            ErrorHandler.shared.handle(error)
//        }
//    }
//    private func updateCachedSessions(_ sessions: [Session]) {
//        for session in sessions {
//            cachedSessions[session.id] = session
//            cachedSessionsGroupedByDate[session.date, default: Set<SessionID>()].insert(session.id)
//
//            if session.isBookedByMe {
//                cachedBookedSessions.insert(session.id)
//            }
//        }
//    }
}


extension CacheManager {
    var preferredLanguage: Language {
        get {
            if let value = defaults.string(forKey: preferredLanguageKey) {
                return Language(rawValue: value) ?? .en
            }
            return .en
        }
        set {
            defaults.set(newValue.rawValue, forKey: preferredLanguageKey)
        }
    }
//    var preferredCurrencyCode: CurrencyCode {
//        return Currency.Code.sgd.rawValueUppercased
//    }
    var preferredTimeZone: TimeZone {
//        return TimeZone(abbreviation: "SGT") ?? TimeZone.current
        return .current
    }
    var preferredCalendar: Calendar {
        return .current
    }
    var preferredLocale: Locale {
        return .current
//        return Locale(identifier: "ja_JP")
//        return Locale(identifier: "en_US")
    }
    var preferredTimeFormat: TimeFormat {
        return .civilian
    }
}

extension CacheManager {
    // TODO: - Reconnect to FirePrice
    var userID: String {
        return "1dUSs99CSRXqsTEiSzJ9VWpBc7p2"
    }
    var mainAccountID: String {
        return "wMHO0Dkyr0BJiVP8Mb6C"
    }
}
