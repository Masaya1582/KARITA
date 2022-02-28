//
//  ViewController.swift
//  Karita
//
//  Created by Cookie-san on 2022/02/26.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var testArray:[String] = []
    
    let realm = try! Realm()
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        
        let dateString:String = formatter.string(from: task.date)
        cell.dateLabel.text = dateString
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "edit");
        self.navigationController?.pushViewController(storyboard!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete {
//                testArray.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
                try! realm.write {
                                self.realm.delete(self.taskArray[indexPath.row])
                                tableView.deleteRows(at: [indexPath], with: .fade)
                            }
               
            }
        }
    
    
    
    
    
    
}
