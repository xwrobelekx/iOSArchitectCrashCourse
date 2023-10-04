//	
// Copyright © Essential Developer. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    private var friendsCache: FriendsCache!
	
	convenience init(friendsCache: FriendsCache) {
        self.init(nibName: nil, bundle: nil)
        self.friendsCache = friendsCache
        self.setupViewController()
	}

	private func setupViewController() {
		viewControllers = [
			makeNav(for: makeFriendsList(), title: "Friends", icon: "person.2.fill"),
			makeTransfersList(),
			makeNav(for: makeCardsList(), title: "Cards", icon: "creditcard.fill")
		]
	}
    
    private func makeNav(for vc: UIViewController, title: String, icon: String) -> UIViewController {
        vc.navigationItem.largeTitleDisplayMode = .always
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = UIImage(
            systemName: icon,
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
        nav.tabBarItem.title = title
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    
    private func makeTransfersList() -> UIViewController {
        let sent = makeSentTransfersList()
        sent.navigationItem.title = "Sent"
        sent.navigationItem.largeTitleDisplayMode = .always
        
        let received = makeReceivedTransfersList()
        received.navigationItem.title = "Received"
        received.navigationItem.largeTitleDisplayMode = .always
        
        let vc = SegmentNavigationViewController(first: sent, second: received)
        vc.tabBarItem.image = UIImage(
            systemName: "arrow.left.arrow.right",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
        vc.title = "Transfers"
        vc.navigationBar.prefersLargeTitles = true
        return vc
    }
	
	private func makeFriendsList() -> ListViewController {
		let vc = ListViewController()
        
        vc.title = "Friends"
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: vc, action: #selector(addFriend))
        
        let isPremium = User.shared?.isPremium == true
        
        let api = FriendsAPIItemsServiceAdapter(api: FriendsAPI.shared,
                                              cache: isPremium ? friendsCache : NullFriendsCache(),
                                              select: { [weak vc] item in
                                                vc?.select(friend: item)
        }).retry(2)
        
        let cache = FriendsCacheItemsServiceAdapter(cache: friendsCache,
                                                  select: { [weak vc] item in
                                                    vc?.select(friend: item)
        })
        
        vc.service = isPremium ? api.fallback(cache) : api
        
		return vc
	}
	
	private func makeSentTransfersList() -> ListViewController {
		let vc = ListViewController()
        
        vc.navigationItem.title = "Sent"
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .done, target: vc, action: #selector(sendMoney))
        
        vc.service = SentTransfersApiItemsServiceAdapter(api: TransfersAPI.shared,
                                                      select: { [weak vc] transfer in
                                                        vc?.select(transfer: transfer)
        }).retry(1)
        
		return vc
	}
	
	private func makeReceivedTransfersList() -> ListViewController {
		let vc = ListViewController()
        
        vc.navigationItem.title = "Received"
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Request", style: .done, target: vc, action: #selector(requestMoney))
        
        vc.service = ReceivedTransfersApiItemsServiceAdapter(api: TransfersAPI.shared,
                                                          select: { [weak vc] transfer in
                                                            vc?.select(transfer: transfer)
        }).retry(1)
        
		return vc
	}
	
	private func makeCardsList() -> ListViewController {
		let vc = ListViewController()
        
        vc.title = "Cards"
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: vc, action: #selector(addCard))
        
        vc.service = CardsApiItemsServiceAdapter(api: CardAPI.shared, 
                                               select: { [weak vc] card in
                                                 vc?.select(card: card)
        })
		return vc
	}
}
