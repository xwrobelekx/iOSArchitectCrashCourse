//	
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

extension ItemViewModel {
    init(friend: Friend, selection: @escaping () -> Void) {
        title = friend.name
        subTitle = friend.phone
        select = selection
    }
}
