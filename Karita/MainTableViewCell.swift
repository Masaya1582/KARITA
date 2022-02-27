//
//  MainTableViewCell.swift
//  Karita
//
//  Created by Cookie-san on 2022/02/26.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkMark: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func checkAction(_ sender: Any) {
        
        print("Button Tapped")
        let image = UIImage(named: "checkmark.circle.fill")
        checkMark.imageView?.image = image
        
    }
    
    
    
}
