//
//  Card.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 14/06/22.
//

import Foundation
import IGListKit

class Card: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return accountNumber as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Card else { return false }
        return self.accountNumber == object.accountNumber
    }
    
    let bankName: String
    let accountNumber: String
    let ownerName: String
    
    init(bankName: String, accountNumber: String, ownerName: String) {
        self.bankName = bankName
        self.accountNumber = accountNumber
        self.ownerName = ownerName
    }
}
