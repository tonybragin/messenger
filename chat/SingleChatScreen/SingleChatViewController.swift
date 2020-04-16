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
    var chatIndex: Int? { get set }
}

class SingleChatViewController: UIViewController, SingleChatViewControllerProtocol {
    
    // MARK: - Properties
    
    var presenter: SingleChatPresenterProtocol!
    var chatIndex: Int?
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
    
    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextView: MessageTextView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureTextView()
        presenter = SingleChatPresenter(viewController: self)
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.removeKeyboardObservers()
    }

    // MARK: - Configuration
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    private func configureTextView() {
        messageTextView.delegate = self
        messageTextView.showPlaceholder()
    }
    
    // MARK: - Utility
    
    private func scrollDown() {
        if !chatData.isEmpty {
            let indexPath = IndexPath(row: chatData.count - 1, section: 0)
            collectionView.scrollToItem(at: indexPath,
                                        at: .bottom,
                                        animated: true)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func sendMessageButtonTouched(_ sender: UIButton) {
        presenter.sendMessageButtonTouched(text: messageTextView.text)
        messageTextView.text = ""
    }
}

// MARK: - Working with UICollectionViewDelegateFlowLayout

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

// MARK: - Working with UICollectionViewDataSource

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

// MARK: - Working with UITextViewDelegate

extension SingleChatViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        messageTextView.hidePlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTextView.text.isEmpty {
            messageTextView.showPlaceholder()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let lineHeight = UIFont.messageTextViewTextFont.lineHeight
        let numLines = (textView.contentSize.height / lineHeight)
        var newHeight: CGFloat = 55
        switch numLines {
        case 0..<2:
            break
        case 2..<3:
            newHeight += lineHeight
        case 3..<4:
            newHeight += lineHeight * 2
        default:
            newHeight += lineHeight * 3
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.messageViewHeightConstraint.constant = newHeight
            self?.view.layoutIfNeeded()
        }
    }
}

// MARK: - Working with KeyboardAppearingDelegate

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
