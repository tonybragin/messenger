//
//  SingleChatViewController.swift
//  chat
//
//  Created by Tony on 13/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol SingleChatViewControllerProtocol: UIViewController, KeyboardAppearingDelegate {
    var presenter: SingleChatPresenterProtocol! { get set }
    var chatData: [ChatDataItem] { get set }
}

class SingleChatViewController: UIViewController, SingleChatViewControllerProtocol {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mesageTextView: MessageTextView!
    
    var presenter: SingleChatPresenterProtocol!
    var chatData: [ChatDataItem] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.collectionView.performBatchUpdates(nil, completion: { [weak self] _ in
                    self?.scrollDown()
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        presenter = SingleChatPresenter(viewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.addKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.removeKeyboardObservers()
    }

    @IBAction func sendMessageButtonTouched(_ sender: UIButton) {
        presenter.sendMessageButtonTouched(text: mesageTextView.text)
    }
    
    private func scrollDown() {
        if !chatData.isEmpty {
            let indexPath = IndexPath(row: chatData.count - 1, section: 0)
            collectionView.scrollToItem(at: indexPath,
                                        at: .bottom,
                                        animated: true)
        }
    }
}

extension SingleChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceHeight: CGFloat = 60
        let referenceWidth = collectionView.frame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right

        return CGSize(width: referenceWidth, height: referenceHeight)
    }
}

extension SingleChatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return chatData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MessageCollectionViewCell!
        if chatData[indexPath.row].isOutcoming {
            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "OutcomingCollectionViewCell",
                                                       for: indexPath) as! MessageCollectionViewCell)
        } else {
            cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "IncomingCollectionViewCell",
                                                       for: indexPath) as! MessageCollectionViewCell)
        }
        cell.configure(with: chatData[indexPath.row])
        return cell
    }
    
    
}

extension SingleChatViewController: UICollectionViewDelegate {
    
}

extension SingleChatViewController: KeyboardAppearingDelegate {
    
    func keyboardWillShow(with rect: CGRect, duration: TimeInterval) {
        var bottomOffset: CGFloat = 0
        if #available(iOS 11.0, *) {
            bottomOffset = view.safeAreaInsets.bottom
        }
        UIView.animate(withDuration: duration) { [weak self] in
            self?.messageViewBottomConstraint.constant = rect.height - bottomOffset
            self?.view.layoutIfNeeded()
            self?.scrollDown()
        }
    }
    
    func keyboardWillHide(with rect: CGRect, duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.messageViewBottomConstraint.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    
}
