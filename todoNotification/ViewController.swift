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
                self.scheduleTest()
            }
        }
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

    func scheduleTest(){
        let content = UNMutableNotificationContent()
        content.title = "hello"
        content.sound = .default
        content.body = "world"
        
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "some_id", content: content, trigger: trigger)
        
        center.add(request) { error in
            if error != nil{
                print("something went wrong")
            }
        }
        
    }

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
        cell.textLabel?.text = task.title
//        cell.detailTextLabel?.text = task.date
        return cell
    }
}


struct Reminder{
    let title: String
    let date: Date
    let identifier: String
}
