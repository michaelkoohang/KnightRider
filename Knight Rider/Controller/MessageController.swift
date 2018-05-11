//
//  MessageController.swift
//  Knight Rider
//
//  Created by Michael on 2/26/18.
//  Copyright © 2018 MGA. All rights reserved.
//

import UIKit
import Alamofire
import JSQMessagesViewController
import SwiftKeychainWrapper

class MessageController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    var ride: Ride!
    var TOKEN = KeychainWrapper.standard.string(forKey: TOKEN_KEY)
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadMessages()
        
        senderId = KeychainWrapper.standard.string(forKey: UID_KEY)
        senderDisplayName = "..."
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Messages"
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(downloadMessages), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func downloadMessages() {
        
        messages.removeAll()
        
        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]
        
        Alamofire.request(MESSAGES_URL + "\(ride.id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { (response) in
            
            if let array = response.result.value as? [Dictionary<String, AnyObject>] {
                
                for obj in array {
                    
                    let message = Message(messageDict: obj)
                    let id = message.userId
                    let name = message.firstName + " " + message.lastName
                    let date = message.logDate
                    let text = message.comment
                    
                    if let jmessage = JSQMessage(senderId: "\(id)", senderDisplayName: name, date: date, text: text) {
                        
                        self.messages.append(jmessage)
                        
                    }
                    
                }
                
                self.finishReceivingMessage()
            }
            
        }
        
        self.collectionView.reloadData()
        
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        
        let messageParameters: Parameters = [
            
            "tripId": ride.id,
            "userId": senderId!,
            "comment": text
        ]
        
        let tokenHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Authorization": "Bearer \(TOKEN!)",
            "Cache-Control": "no-cache"
        ]
        
        Alamofire.request(MESSAGES_URL + "\(ride.id)/" + senderId!, method: .post, parameters: messageParameters, encoding: JSONEncoding.default, headers: tokenHeaders).responseJSON { (response) in
            
            self.downloadMessages()
            self.view.endEditing(true)
            self.finishSendingMessage(animated: true)
        }
        
    }
    
}
