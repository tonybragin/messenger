//
//  ChatsViewController.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol ChatsViewControllerProtocol: UIViewController {
    var presenter: ChatsPresenterProtocol! { get set }
    var chatsData: [ChatsDataItem] { get set }
}

protocol ChatsDataItem {
    var lastMessage: String { get }
    var lastMessageTime: String { get }
}

class ChatsViewController: UIViewController, ChatsViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ChatsPresenterProtocol!
    var chatsData: [ChatsDataItem] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter = ChatsPresenter(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func addButtonTouched(_ sender: UIBarButtonItem) {
        presenter.addButtonTouched()
    }
    
}

extension ChatsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if chatsData.isEmpty {
            tableView.backgroundView = EmptyTableView(frame: tableView.frame)
        } else {
            tableView.backgroundView = nil
        }
        return chatsData.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        cell.configure(with: chatsData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

extension ChatsViewController: UITableViewDelegate {
    // TODO: сделать картинкой и соразмерно с ечейкой
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            chatsData.remove(at: indexPath.row)
            presenter.deleteChat(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectChat(at: indexPath.row)
    }
}

extension ChatsViewController {
    struct ChatsDataItemStub: ChatsDataItem {
        var lastMessage: String
        var lastMessageTime: String
    }
}
