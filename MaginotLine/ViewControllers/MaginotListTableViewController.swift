//
//  MaginotListTableViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/21.
//


//마지노선 리스트
import UIKit
import Alamofire

class MaginotListTableViewController: UITableViewController {
    
    var timeTable:[Time]=[]
    var time:Time?
    var timeResult:Time?
    

    // 받아올 stringData

    var strStartStationCD:String = ""
    var strEndStationCD:String = ""
    var strMaginotTime:String = ""
    var strToday:String = ""
    var strStartFrCode: String = ""
    var strEndFrCode: String = ""
    
    
    let apiKey = "4172664e4e6c6f763130366746444b72"
    let type = "json"
    let serviceKey = "SearchSTNTimeTableByIDService"
    var start_index = 1 //요청시작위치
    var end_index = 5 //요청종료위치
    var station_cd = "2561" //전철역코드
    var week_tag = "1" //요일
    var inout_tag = "1" //상/하행선


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
        
        print("마지노선 출발역cd: \(strStartStationCD)")
        print("마지노선 도착역cd: \(strEndStationCD)")
        print("마지노선 출발역fr_cd: \(strStartFrCode)")
        print("마지노선 도착역fr_cd: \(strEndFrCode)")
        print("마지노선 시간: \(strMaginotTime)")
        print("마지노선 요일코드: \(strToday)")
        //역 코드가 0으로 시작하면 오류가 발생한다.

        searchTimeTable(start_index: 1, end_index: 5, station_cd: "0309", week_tag: "1", inout_tag: "1")
    }
    
    func searchTimeTable(start_index:Int, end_index:Int,  station_cd:String, week_tag:String, inout_tag:String){
        
        let str = "http://openAPI.seoul.go.kr:8088/\(apiKey)/\(type)/\(serviceKey)/\(start_index)/\(end_index)/\(station_cd)/\(week_tag)/\(inout_tag)/"

        print(str)
        
        let alamo = AF.request(str, method: .get)
        
        alamo.responseDecodable(of: TimeResult.self)
        { response in print(response)
            guard let result = response.value else {return}
            self.timeTable = result.SearchSTNTimeTableByIDService.row
            print(self.timeTable)
            
            print("============")
            print("출발시간: \(self.timeTable[19].leftTime)")
            print("출발역: \(self.timeTable[0].station_nm)")
            print("============")
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let strToday = formatter.string(from: Date())
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let aa = 30.0
//            var minTime = "\(strToday) \(self.timeTable[0].leftTime)"
            for time in self.timeTable {
                let leftTime = "\(strToday) \(time.leftTime)"
                
                
                
                guard let dateLetfTime = formatter.date(from: leftTime)
                         else {fatalError()}
                let dateLetfTime1 = dateLetfTime.addingTimeInterval(aa * 60.0)
                let strArriveTime = formatter.string(from: dateLetfTime1)
                print(strArriveTime)
                
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
