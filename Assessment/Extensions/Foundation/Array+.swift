//
//  Array+.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
    
}
