//
//  MaginotListTableViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/21.
//

import UIKit
import Alamofire

class MaginotListTableViewController: UITableViewController {
    
    var timeTable:TimeTable?
    
    let apiKey = "4172664e4e6c6f763130366746444b72"
    var start_index = 1
    var end_index = 5
    var station_cd = 2561
    var week_tag = 1
    var inout_tag = 1
    
    var timeTables: [TimeTable] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
        
        timeTable(1,5,2561,1,1)
    }
    
    func timeTable(_ start_index:Int, _ end_index:Int, _ station_cd:Int, _ week_tag:Int, _ inout_tag:Int){
        let str = "http://openAPI.seoul.go.kr:8088"
        let params:Parameters = ["KEY":apiKey, "Type":"json", "SERVICE":"SearchSTNTimeTableByIDService", "START_INDEX":start_index, "END_INDEX":end_index, "STATION_CD":station_cd, "WEEK_TAG":week_tag, "INOUT_TAG":inout_tag]
        
        let alamo = AF.request(str, method: .get, parameters: params)
        
        alamo.responseDecodable(of: timeTable.self)
        { response in print(response)
            guard let result = response.value else {return}
            self.timeTable = result.result
            print(self.timeTable)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
