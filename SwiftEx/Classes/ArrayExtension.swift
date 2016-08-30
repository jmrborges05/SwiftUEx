//
//  ArrayExtension.swift
//  smiity
//
//  Created by João Borges on 03/06/16.
//  Copyright © 2016 Mobinteg. All rights reserved.
//

import Foundation


public extension Array {
    public func contains<T where T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
}
