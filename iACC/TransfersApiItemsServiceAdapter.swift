//	
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

struct ReceivedTransfersApiItemsServiceAdapter: ItemsService {
    let api: TransfersAPI
    let select: (Transfer) -> Void
    
    func loadItems(completion: @escaping (Result<[ItemViewModel], Error>) -> Void) {
        api.loadTransfers { result in
            DispatchQueue.mainAsyncIfNeeded {
                completion(result.map { items in
                    return items
                        .filter { !$0.isSender }
                        .map { transfer in
                        ItemViewModel(transfer: transfer,
                                      longDateStyle: false,
                                      selection: {
                                        select(transfer)
                        })
                    }
                })
            }
        }
    }
}
