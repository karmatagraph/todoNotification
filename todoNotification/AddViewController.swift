//
//  AddViewController.swift
//  todoNotification
//
//  Created by karma on 3/15/22.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var titleLbl: UITextField!
    @IBOutlet weak var bodyLbl: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    public var completion: ((String,String,Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        if let titleText = titleLbl.text, !titleText.isEmpty, let bodyText = bodyLbl.text, !bodyText.isEmpty{
            let targetDate = datePicker.date
            completion?(titleText, bodyText, targetDate)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
