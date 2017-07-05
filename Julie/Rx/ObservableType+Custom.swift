//
//  ObservableType+Custom.swift
//  Julie
//
//  Created by Ivan Blagajić on 06/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

extension ObservableType {
    
    
    public func mapVoid() -> Observable<()> {
        return self.map { _ in () }
    }
    
}
