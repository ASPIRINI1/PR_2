//
//  NewWordsTableViewCell.swift
//  PR_1
//
//  Created by Станислав Зверьков on 02.02.2022.
//

import UIKit

class NewWordsTableViewCell: UITableViewCell {

    @IBOutlet weak var rusLabel: UILabel!
    @IBOutlet weak var engLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCellColor(color:UIColor,completion: @escaping()->()){
            self.backgroundColor = color
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.backgroundColor = .white
                completion()
            }
    }
}
