//
//  ViewController.swift
//  todoNotification
//
//  Created by karma on 3/15/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let center = UNUserNotificationCenter.current()

    
    @IBOutlet weak var tableView: UITableView!
    
    var models: [Reminder] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            print(granted)
            if granted {
                // self.scheduleTest()
                print("notification access granted")
            }
        }
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    @IBAction func didTapAdd(_ sender: UIBarButtonItem) {
        // show the add vc
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "addVC") as? AddViewController else{return}
        vc.title = "New Reminder"
        vc.completion = {title ,body , date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = Reminder(title: title, date: date, identifier: "id_\(title)")
                self.models.append(new)
                self.tableView.reloadData()
                
                // set the content
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body
                
                
                let targetDate = date
                // set the trigger
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
                // set the request
                let request = UNNotificationRequest(identifier: "some_id", content: content, trigger: trigger)
                
                // add the request
                self.center.add(request) { error in
                    if error != nil{
                        print("something went wrong")
                    }
                }
            }
            
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }

//    func scheduleTest(){
//        let content = UNMutableNotificationContent()
//        content.title = "hello"
//        content.sound = .default
//        content.body = "world"
//
//
//        let targetDate = Date().addingTimeInterval(10)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
//
//        let request = UNNotificationRequest(identifier: "some_id", content: content, trigger: trigger)
//
//        center.add(request) { error in
//            if error != nil{
//                print("something went wrong")
//            }
//        }
//
//    }

}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath)
        let date = models[indexPath.row].date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = "Due: \(formatter.string(from: date))"
        
        return cell
    }
}


struct Reminder{
    let title: String
    let date: Date
    let identifier: String
}
