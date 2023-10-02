//
// Copyright © Essential Developer. All rights reserved.
//

import UIKit

enum Formatters {
    static var date = DateFormatter()
    static var number = NumberFormatter()
}

extension UIViewController {
    	var presenterVC: UIViewController {
    		parent?.presenterVC ?? parent ?? self
    	}
    
    func select(friend: Friend) {
        let vc = FriendDetailsViewController()
        vc.friend = friend
        show(vc, sender: self)
    }
    
    func select(card: Card) {
        let vc = CardDetailsViewController()
        vc.card = card
        show(vc, sender: self)    }
    
    func select(transfer: Transfer) {
        let vc = TransferDetailsViewController()
        vc.transfer = transfer
        show(vc, sender: self)    }
    
    @objc func addCard() {
        show(AddCardViewController(), sender: self)
    }
    
    @objc func addFriend() {
        show(AddFriendViewController(), sender: self)
    }
    
    @objc func sendMoney() {
        show(SendMoneyViewController(), sender: self)
    }
    
    @objc func requestMoney() {
        show(RequestMoneyViewController(), sender: self)
    }
    
    func show(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        showDetailViewController(alert, sender: self)
    }
}


extension DispatchQueue {
	static func mainAsyncIfNeeded(execute work: @escaping () -> Void) {
		if Thread.isMainThread {
			work()
		} else {
			main.async(execute: work)
		}
	}
}
