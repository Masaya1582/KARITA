//
//  InitialViewController.swift
//  Karita
//
//  Created by Cookie-san on 2022/03/04.
//

import UIKit
import RealmSwift
import UserNotifications
import M13Checkbox


class InitialViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initTableView()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MarkerFelt-Wide", size: 30)!,.foregroundColor: UIColor.white]
    }
    
    private func initTableView() {
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let registerVC = segue.destination as! RegisterViewController
        if segue.identifier == "edit" {
            let indexPath = self.tableView.indexPathForSelectedRow
            registerVC.task = taskArray[indexPath!.row]
        } else {
            let task = Task()
            let allTasks = realm.objects(Task.self)
            if allTasks.count != 0 {
                task.id = allTasks.max(ofProperty: "id")! + 1
            }
            registerVC.task = task
        }
    }
}

extension InitialViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MainTableViewCell
        cell.contentView.backgroundColor = UIColor.white
        let task = taskArray[indexPath.row]
        cell.titleLabel.text = task.karimonoTitle
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let taskDateString:String = formatter.string(from: task.date)
        cell.dateLabel.text = taskDateString
        
        let today = Date()
        if task.date <= today {
            cell.dateLabel.textColor = .red
            cell.titleLabel.alpha = 0.5
        }
        
        switch cell.checkBox!.stateChangeAnimation {
        case .stroke:
            print("stroke")
        case .fill:
            print("fill")
        case .bounce:
            print("bounce")
        case .expand:
            print("expand")
        case .flat:
            print("flat")
        case .spiral:
            print("spiral now available")
        case .fade:
            print("fade")
        case .dot:
            print("dot")
        }
        
        if let state = cell.checkBox?.checkState {
            switch state {
            case .unchecked:
                print("unchecked")
            case .checked:
                print("checked")
            case .mixed:
                print("mixed")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "edit", sender: nil)
    }
    
    func deletePressed(in cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        try! realm.write {
            self.realm.delete(self.taskArray[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = self.taskArray[indexPath.row]
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
            
            try! realm.write {
                self.realm.delete(self.taskArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                for request in requests {
                    print("/---------------")
                    print(request)
                    print("---------------/")
                }
            }
        }
    }
}
