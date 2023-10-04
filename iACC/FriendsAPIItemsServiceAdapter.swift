//	
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

struct FriendsAPIItemsServiceAdapter: ItemsService {
    let api: FriendsAPI
    let cache: FriendsCache
    let select: (Friend) -> Void
    
    func loadItems(completion: @escaping (Result<[ItemViewModel], Error>) -> Void) {
        api.loadFriends { result in
            DispatchQueue.mainAsyncIfNeeded {
                completion(result.map { items in
                    cache.save(items)
                    
                    return items.map { item in
                        ItemViewModel(friend: item) {
                            select(item)
                        }
                    }
                })
            }
        }
    }
}
