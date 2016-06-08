//
//  ObservableType+Custom.swift
//  Julie
//
//  Created by Ivan Blagajić on 06/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

extension ObservableType {
    
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func mapVoid() -> Observable<()> {
        return self.map { _ in () }
    }
    
}
