//
//  OhanaDataProvider.swift
//  Ohana
//
//  Created by Mu Yu on 10/14/22.
//

//import EvolveAPI
//
//class EvolveDataProvider {
//    init(token: String? = nil) {
//        if let token = token {
//            self.client = APIClient(requestConfigurator: TokenRequestConfigurator(token: token))
//        } else {
//            self.client = APIClient()
//        }
//    }
//
//    private let client: APIClient
//
//    enum EvolveDataProviderError: Error {
//        case invalidMembership
//    }
//}
//
//// MARK: - Interfaces
//extension EvolveDataProvider {
//    func restorePreviousSignIn(with token: String) async throws -> Membership {
//        let responseBody = try await client.request(API.GetMemberships(token: token))
//        guard let membership = responseBody.first else {
//            throw EvolveDataProviderError.invalidMembership
//        }
//        return membership
//    }
//
//    /// Performs request to login with given email and password
//    func signIn(email: String, password: String) async throws -> NotificationMethod {
//        let responseBody = try await client.request(API.SignInRequest(),
//                                                    with: API.SignInRequest.RequestBody(email: email,
//                                                                                        password: password))
//        return responseBody.mfaMethod
//    }
//
//    /// Verifies code and returns membership
//    func verifyCode(email: String, password: String, code: String) async throws -> (token: String, membership: Membership) {
//        let responseBody = try await client.request(API.VerifyCode(),
//                                                    with: API.VerifyCode.RequestBody(email: email,
//                                                                                        password: password,
//                                                                                        verificationCode: code))
//        guard let membership = responseBody.memberships.first else {
//            throw EvolveDataProviderError.invalidMembership
//        }
//        return (responseBody.token, membership)
//    }
//
//    /// Fetch sessions on the given date and facility
//    func fetchSessions(_ memberID: Membership.ID,
//                       on yearMonthDay: YearMonthDay,
//                       at facility: SessionFacility) async throws -> (sessions: [Session], timeToNextBookingFrame: TimeInterval) {
//
//        var sessions = [Session]()
//        let timeToNextBookingFrame: TimeInterval
//
//        switch facility {
//        case .farEast:
//            let responseBodyWarrior = try await client.request(API.GetEvents(memberID: memberID,
//                                                                             date: yearMonthDay,
//                                                                             area: SessionArea.farEastWarrior.key))
//            sessions += responseBodyWarrior.events.compactMap { Session(from: $0) }
//
//            let responseBodyChampion = try await client.request(API.GetEvents(memberID: memberID,
//                                                                              date: yearMonthDay,
//                                                                              area: SessionArea.farEastChampion.key))
//            sessions += responseBodyChampion.events.compactMap { Session(from: $0) }
//            let responseBodyLegend = try await client.request(API.GetEvents(memberID: memberID,
//                                                                            date: yearMonthDay,
//                                                                            area: SessionArea.farEastLegend.key))
//            sessions += responseBodyLegend.events.compactMap { Session(from: $0) }
//            timeToNextBookingFrame = responseBodyLegend.timeToNextBookingFrame
//        case .clarkeQuay:
//            let responseBody = try await client.request(API.GetEvents(memberID: memberID,
//                                                                      date: yearMonthDay,
//                                                                      area: SessionArea.clarkeQuayMT.key))
//            sessions = responseBody.events.compactMap { Session(from: $0) }
//            timeToNextBookingFrame = responseBody.timeToNextBookingFrame
//        case .orchard:
//            let responseBody = try await client.request(API.GetEvents(memberID: memberID,
//                                                                      date: yearMonthDay,
//                                                                      area: SessionArea.orchardMT.key))
//            sessions = responseBody.events.compactMap { Session(from: $0) }
//            timeToNextBookingFrame = responseBody.timeToNextBookingFrame
//        case .kinex:
//            let responseBody = try await client.request(API.GetEvents(memberID: memberID,
//                                                                      date: yearMonthDay,
//                                                                      area: SessionArea.kinexMT.key))
//            sessions = responseBody.events.compactMap { Session(from: $0) }
//            timeToNextBookingFrame = responseBody.timeToNextBookingFrame
//        }
//        return (sessions, timeToNextBookingFrame)
//    }
//
//    /// Books session
//    func bookSession(_ memberID: Membership.ID,
//                     _ sessionID: SessionID,
//                     on yearMonthDay: YearMonthDay) async throws {
//        let _ = try await client.request(API.BookEvent(),
//                                         with: API.BookEvent.RequestBody(eventDate: yearMonthDay,
//                                                                         eventID: sessionID,
//                                                                         memberID: memberID))
//    }
//    /// Cancels sesssion
//    func cancelSession(_ memberID: Membership.ID,
//                       _ sessionID: SessionID,
//                       on yearMonthDay: YearMonthDay) async throws {
//        let _ = try await client.request(API.CancelEventBooking(),
//                                         with: API.CancelEventBooking.RequestBody(eventDate: yearMonthDay,
//                                                                                  eventID: sessionID,
//                                                                                  memberID: memberID))
//    }
//}
//
//extension EvolveDataProvider {
//    private static func toAPIDateObject(from date: Date) -> YearMonthDay {
//        return YearMonthDay(year: date.year, month: date.month, day: date.dayOfMonth)
//    }
//}
//
//private class TokenRequestConfigurator: APIRequestConfigurator {
//    private let token: String
//    private let baseConfigurator: APIRequestConfigurator
//
//    init(token: String, baseConfigurator: APIRequestConfigurator = APIBaseRequestConfigurator()) {
//        self.token = token
//        self.baseConfigurator = baseConfigurator
//    }
//
//    func configureRequest<Request>(_ request: Request, with body: Request.RequestBody, for session: URLSession) throws -> URLRequest where Request : APIRequest {
//        var urlRequest = try baseConfigurator.configureRequest(request, with: body, for: session)
//        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        return urlRequest
//    }
//}
