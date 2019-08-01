//
//  Charts.swift
//  intern-borathon-2019
//
//  Created by Aubhro Sengupta on 7/31/19.
//  Copyright © 2019 Team Rocket. All rights reserved.
//

import Foundation
import Charts

let calendar = Calendar.current

func constructChartData(withData points: [DataPoint], atGarage garage: String) -> ChartData {
    print("Constructing chart Data . . .")
    var lineChartEntry = [ChartDataEntry]()
    
    for point in points {
        let value = ChartDataEntry(x: Double(point.index) , y: Double(point.cars))
        lineChartEntry.append(value)
    }
    
    let line = LineChartDataSet(entries: lineChartEntry, label: garage)
    line.colors = [NSUIColor.orange]
    
    let data = LineChartData(dataSet: line)
    //data.addDataSet(line)
    
    return data
}
