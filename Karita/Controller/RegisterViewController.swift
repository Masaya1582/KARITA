

import UIKit
import SPIndicator
import RealmSwift
import UserNotifications
import PKHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var karimonoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var remindDatePicker: UIDatePicker!
    
    private let realm = try! Realm()
    var task: Task!
    let today = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //初期画面設定
    private func setupView() {
        karimonoTextField.delegate = self
        nameTextField.delegate = self
        detailTextView.delegate = self
        remindDatePicker.preferredDatePickerStyle = .compact
        remindDatePicker.datePickerMode = .dateAndTime
        remindDatePicker.minimumDate = today
        karimonoTextField.text = task.karimonoTitle
        nameTextField.text = task.name
        detailTextView.text = task.detail
        remindDatePicker.date = task.date
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 15.0),
            .foregroundColor : UIColor.lightGray
        ]
        karimonoTextField.attributedPlaceholder = NSAttributedString(string: "借り物", attributes: attributes)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "名前", attributes: attributes)
        detailTextView.backgroundColor = .white
    }
    
    //通知機能(指定時間になったら通知を飛ばす)の管理
    private func setNotification(task: Task) {
        let content = UNMutableNotificationContent()
        content.title = task.karimonoTitle == "" ? "(題名なし)" : task.karimonoTitle
        content.body = task.name == "" ? "返却時間です" : "\(task.name)に返却"
        content.sound = .default
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: String(task.id), content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            print(error ?? "ローカル通知登録 OK")
        }
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("---------------/")
            }
        }
    }
    
    //保存機能
    @IBAction func saveAction(_ sender: Any) {
        //[借り物]項目が未入力なら保存せずエラーメッセージを表示する
        if karimonoTextField.text == "" {
            let indicatorView = SPIndicatorView(title: "エラー", message: "借り物項目の入力漏れ", preset: .error)
            indicatorView.present(duration: 3)
            return
        }
        try! realm.write {
            self.task.karimonoTitle = self.karimonoTextField.text!
            self.task.name = self.nameTextField.text!
            self.task.detail = self.detailTextView.text
            self.task.date = self.remindDatePicker.date
            self.realm.add(self.task, update: .modified)
        }
        setNotification(task: task)
        HUD.flash(.success, delay: 1.0)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

//textfiledを閉じる設定
extension RegisterViewController: UITextFieldDelegate, UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if self.detailTextView.isFirstResponder {
            self.detailTextView.resignFirstResponder()
        }
        return true
    }
    
}
