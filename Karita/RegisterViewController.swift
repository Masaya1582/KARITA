//
//  RegisterViewController.swift
//  Karita
//
//  Created by Cookie-san on 2022/02/26.
//

import UIKit
import SPIndicator
import RealmSwift
import UserNotifications

class RegisterViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    @IBOutlet weak var karimonoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var remindDatePicker: UIDatePicker!
    
    let realm = try! Realm()
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        karimonoTextField.delegate = self
        nameTextField.delegate = self
        detailTextView.delegate = self
        
        karimonoTextField.text = task.karimonoTitle
        nameTextField.text = task.name
        detailTextView.text = task.detail
        remindDatePicker.date = task.date
        
        detailTextView.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            try! realm.write {
                self.task.karimonoTitle = self.karimonoTextField.text!
                self.task.name = self.nameTextField.text!
                self.task.detail = self.detailTextView.text
                self.task.date = self.remindDatePicker.date
                self.realm.add(self.task, update: .modified)
            }

            setNotification(task: task)
            super.viewWillDisappear(animated)
        }
    
    func setNotification(task: Task) {
            let content = UNMutableNotificationContent()
            // タイトルと内容を設定(中身がない場合メッセージ無しで音だけの通知になるので「(xxなし)」を表示する)
            if task.karimonoTitle == "" {
                content.title = "(タイトルなし)"
            } else {
                content.title = task.karimonoTitle
            }
            if task.name == "" {
                content.body = "(名前なし)"
            } else {
                content.body = "\(task.name)に返却"
            }
            content.sound = UNNotificationSound.default

            // ローカル通知が発動するtrigger（日付マッチ）を作成
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            // identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
            let request = UNNotificationRequest(identifier: String(task.id), content: content, trigger: trigger)

            // ローカル通知を登録
            let center = UNUserNotificationCenter.current()
            center.add(request) { (error) in
                print(error ?? "ローカル通知登録 OK")  // error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
            }

            // 未通知のローカル通知一覧をログ出力
            center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                for request in requests {
                    print("/---------------")
                    print(request)
                    print("---------------/")
                }
            }
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        view.endEditing(true)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
//        karimonoTextField.resignFirstResponder()
//        nameTextField.resignFirstResponder()
//        detailTextView.resignFirstResponder()
        
        textField.resignFirstResponder()
        if (self.detailTextView.isFirstResponder) {
                self.detailTextView.resignFirstResponder()
            }
        return true
        
        }

    @IBAction func saveAction(_ sender: Any) {
        
        if karimonoTextField.text == "" {
            
            let indicatorView = SPIndicatorView(title: "エラー", message: "借り物項目の入力漏れ", preset: .error)
            indicatorView.present(duration: 3)
            print("値が未入力")
            
        }else {
        
            self.navigationController?.popToRootViewController(animated: true)
            print("戻ります")
           
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
