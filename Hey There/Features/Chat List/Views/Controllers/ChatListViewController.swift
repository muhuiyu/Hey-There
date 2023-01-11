//
//  ChatListViewController.swift
//  Ohana
//
//  Created by Mu Yu on 11/6/22.
//

import UIKit
import RxSwift
import RxDataSources

class ChatListViewController: BaseMVVMViewController<ChatListViewModel> {
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureViews()
        configureConstraints()
    }
    
    // Need to set `hidesBottomBarWhenPushed` to ViewControllers in MainTabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        hidesBottomBarWhenPushed = true
//        tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        hidesBottomBarWhenPushed = false
    }
    
    
    // testing
//    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ChatListSectionModel>(configureCell: configureCell)
    
}

// MARK: - View Config
extension ChatListViewController {
    private func configureViewModel() {
        viewModel.setup(appCoordinator: self.appCoordinator)
        
//        viewModel.items
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)

//        viewModel.updateItems()
    }
    
    private func configureViews() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Data
extension ChatListViewController {
//    private var configureCell: RxTableViewSectionedReloadDataSource<ChatListSectionModel>.ConfigureCell {
//        return { [weak self] (dataSource, tableView, indexPath, _) in
//            guard let self = self else { return }
//            let item = dataSource[indexPath]
//
//            switch item {
//            case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility:
//                let cell = UITableViewCell()
//                cell.textLabel?.text = item.title
//                cell.accessoryType = item.accessoryType
//                return cell
//            case .description(let text):
//                let cell = UITableViewCell()
//                cell.textLabel?.text = text
//                cell.isUserInteractionEnabled = false
//                return cell
//            }
//        }
//    }
}


// MARK: - Delegate
extension ChatListViewController: UITableViewDelegate {
    private func presentDeleteChatConfirmationAlert(for chat: Chat) {
        guard let coordinator = coordinator else { return }
        let option = BaseCoordinator.AlertControllerOption(title: "Delete Chat?",
                                                           message: nil,
                                                           preferredStyle: .actionSheet)

        let actions: [BaseCoordinator.AlertActionOption] = [
            BaseCoordinator.AlertActionOption(title: "Cancel", style: .cancel, handler: nil),
            BaseCoordinator.AlertActionOption(title: "Delete", style: .default, handler: { _ in
                self.viewModel.deleteChat(for: chat)
            }),
        ]
        coordinator.presentAlert(option: option, actions: actions)
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let item = dataSource[indexPath]
//        return item.rowHeight
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        let section = dataSource[section]
//        return section.model.headerHeight
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        let section = dataSource[section]
//        return section.model.footerHeight
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .clear
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView()
//        footerView.backgroundColor = .clear
//        return footerView
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        defer {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//        guard
//            let coordinator = coordinator as? ChatCoordinator,
//            let chat = viewModel.getChat(at: indexPath)
//        else { return }
//
//        coordinator.showChatroom(for: chat)
//    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard let chat = viewModel.getChat(at: indexPath) else { return nil }
//
//        let action = UIContextualAction(style: .destructive, title: "Delete") { (_, _, nil) in
//            tableView.setEditing(false, animated: true)
//            self.presentDeleteChatConfirmationAlert(for: chat)
//        }
//        action.backgroundColor = .red
//        return UISwipeActionsConfiguration(actions: [action])
//    }
}

// MARK: - Setup Views
extension ChatListViewController {
    private func setupNavigationBar() {
        navigationItem.title = viewModel.titleString
    }
    private func setupTableView() {
        tableView.register(ChatPreviewCell.self, forCellReuseIdentifier: ChatPreviewCell.reuseID)
        view.addSubview(tableView)
        
//        tableView.contentInset.bottom = 12.0
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)
//        tableView.rx.itemSelected
//            .subscribe(onNext: { [weak self] indexPath in
////                guard let item = self?.dataSource[indexPath] else { return }
//
//                guard
//                    let coordinator = self?.coordinator as? ChatCoordinator,
//                    let chat = self?.viewModel.getChat(at: indexPath)
//                else { return }
//
//                self?.tableView.deselectRow(at: indexPath, animated: true)
//                coordinator.showChatroom(for: chat)
////                switch item {
////                    case .account:
////                    // 遷移させる処理
////                    break
////                case .security:
////                    break
////                case .notification:
////                    break
////                case .contents:
////                    break
////                case .sounds:
////                    break
////                case .dataUsing:
////                    break
////                case .accessibility:
////                    break
////                case .description:
////                    break
////                }
//            })
//            .disposed(by: disposeBag)
    }
}
