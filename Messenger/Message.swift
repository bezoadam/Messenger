//
//  Message.swift
//  Messenger
//
//  Created by Adam Bezák on 13.4.17.
//  Copyright © 2017 Adam Bezák. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?

    func chatPartnerID() -> String? {
        
        if fromId == FIRAuth.auth()?.currentUser?.uid {
            return toId
        }
        else {
            return fromId
        }
    }
}
