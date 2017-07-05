//
//  CollectionType+Optional.swift
//  Julie
//
//  Created by Ivan Blagajić on 08/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

extension Collection {
    
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
