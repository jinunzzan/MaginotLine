//
//  SubwayPathViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/21.
//


//소요시간, 환승시간
import UIKit
import Alamofire

class SubwayPathViewController: UIViewController {
    var route:Result?
    let apiKey:String = "Uod2LyinNkpHwAVsJrWBBA"
    let sid = 202
    let eid = 222

    @IBOutlet weak var lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        metroLine(202,222)
        // Do any additional setup after loading the view.
        
        
        // URLSession.shared.dataTask(with: url)
        
    }
    func metroLine(_ sid:Int,_ eid:Int){
        let str = "https://api.odsay.com/v1/api/subwayPath"
        let params:Parameters = ["apiKey":apiKey, "lang":0, "output":"json", "CID":1000, "SID":sid, "EID":eid]
        let alamo = AF.request(str, method: .get, parameters: params)
        
        alamo.responseDecodable(of: Root.self)
            { response in
                print(response)
            guard let result = response.value else { return }
                self.route = result.result
                print("소요시감\(self.route)")
        }
    }

}

