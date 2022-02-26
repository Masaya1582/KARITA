//
//  MainTableViewCell.swift
//  Karita
//
//  Created by Cookie-san on 2022/02/26.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkImage: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkMark: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkTapped(_ sender: Any) {
        
        checkMark.imageView?.image = UIImage(named: "checkmark.circle.fill")
        print("Button Tapped")
        
    }
    
    
}
