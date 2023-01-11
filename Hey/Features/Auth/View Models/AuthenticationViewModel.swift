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
    
    enum SignInState {
        case loading
        case signedIn
        case signedOut
    }
}
extension AuthenticationViewModel {
    func checkPreviousSignInSession() async {
        let hasGoogleSignIn = await hasPreviousGoogleSignInSession()
        if !hasGoogleSignIn {
            signOutFromApp()
        }
        // TODO: - add apple sign in check
    }
}
// MARK: - Google Sign in / Sign out
extension AuthenticationViewModel {
    private func hasPreviousGoogleSignInSession() async -> Bool {
        do {
            if !GIDSignIn.sharedInstance.hasPreviousSignIn() { return false }
            let user = try await GIDSignIn.sharedInstance.restorePreviousSignIn()
            try await authenticateUser(for: user)
            return true
        } catch {
            ErrorHandler.shared.handle(error)
            return false
        }
    }
    func googleSignIn() {
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
            }
        } catch {
            ErrorHandler.shared.handle(error)
            signOutFromApp()
        }
    }
    func googleSignOut() {
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
    func appleSignIn() {
        // TODO: -
    }
    func appleSignOut() {
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
        self.appCoordinator?.userManager.clearData()
    }
    private func signInApp() async {
        self.state.accept(.signedIn)
        
        // set up sign in info
        guard let appCoordinator = self.appCoordinator else { return }
        appCoordinator.userManager.clearData()
        if let user = Auth.auth().currentUser {
            appCoordinator.userManager.setData(from: user)
            await appCoordinator.dataProvider.updateUserData()
            await appCoordinator.dataProvider.setup(userID: user.uid)
        }
    }
    private func getRootViewController() -> UIViewController? {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootViewController = windowScene.windows.first?.rootViewController
        else { return nil }
        return rootViewController
    }

}

