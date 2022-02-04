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

    func setCellColor(color:String,completion: @escaping()->()){
        switch color{
        case "green":
            self.backgroundColor = .green
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { t in
                self.backgroundColor = .white
                completion()
            }
        case "red":
            self.backgroundColor = .green
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { t in
                self.backgroundColor = .white
                completion()
            }
        default: break
        }
    }
}
