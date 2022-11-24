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
    var strStartFrCode = ""
    var strEndFrCode = ""
    
    //출발시간+ 소요시간
    var strArriveTime = ""
    // strArriveTime이 들어갈 배열
    
    
    // 시간표 api
    let apiKey = "4172664e4e6c6f763130366746444b72"
    let type = "json"
    let serviceKey = "SearchSTNTimeTableByIDService"
    var start_index = 1 //요청시작위치
    var end_index = 5 //요청종료위치
    var station_cd = "2561" //전철역코드
    var week_tag = "1" //요일
    var inout_tag = "1" //상/하행선

    // 소요시간 api
    var route:Result?
    //1. var exchangeInfoSet:ExChangeInfo? - nil값 나옴
    var exchangeInfoSet:ExChangeInfoSet?
    //환승시간 변수
    var transMinute:Int?
    
    // fr_code 사용
    let apiKeyOdi:String = "Uod2LyinNkpHwAVsJrWBBA"
    let sid = 202
    let eid = 222
    var timeArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
        
        print(timeTable)
        print("마지노선 출발역cd: \(strStartStationCD)")
        print("마지노선 도착역cd: \(strEndStationCD)")
        print("마지노선 출발역fr_cd: \(strStartFrCode)")
        print("마지노선 도착역fr_cd: \(strEndFrCode)")
        print("마지노선 시간: \(strMaginotTime)")
        print("마지노선 요일코드: \(strToday)")
        
       

        searchTimeTable(start_index: 1, end_index: 5, station_cd: strStartStationCD, week_tag: strToday, inout_tag: "1")
        searchSubwayPath(strStartFrCode ?? "", strEndFrCode ?? "")
    }
    
    func searchTimeTable(start_index:Int, end_index:Int,  station_cd:String, week_tag:String, inout_tag:String){
        
        let str = "http://openAPI.seoul.go.kr:8088/\(apiKey)/\(type)/\(serviceKey)/\(start_index)/\(end_index)/\(station_cd)/\(week_tag)/\(inout_tag)/"

        print(str)
        
        let alamo = AF.request(str, method: .get)
        
        alamo.responseDecodable(of: TimeResult.self)
        { [self] response in print(response)
            guard let result = response.value else {return}
            self.timeTable = result.SearchSTNTimeTableByIDService.row
            print(self.timeTable)
            self.tableView.reloadData()
            
            
            print("============")
            print("출발시간: \(self.timeTable[0].leftTime)")
            print("출발역: \(self.timeTable[0].station_nm)")
            
            print("============")
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let strToday = formatter.string(from: Date())
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var subWayLeadTime = Double(self.route?.globalTravelTime ?? Int(0.0))
            print("지하철 소요시간: \(subWayLeadTime)")
//            var minTime = "\(strToday) \(self.timeTable[0].leftTime)"
            
            timeArray = [String]()
            for time in self.timeTable {
                let leftTime = "\(strToday) \(time.leftTime)"
                guard let dateLetfTime = formatter.date(from: leftTime)
                         else {fatalError()}
                let dateLetfTime1 = dateLetfTime.addingTimeInterval(subWayLeadTime * 60.0)
                self.strArriveTime = formatter.string(from: dateLetfTime1)
                print("도착시간: \(strArriveTime)")
                timeArray.append(strArriveTime)
            }
            
        }
        tableView.reloadData()
    }
    
func searchSubwayPath(_ sid:String,_ eid:String){
    let str = "https://api.odsay.com/v1/api/subwayPath"
    let params:Parameters = ["apiKey":apiKeyOdi, "lang":0, "output":"json", "CID":1000, "SID":sid, "EID":eid]
    let alamo = AF.request(str, method: .get, parameters: params)
    
    alamo.responseDecodable(of: Root.self)
        { response in
            print(response)
        guard let result = response.value else { return }
            self.route = result.result
            print("==================")
            print("전체 운행소요시간\(self.route?.globalTravelTime)")
            print("==================")
            self.exchangeInfoSet = self.route?.exChangeInfoSet
            if let infoSet = self.exchangeInfoSet {
                print("환승역ID:\(infoSet.exChangeInfo[0].exSID)")
                print("환승소요시간(초):\(infoSet.exChangeInfo[0].exWalkTime)")
                self.transMinute = infoSet.exChangeInfo[0].exWalkTime / 60
                if (self.transMinute ?? 0) % 60 == 0 {
                    self.transMinute = self.transMinute
                } else {
                    self.transMinute! += 1
                }
                print("환승소요시간(분): \(self.transMinute)분")
                print("==================")
            } else {
                print("전체 운행소요시간\(self.route?.globalTravelTime)")
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
      
        return timeTable.count
        
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maginotcell", for: indexPath)

        let time = timeTable[indexPath.row]
        
              let lblStart = cell.viewWithTag(1) as? UILabel
        lblStart?.text = time.station_nm
        let lblStartTime = cell.viewWithTag(2) as? UILabel
        lblStartTime?.text = time.arriveTime

        let lblEnd = cell.viewWithTag(3) as? UILabel
        lblEnd?.text = self.route?.globalEndName
        
        let lblEndTime = cell.viewWithTag(4) as? UILabel
        lblEndTime?.text = timeArray[indexPath.row]
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
