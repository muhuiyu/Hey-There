//
//  AuthenticationViewModel.swift
//  Hey There
//
//  Created by Mu Yu on 1/11/23.
//

import Firebase
import GoogleSignIn
import RxRelay
import RxSwift

class AuthenticationViewModel: BaseViewModel {
    var state: BehaviorRelay<SignInState> = BehaviorRelay(value: .loading)
}
extension AuthenticationViewModel {
    func checkPreviousSignInSession() async {
        let hasGoogleSignIn = await hasPreviousGoogleSignInSession()
        let hasAppleSignIn = await hasPreviousAppleSignInSession()
        
        Observable
            .of(hasGoogleSignIn, hasAppleSignIn)
            .merge()
            .subscribe { hasSignIn in
                if hasSignIn {
                    //
                } else {
                    self.signOutFromApp()
                }
            }
            .disposed(by: disposeBag)
    }
    func signIn(with method: SignInMethod) {
        switch method {
        case .google:
            googleSignIn()
        case .apple:
            appleSignIn()
        }
    }
    func signOut() {
        guard let signInMethod = appCoordinator?.userManager.signInMethod else {
            state.accept(.signedOut)
            signOutFromApp()
            return
        }
        switch signInMethod {
        case .google:
            googleSignOut()
        case .apple:
            appleSignOut()
        }
    }
}
// MARK: - Google Sign in / Sign out
extension AuthenticationViewModel {
    private func googleSignIn() {
        do {
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                throw(FirebaseError.missingClientID)
            }
            guard let rootViewController = getRootViewController() else {
                throw(AppError.missingRootViewController)
            }
            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
            Task {
                let _ = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
                await signInApp()
                appCoordinator?.userManager.signInMethod = .google
            }
        } catch {
            ErrorHandler.shared.handle(error)
            signOutFromApp()
        }
    }
    private func hasPreviousGoogleSignInSession() async -> Observable<Bool> {
        do {
            guard GIDSignIn.sharedInstance.hasPreviousSignIn() else {
                return BehaviorSubject(value: false)
            }
            let user = try await GIDSignIn.sharedInstance.restorePreviousSignIn()
            try await authenticateUser(for: user)
            return BehaviorSubject(value: true)
        } catch {
            ErrorHandler.shared.handle(error)
            return BehaviorSubject(value: false)
        }
    }
    private func googleSignOut() {
        defer {
            signOutFromApp()
        }
        
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
        } catch {
            ErrorHandler.shared.handle(error)
        }
    }
}
// MARK: - Apple Sign In / out
extension AuthenticationViewModel {
    private func appleSignIn() {
        // TODO: -
        Task {
            await signInApp()
            appCoordinator?.userManager.signInMethod = .apple
        }
    }
    private func hasPreviousAppleSignInSession() async -> Observable<Bool> {
        // TODO: - add apple sign in check
        return BehaviorSubject(value: false)
    }
    private func appleSignOut() {
        // TODO: - 
    }
}
// MARK: - Helpers
extension AuthenticationViewModel {
    private func authenticateUser(for user: GIDGoogleUser?) async throws {
        guard let accessToken = user?.accessToken, let idToken = user?.idToken else {
            signOutFromApp()
            throw(FirebaseError.missingToken)
        }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                       accessToken: accessToken.tokenString)
        let _ = try await Auth.auth().signIn(with: credential)
        await signInApp()
    }
    private func signOutFromApp() {
        self.state.accept(.signedOut)
        appCoordinator?.userManager.clearData()
    }
    private func signInApp() async {
        // set up sign in info
        guard let appCoordinator = self.appCoordinator else {
            state.accept(.signedOut)
            return
        }
        appCoordinator.userManager.clearData()
        
        guard let user = Auth.auth().currentUser else {
            state.accept(.signedOut)
            return
        }
        
        appCoordinator.userManager.setData(from: user)
        await appCoordinator.setupDataProvider()
        state.accept(.signedIn)
    }
    private func getRootViewController() -> UIViewController? {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootViewController = windowScene.windows.first?.rootViewController
        else { return nil }
        return rootViewController
    }

}

