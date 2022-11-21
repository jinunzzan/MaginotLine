//
//  ViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/10.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var tfStart: UITextField!
    var stations: Station?
    
    @IBOutlet weak var tfEnd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfStart.delegate = self
        tfEnd.delegate = self
       
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectStationViewController") as? SelectStationTableViewController else { return }
          vc.beforeVC = self
          self.present(vc, animated: true)
    }
  
    


    
    
}
