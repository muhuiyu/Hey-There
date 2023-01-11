//
//  ChatroomViewController.swift
//  Ohana
//
//  Created by Mu Yu on 11/6/22.
//

import UIKit
import RxSwift

class ChatroomViewController: BaseMVVMViewController<ChatroomViewModel> {
    
    // MARK: - View
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private var datePickerSection = [UITableViewCell]()
    private var categorySection = [UITableViewCell]()
    private var searchResultCells = [UITableViewCell]()

    private let inputBarView = ChatroomInputBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignals()
        configureViewModel()
        configureViews()
        configureConstraints()
        configureGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await viewModel.getChatAndMessages()
        }
    }
}
// MARK: - Handlers
extension ChatroomViewController {
    @objc
    func didPullToRefresh() {
        refreshControl.beginRefreshing()
        Task {
            await viewModel.getChatAndMessages()
            self.refreshControl.endRefreshing()
        }
    }
    @objc
    private func didTapPhone() {
        guard
            let coordinator = coordinator as? ChatCoordinator,
            let chat = viewModel.chat.value
        else { return }
        coordinator.showCall(for: chat)
    }
}

// MARK: - View Config
extension ChatroomViewController {
    private func configureViews() {
        setupNavigationBar()
        setupTableView()
        setupInputBarView()
    }
    private func configureConstraints() {
        tableView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        inputBarView.snp.remakeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
    private func configureGestures() {
            
    }
}
// MARK: - Coordinator and Signal Config
extension ChatroomViewController {
    private func configureSignals() {
        viewModel.chatroomNameString
            .asObservable()
            .subscribe { value in
                DispatchQueue.main.async {
                    self.navigationItem.title = value
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.messages
            .asObservable()
            .subscribe { _ in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.scrollToBottomRow()
                }
            }
            .disposed(by: disposeBag)
    }
    private func configureViewModel() {
        viewModel.setup(appCoordinator: self.appCoordinator)
    }
}
// MARK: - Setup Views
extension ChatroomViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem.makePhoneButton(target: self,
                                                                            action: #selector(didTapPhone))
    }
    private func setupTableView() {
        tableView.register(MessageTextCell.self, forCellReuseIdentifier: MessageTextCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        view.addSubview(tableView)
    }
    private func setupInputBarView() {
        inputBarView.delegate = self
        view.addSubview(inputBarView)
    }
}
// MARK: - Data Source
extension ChatroomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let message = viewModel.getMessage(at: indexPath) else {
            return UITableViewCell()
        }
        switch message.content {
        case .text(let content):
            guard let currentUserID = viewModel.currentUserID else { return UITableViewCell() }
            let cell = MessageTextCell(messageID: message.id,
                                       with: content,
                                       isSentByMe: message.isSentByMe(currentUserID: currentUserID))
            cell.delegate = self
            return cell
        case .image(let content):
            // TODO: -
            return UITableViewCell()
        case .sticker(let content):
            // TODO: -
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
// MARK: - Delegate from UITableView and MessageCell
extension ChatroomViewController: UITableViewDelegate, MessageCellDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // not allow to select in default mode, allow to select when it's editing
        return nil
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        print(indexPath)
        // TODO: -
    }
    private func presentMessageFullActionList(for message: Message) {
        // TODO: -
        print(message.type)
    }
    private func presentMessageReactionList(for messageID: MessageID) {
        // TODO: -
        print(messageID)
        // find indexPath
        // present popover
        // after selecting the reaction, reload tableView cell
    }
    func MessageCellDidTapInView(_ cell: UITableViewCell, messageID: MessageID) {
        presentMessageReactionList(for: messageID)
    }
    func MessageCellDidLongPressInView(_ cell: UITableViewCell, messageID: MessageID) {
        // TODO: -
        if let message = viewModel.getMessage(for: messageID) {
            presentMessageFullActionList(for: message)
        }
    }
}
// MARK: - Delegate from InputBarView
extension ChatroomViewController: ChatroomInputBarViewDelegate {
    func chatroomInputBarView(_ view: ChatroomInputBarView, didSend text: String) {
        // TODO: -
    }
    func chatroomInputBarViewDidTapMoreButton(_ view: ChatroomInputBarView) {
        // TODO: -
    }
    func chatroomInputBarViewDidTapAudioButton(_ view: ChatroomInputBarView) {
        // TODO: - 
    }
}
