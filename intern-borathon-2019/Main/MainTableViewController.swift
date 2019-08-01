//
//  MainTableViewController.swift
//  intern-borathon-2019
//
//  Created by Aubhro Sengupta on 7/30/19.
//  Copyright © 2019 Team Rocket. All rights reserved.
//

import UIKit
import Charts

class MainTableViewController: UITableViewController {
    
    var points: [DataPoint] = []
    var promPoints: [DataPoint] = []
    var hilltopPoints: [DataPoint] = []
    var creeksidePoints: [DataPoint] = []
    
    var prevProm = 0
    var prevHilltop = 0
    var prevCreekside = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        getCollection(atGarage: "prom", completion: self.refreshPromTable)
        getCollection(atGarage: "hilltop", completion: self.refreshHilltopTable)
        getCollection(atGarage: "creekside", completion: self.refreshCreeksideTable)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.allowsSelection = false
        getCollection(atGarage: "prom", completion: self.refreshPromTable)
        getCollection(atGarage: "hilltop", completion: self.refreshHilltopTable)
        getCollection(atGarage: "creekside", completion: self.refreshCreeksideTable)
        
        let t = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {(time) in
            getCollection(atGarage: "prom", completion: self.refreshPromTable)
            getCollection(atGarage: "hilltop", completion: self.refreshHilltopTable)
            getCollection(atGarage: "creekside", completion: self.refreshCreeksideTable)
            })
        t.fire()
    }
    
    func refreshPromTable(_ data: [DataPoint]) {
        promPoints = data
        let contentOffset = tableView.contentOffset
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.tableView.setContentOffset(contentOffset, animated: false)

    }
    
    func refreshHilltopTable(_ data: [DataPoint]) {
        hilltopPoints = data
        let contentOffset = tableView.contentOffset
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.tableView.setContentOffset(contentOffset, animated: false)

    }
    
    func refreshCreeksideTable(_ data: [DataPoint]) {
        creeksidePoints = data
        let contentOffset = tableView.contentOffset
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.tableView.setContentOffset(contentOffset, animated: false)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return garages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //points = getCollection(atGarage: "prom")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: indexPath) as! MainTableViewCell

        // Configure the cell...
        cell.locationLabel.text = garages[indexPath.row]
        cell.timeSeriesChart.leftAxis.drawGridLinesEnabled = false
        cell.timeSeriesChart.rightAxis.drawGridLinesEnabled = false
        cell.timeSeriesChart.xAxis.drawGridLinesEnabled = false
        cell.timeSeriesChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        cell.timeSeriesChart.legend.enabled = false
        cell.timeSeriesChart.rightAxis.drawLabelsEnabled = false
        cell.timeSeriesChart.isUserInteractionEnabled = false
        var labelPoints: [DataPoint]
        var totalCapacity: Int
        switch indexPath.row {
        case 0:
            cell.timeSeriesChart.data = constructChartData(withData: promPoints, atGarage: garages[indexPath.row])
            labelPoints = promPoints
            totalCapacity = 7
            break
        case 1:
            cell.timeSeriesChart.data = constructChartData(withData: hilltopPoints, atGarage: garages[indexPath.row])
            labelPoints = hilltopPoints
            totalCapacity = 40
            break
        case 2:
            cell.timeSeriesChart.data = constructChartData(withData: creeksidePoints, atGarage: garages[indexPath.row])
            labelPoints = creeksidePoints
            totalCapacity = 30
        default:
            cell.timeSeriesChart.data = constructChartData(withData: points, atGarage: garages[indexPath.row])
            labelPoints = []
            totalCapacity = 0
        }
        
        cell.timeSeriesChart.chartDescription?.text = ""
        if labelPoints.count > 0 {
            let mostRecent:  Int = labelPoints.max(by: {(dp1, dp2) -> Bool in
                return dp1.index < dp2.index
            })!.cars
            
            let spotsFree = totalCapacity - mostRecent
            
            cell.capacityLabel.text = "\(mostRecent)/\(totalCapacity)"
            
            if spotsFree > 5 {
                cell.capacityLabel.textColor = UIColor.green
            } else if spotsFree > 3 {
                cell.capacityLabel.textColor = UIColor.yellow
            } else {
                cell.capacityLabel.textColor = UIColor.red
            }
        } else {
            cell.capacityLabel.text = "0/\(totalCapacity)"
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
