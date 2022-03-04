//
//  MainTableViewCell.swift
//  Karita
//
//  Created by Cookie-san on 2022/02/26.
//

import UIKit
import RealmSwift

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkMark: UIButton!
    
    private let realm = try! Realm()
    private var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: true)
    var task: Task!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func checkAction(_ sender: UIButton) {
        
        self.task.isChecked = false
        print("Button Tapped")
       
    }
}
