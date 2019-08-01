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
    var lineChartEntry = [ChartDataEntry]()
    
    for point in points {
        let value = ChartDataEntry(x: Double(point.index) , y: Double(point.cars))
        lineChartEntry.append(value)
    }
    
//    lineChartEntry.sort(by: ({(c1, c2) -> Bool in
//            c1.x < c2.x
//        }
//    ))
    
    let line = LineChartDataSet(entries: lineChartEntry, label: garage)
    line.colors = [NSUIColor.orange]
    line.drawCircleHoleEnabled = false
    line.drawCirclesEnabled = false
    line.drawValuesEnabled = false
    let data = LineChartData(dataSet: line)
    //data.addDataSet(line)
    
    
    return data
}
