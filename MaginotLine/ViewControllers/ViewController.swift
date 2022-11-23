//
//  ViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/10.
//


//메인 화면
import UIKit
import Alamofire

class ViewController: UIViewController{
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var endBtn: UIButton!
    var selectMaginotTime = ""
    @IBOutlet weak var timeBtn: UIButton!
    
    var stations: Station?
    
    let pickerListHour = ["03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26"]
    let pickerListMinute = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    let pickerListDate = ["평일", "토요일", "공휴일"]
    let dateCode = ["1","2","3"] //WEEK_TAG
    
    
//    var pickerView = UIPickerView()
    var typeValue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    // 출발역 도착역 선택 후 받아오기
    @IBAction func departureBtn(_ sender: Any){
       
    }
    func setStation(type:Int, value:String){
        
        if type == 0 {
            startBtn.setTitle("        \(value)",for:.normal)
        } else {
            endBtn.setTitle("        \(value)",for:.normal)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? SelectStationTableViewController else {return}
        vc.beforeVC = self
    }
    
    // picker 그려주기
    @IBAction func timePicker(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alert.modalPresentationCapturesStatusBarAppearance = true
        let pickerFrame = UIPickerView(frame: CGRect(x: -8, y: 20, width: self.view.frame.width, height: 140))
        alert.view.addSubview(pickerFrame)
        pickerFrame.delegate = self
        pickerFrame.dataSource = self
        
        
        pickerFrame.selectRow(0, inComponent: 0, animated: false)
        pickerFrame.selectRow(0, inComponent: 1, animated: false)
        pickerFrame.selectRow(0, inComponent: 2, animated: false)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
//
        // 확인 선택시 값 저장, 버튼에 출력
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { action in
            let hour = self.pickerListHour[pickerFrame.selectedRow(inComponent: 0)]
            let min = self.pickerListMinute[pickerFrame.selectedRow(inComponent: 1)]
            let day = self.dateCode[pickerFrame.selectedRow(inComponent: 2)]
            
            self.selectMaginotTime = "\(hour):\(min)"
            print("\(hour):\(min)")
            
            self.timeBtn.setTitle(self.selectMaginotTime, for: .normal)
            
            
            
            print("\(hour)시\(min)분/ 요일은: \(day)")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerListHour.count
        } else if component == 1 {
            return pickerListMinute.count
        } else {
            return pickerListDate.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return "\(pickerListHour[row]) 시"
        } else if component == 1 {
            return "\(pickerListMinute[row]) 분"
        } else {
            return pickerListDate[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            print("\(pickerListHour[row]) 시")
        } else if component == 1 {
            print("\(pickerListMinute[row]) 분")
        } else {
           print(pickerListDate[row]) 
        }
    }
}
