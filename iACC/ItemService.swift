//	
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

protocol ItemsService {
    func loadItems(completion: @escaping (Result<[ItemViewModel], Error>) -> Void)
}

extension ItemsService {
    /// Helper method to simplify the call site
    ///
    /// From this: 
    /// `vc.service = ItemServiceWithFallback(primary: api, fallback: cache)`
    ///
    /// To this: 
    /// `vc.service = api.fallback(cache)`
    func fallback(_ fallback: ItemsService) -> ItemsService {
        ItemServiceWithFallback(primary: self, fallback: fallback)
    }
    
    /// Helper method to make the  retry logic simpler.
    ///
    /// From this:
    /// `vc.service = isPremium ? api.fallback(api).fallback(api).fallback(cache) : api.fallback(api).fallback(api)`
    ///
    /// To this:
    /// `vc.service = isPremium ? api.retry(2).fallback(cache) : api.retry(2)`
    ///
    /// Or Even this:
    /// `let api = FriendsAPIItemsServiceAdapter(api: FriendsAPI.shared,`
    /// `cache: isPremium ? friendsCache : NullFriendsCache(),`
    /// `select: { [weak vc] item in`
    ///     `vc?.select(friend: item)`
    /// `}).retry(2)`
    ///
    ///  `vc.service = isPremium ? api.fallback(cache) : api`
    func retry(_ retryCount: UInt) -> ItemsService {
        var service: ItemsService = self
        for _ in 0..<retryCount {
            service = service.fallback(self)
        }
        return service
    }
}

/// Composite pattern with primary strategy and fallback strategy
struct ItemServiceWithFallback: ItemsService {
    let primary: ItemsService
    let fallback: ItemsService
    
    func loadItems(completion: @escaping (Result<[ItemViewModel], Error>) -> Void) {
        primary.loadItems { result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                fallback.loadItems(completion: completion)
            }
        }
    }
}
