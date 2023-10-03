//	
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

extension ItemViewModel {
    init(card: Card, selection: @escaping () -> Void) {
        title = card.number
        subTitle = card.holder
        select = selection
    }
}
