//
//  CollectionType+Optional.swift
//  Julie
//
//  Created by Ivan Blagajić on 08/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

extension CollectionType {
    
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
