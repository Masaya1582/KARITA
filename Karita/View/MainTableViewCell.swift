//
//  MainTableViewCell.swift
//  Karita
//
//  Created by Cookie-san on 2022/02/26.
//

import UIKit
import M13Checkbox
import RealmSwift
import UserNotifications


class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: M13Checkbox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private let realm = try! Realm()
    private var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCheckBox()
    }
    
    private func initCheckBox() {
        checkBox.animationDuration = 3.0
        checkBox.stateChangeAnimation = .spiral
        checkBox.setCheckState(.checked, animated: false)
        checkBox.setCheckState(.unchecked, animated: false)
        checkBox.checkedValue = 1.0
        checkBox.uncheckedValue = 0.0
        checkBox.mixedValue = 0.5
        checkBox.backgroundColor = .white
        checkBox.tintColor = .green
        checkBox.secondaryTintColor = .green
        checkBox.secondaryCheckmarkTintColor = .white
        checkBox.markType = .checkmark
        checkBox.checkmarkLineWidth = 2.0
        checkBox.boxLineWidth = 2.0
        checkBox.cornerRadius = 4.0
        checkBox.boxType = .circle
        checkBox.hideBox = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func checkAction(_ sender: M13Checkbox) {
        
        switch sender.checkState {
        case .checked:
            checkBox.setCheckState(.unchecked, animated: false)
            print(checkBox.checkState)
            
        case .unchecked:
            checkBox.setCheckState(.checked, animated: false)
            print(checkBox.checkState)
            
        case .mixed:
            print(checkBox.checkState)
            break
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            // セルを削除する
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialView = storyboard.instantiateViewController(withIdentifier: "initial") as! InitialViewController
            //UITableView内の座標に変換
            let point = initialView.tableView.convert(sender.center, from: sender)
            //座標からindexPathを取得
            let indexPath = initialView.tableView.indexPathForRow(at: point)
            
            try! initialView.realm.write {
                initialView.realm.delete(initialView.taskArray[indexPath!.row])
                initialView.tableView.deleteRows(at: [indexPath!], with: .fade)
            }
            
            let center = UNUserNotificationCenter.current()
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
