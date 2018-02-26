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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let step1 = OpenPageStep(path: "https://www.etsy.com")
        print(step1)
        stepRunner = StepRunner(moduleName: "EtsyTrends", steps: [step1])
        stepRunner.insertWebViewIntoView(parent: view)
        stepRunner.run()
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
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendCell", for: indexPath) as! TrendTableViewCell

        // Configure the cell...
        cell.trendLabel.text = "test"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
}
