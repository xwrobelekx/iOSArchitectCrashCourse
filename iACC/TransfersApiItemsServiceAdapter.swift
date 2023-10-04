//	
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

struct TransfersApiItemsServiceAdapter: ItemsService {
    let api: TransfersAPI
    let longDateStyle : Bool
    let fromSentTransfersScreen: Bool
    let select: (Transfer) -> Void
    
    func loadItems(completion: @escaping (Result<[ItemViewModel], Error>) -> Void) {
        api.loadTransfers { result in
            DispatchQueue.mainAsyncIfNeeded {
                completion(result.map { items in
                    return items
                        .filter { fromSentTransfersScreen ? $0.isSender : !$0.isSender }
                        .map { transfer in
                        ItemViewModel(transfer: transfer,
                                      longDateStyle: longDateStyle,
                                      selection: {
                                        select(transfer)
                        })
                    }
                })
            }
        }
    }
}
