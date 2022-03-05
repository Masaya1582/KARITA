//
//  MainTableViewCell.swift
//  Karita
//
//  Created by Cookie-san on 2022/02/26.
//

import UIKit
import M13Checkbox
import UserNotifications

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: M13Checkbox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCheckBox()
        self.backgroundColor = .white
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
            titleLabel.textColor = .red
            //dateLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            print(checkBox.checkState)
            
        case .unchecked:
            checkBox.setCheckState(.checked, animated: false)
            titleLabel.textColor = .black
            //dateLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            print(checkBox.checkState)
            
        case .mixed:
            print(checkBox.checkState)
            break
        }
    }
    
}
