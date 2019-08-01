//
//  point.swift
//  intern-borathon-2019
//
//  Created by Aubhro Sengupta on 7/31/19.
//  Copyright © 2019 Team Rocket. All rights reserved.
//

import Foundation

class DataPoint {
    
    let index: Int
    let cars: Int
    let timestamp: Date
    
    public var description: String { return "DataPoint \(index) at \(timestamp), of \(cars) cars" }
    
    init(indexOf index: Int, numberOfCars cars: Int, at time: Date) {
        self.index = index
        self.cars = cars
        self.timestamp = time
    }
}
