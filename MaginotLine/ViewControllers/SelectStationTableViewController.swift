//
//  StartStationTableViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/18.
//

import UIKit
import Alamofire

class SelectStationTableViewController: UITableViewController {

    var stations: [Station] = []
    var beforeVC: ViewController?
    
    @IBOutlet weak var searchBar: UISearchBar!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 60
        searchBar.delegate = self
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func selectStart(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func selectEnd(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return stations.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let station = stations[indexPath.row]
        
        let lblName = cell.viewWithTag(1) as? UILabel
        lblName?.text = station.station_nm
        
        let lblLine = cell.viewWithTag(2) as? UILabel
                lblLine?.text = "\(station.line_num)"
        return cell
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

  


}

//searchBar delegate
extension SelectStationTableViewController: UISearchBarDelegate{
     func searchBarTextDidBeginEditing (_ searchBar: UISearchBar) {
        
        //검색어 변경하면 테이블 다시 그려주어야함
        tableView.reloadData()
        tableView.isHidden = false
    }
     func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        stations = []
    }
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            return
        }
        requestStationName(from: searchText)
    }
}
// REST API
extension SelectStationTableViewController{
    func requestStationName(from stationName: String){
        let url = "http://openAPI.seoul.go.kr:8088/43464a45546c6f7634344855706b57/json/SearchInfoBySubwayNameService/1/5/\(stationName)"
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationRespose.self){[weak self] response in guard case .success(let data) = response.result else {return}

                //데이터 받기
                self?.stations = data.stations
                //테이블뷰 다시 그리기
                self?.tableView.reloadData()
            }
            .resume()
    }
}

