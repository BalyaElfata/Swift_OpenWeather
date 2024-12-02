//
//  Item.swift
//  Swift_OpenWeather
//
//  Created by Balya Elfata on 02/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
