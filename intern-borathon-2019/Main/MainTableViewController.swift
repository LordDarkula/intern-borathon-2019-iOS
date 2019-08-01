//
//  MainTableViewController.swift
//  intern-borathon-2019
//
//  Created by Aubhro Sengupta on 7/30/19.
//  Copyright © 2019 Team Rocket. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var points: [DataPoint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        getCollection(atGarage: "prom", completion: self.refreshTable)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCollection(atGarage: "prom", completion: self.refreshTable)
        
        let t = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {(time) in
            getCollection(atGarage: "prom", completion: self.refreshTable)
            })
        t.fire()
    }
    
    func refreshTable(_ data: [DataPoint]) {
        points = data
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //points = getCollection(atGarage: "prom")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: indexPath) as! MainTableViewCell

        // Configure the cell...
        cell.locationLabel.text = "Prom"
        cell.timeSeriesChart.leftAxis.drawGridLinesEnabled = false
        cell.timeSeriesChart.rightAxis.drawGridLinesEnabled = false
        cell.timeSeriesChart.xAxis.drawGridLinesEnabled = false
        cell.timeSeriesChart.data = constructChartData(withData: points, atGarage: "prom")
        cell.timeSeriesChart.chartDescription?.text = ""
        if points.count > 0 {
            let mostRecent:  Int = points.max(by: {(dp1, dp2) -> Bool in
                return dp1.index < dp2.index
            })!.cars
            cell.capacityLabel.text = "\(String(describing: mostRecent)) cars in lot"
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
