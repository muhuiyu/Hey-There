//
//  HomeCoordinator.swift
//  Ohana
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    enum Destination {
        case viewNotifications
        case addMeal(Date)
        case editMeal(Date, Int)
//        case addFoodLog(Date, Int)
//        case viewFoodLog(FoodLog, Date, Int, Int)
        case addJournal
//        case viewTransactionList
//        case viewTransactionDetail(TransactionID)
//        case selectFromOptionList(Transaction.EditableField, TransactionViewModel)
//        case addTransaction(Transaction?)
//        case viewMonthlyAnalysis
//        case viewMonthlyAnalysisCategoryDetail(TransactionList)
//        case viewPocket
//        case viewRecurringTransactionDetail(RecurringTransactionID)
    }
}

// MARK: - ViewController List
extension HomeCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        switch destination {
        case .viewNotifications:
            // TODO: -
            return BaseViewController()
        case .addMeal(let date):
            // TODO: -
            let viewController = BaseViewController()
            return viewController
        case .editMeal(let date, let mealIndex):
            // TODO: -
            let viewController = BaseViewController()
            return viewController
//        case .addFoodLog(let date, let mealIndex):
//            let viewController = AddFoodViewController(appCoordinator: self.parentCoordinator,
//                                                       homeCoordinator: self)
//            viewController.viewModel.date = date
//            viewController.viewModel.mealIndex = mealIndex
//            return viewController
//        case .viewFoodLog(let foodLog, let date, let mealIndex, let foodLogIndex):
//            let viewController = EditFoodLogViewController(appCoordinator: self.parentCoordinator,
//                                                           homeCoordinator: self)
//            viewController.viewModel.foodLog.accept(foodLog)
//            viewController.viewModel.date = date
//            viewController.viewModel.mealIndex = mealIndex
//            viewController.viewModel.foodLogIndex = foodLogIndex
//            return viewController
        case .addJournal:
            // TODO: -
            return BaseViewController()   
        }
//        case .viewTransactionList:
//            let viewController = TransactionListViewController(homeCoordinator: self)
//            return viewController
//        case .viewMonthlyAnalysis:
//            let viewController = AnalysisViewController(homeCoordinator: self)
//            viewController.viewModel.monthAndYear = MonthAndYear(date: Date.today)
//            return viewController
//        case .viewMonthlyAnalysisCategoryDetail(let transactions):
//            let viewController = AnalysisCategoryDetailViewController(homeCoordinator: self)
//            viewController.transacitons = transactions
//            return viewController
//        case .viewTransactionDetail(let transactionID):
//            let viewController = EditTransactionViewController(homeCoordinator: self, mode: .edit)
//            viewController.viewModel.transactionID.accept(transactionID)
//            return viewController
//        case .selectFromOptionList(let field, let transactionViewModel):
//            let viewController = TransactionFieldOptionListViewController(homeCoordinator: self, viewModel: transactionViewModel, field: field)
//            return viewController
//        case .addTransaction(let transaction):
//            let viewController = EditTransactionViewController(homeCoordinator: self, mode: .add)
//            if var transaction = transaction {
//                transaction.id = ""
//                viewController.viewModel.transaction.accept(transaction)
//            } else {
//                viewController.viewModel.transaction.accept(Transaction())
//            }
//            return viewController
//        case .viewPocket:
//            let viewController = PocketViewController(homeCoordinator: self)
//            return viewController
//        case .viewRecurringTransactionDetail:
//            // TODO: - Add details
//            return BaseViewController()
    }

}

// MARK: - Navigation
extension HomeCoordinator {
    func showNotifications() {
        guard let viewController = makeViewController(for: .viewNotifications) else { return }
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: false)
        self.navigate(to: viewController, presentModally: true, options: options)
    }
    func showAddMeal(on date: Date) {
        guard let viewController = makeViewController(for: .addMeal(date)) else { return }
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: false)
        self.navigate(to: viewController, presentModally: true, options: options)
    }
    func showEditMeal(on date: Date, forMeal mealIndex: Int) {
        guard let viewController = makeViewController(for: .editMeal(date, mealIndex)) else { return }
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: false)
        self.navigate(to: viewController, presentModally: true, options: options)
    }
//    func showAddFoodLog(on date: Date, forMeal mealIndex: Int) {
//        guard let viewController = makeViewController(for: .addFoodLog(date, mealIndex)) else { return }
//        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: false)
//        self.navigate(to: viewController, presentModally: true, options: options)
//    }
//    func showFoodLog(for foodLog: FoodLog, on date: Date, forMeal mealIndex: Int, ofFood foodLogIndex: Int) {
//        guard let viewController = makeViewController(for: .viewFoodLog(foodLog, date, mealIndex, foodLogIndex)) else { return }
//        self.navigate(to: viewController, presentModally: false)
//    }
    func showAddJournal() {
        guard let viewController = makeViewController(for: .addJournal) else { return }
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: false)
        self.navigate(to: viewController, presentModally: true, options: options)
    }
}
