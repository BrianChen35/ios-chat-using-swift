//
//  ViewController.swift
//  CometChat
//
//  Created by Marin Benčević on 01/08/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import UIKit

final class ChatViewController: UIViewController {
  
  private enum Constants {
    static let incomingMessageCell = "incomingMessageCell"
    static let outgoingMessageCell = "outgoingMessageCell"
    static let contentInset: CGFloat = 24
    static let placeholderMessage = "Type something"
  }
  
  
  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var textAreaBackground: UIView!
  @IBOutlet weak var textAreaBottom: NSLayoutConstraint!
  @IBOutlet weak var emptyChatView: UIView!
  
  
  // MARK: - Actions
  
  @IBAction func onSendButtonTapped(_ sender: Any) {
    sendMessage()
  }
  
  
  // MARK: - Interaction
  
  private func sendMessage() {
    let message: String = textView.text
    guard !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
      return
    }
    
    textView.endEditing(true)
    addTextViewPlaceholer()
    scrollToLastCell()
    
    
  }
  
  var messages: [Message] = []
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "#General"
    
    emptyChatView.isHidden = false
    
    setUpTableView()
    setUpTextView()
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addTextViewPlaceholer()
    
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // Add default shadow to navigation bar
    let navigationBar = navigationController?.navigationBar
    navigationBar?.shadowImage = nil
  }
  
  
  // MARK: - Set up
  
  private func setUpTextView() {
    textView.isScrollEnabled = false
    textView.textContainer.heightTracksTextView = true
    textView.delegate = self
    
    textAreaBackground.layer.addShadow(
      color: UIColor(red: 189 / 255, green: 204 / 255, blue: 215 / 255, alpha: 54 / 100),
      offset: CGSize(width: 2, height: -2),
      radius: 4)
  }
  
  private func setUpTableView() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 80
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.contentInset = UIEdgeInsets(top: Constants.contentInset, left: 0, bottom: 0, right: 0)
    tableView.allowsSelection = false
  }
  
  private func scrollToLastCell() {
    let lastRow = tableView.numberOfRows(inSection: 0) - 1
    guard lastRow > 0 else {
      return
    }
    
    let lastIndexPath = IndexPath(row: lastRow, section: 0)
    tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
  }
}

// MARK: - UITextViewDelegate
extension ChatViewController: UITextViewDelegate {
  private func addTextViewPlaceholer() {
    textView.text = Constants.placeholderMessage
    textView.textColor = .placeholderBody
  }
  
  private func removeTextViewPlaceholder() {
    textView.text = ""
    textView.textColor = .darkBody
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    removeTextViewPlaceholder()
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      addTextViewPlaceholer()
    }
  }
}

