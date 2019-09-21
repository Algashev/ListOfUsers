//
//  Date.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 21/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import Foundation

extension Date {
    init?(iso8601Date date: String) {
        guard let date = ISO8601DateFormatter().date(from:date) else { return nil }
        self = date
    }
}
