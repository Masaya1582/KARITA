//
//  RegisterViewController.swift
//  Karita
//
//  Created by Cookie-san on 2022/02/26.
//

import UIKit
import SPIndicator
import RealmSwift

class RegisterViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    @IBOutlet weak var karimonoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var remindDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        karimonoTextField.delegate = self
        nameTextField.delegate = self
        detailTextView.delegate = self
        

        detailTextView.backgroundColor = .white
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
            
            let nav = self.navigationController
            // 一つ前のViewControllerを取得する
            let mainVC = nav?.viewControllers[(nav?.viewControllers.count)!-2] as! ViewController
            // 値を渡す
            mainVC.testArray.append(karimonoTextField.text!)
            

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
