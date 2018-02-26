//
//  DailyTrendsTableViewController.swift
//  EtsyTrendsScraper
//
//  Created by Margaret Thomann on 2/26/18.
//  Copyright © 2018 mt-apps. All rights reserved.
//

import UIKit
import SwiftScraper

class TrendTableViewCell : UITableViewCell{
    @IBOutlet weak var trendLabel: UILabel!
}

class DailyTrendsTableViewController: UITableViewController {

    var stepRunner: StepRunner!
    var trendList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Configure Refresh Control
        self.refreshControl?.addTarget(self, action: #selector(DailyTrendsTableViewController.refreshTrends(_:)), for: UIControlEvents.valueChanged)
        
        // Load the initial trends
        self.retrieveTrends()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.trendList.count == 0{
            return 1
        }
        else{
            return self.trendList.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendCell", for: indexPath) as! TrendTableViewCell

        if (self.trendList.count > 0){
        // Configure the cell...
            cell.trendLabel.text = self.trendList[indexPath.row]
            return cell
        }
        else{
            cell.trendLabel.text = "Loading..."
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    // Refresh the trends
    @objc func refreshTrends(_ sender: Any) {
        self.retrieveTrends()
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func retrieveTrends(){
        // Javascript Stuff:
        
        self.trendList.removeAll()
        
        let step1 = OpenPageStep(
            path: "https://www.etsy.com",
            assertionName: "assertEtsyTitle")
        let step2 = ScriptStep(
        functionName: "checkTrends"){ response, _ in
            
            for trend in response as! [String]{
                self.trendList.append(trend)
            }
            self.tableView.reloadData()
            return .proceed
        }
        
        stepRunner = StepRunner(moduleName: "EtsyTrends", steps: [step1, step2])
        stepRunner.insertWebViewIntoView(parent: view)
        stepRunner.state.afterChange.add { change in
            print("-----", change.newValue, "-----")
            switch change.newValue {
            case .inProgress(let index):
                print("About to run step at index", index)
            case .failure(let error):
                print("Failed: ", error.localizedDescription)
            case .success:
                print("Finished successfully")
            default:
                break
            }
        }
        stepRunner.run()
    }

}
