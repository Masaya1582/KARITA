

import UIKit
import M13Checkbox
import UserNotifications
import RealmSwift

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
        checkBox.setCheckState(.checked, animated: false)
        checkBox.setCheckState(.unchecked, animated: false)
        checkBox.checkedValue = 1.0
        checkBox.uncheckedValue = 0.0
        checkBox.mixedValue = 0.5
        checkBox.animationDuration = 1.0
        checkBox.stateChangeAnimation = .spiral
        checkBox.backgroundColor = .white
        checkBox.tintColor = .red
        checkBox.secondaryTintColor = .black
        checkBox.secondaryCheckmarkTintColor = .red
        checkBox.markType = .checkmark
        checkBox.checkmarkLineWidth = 2.0
        checkBox.boxLineWidth = 0.5
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
            titleLabel.alpha = 0.5
            dateLabel.textColor = .red
            
        case .unchecked:
            checkBox.setCheckState(.checked, animated: false)
            titleLabel.alpha = 1.0
            dateLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            
        case .mixed:
            break
        }
    }
    
}
