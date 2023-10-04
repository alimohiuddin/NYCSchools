//
//  SchoolModal.swift
//  20230314-AliMohiuddin-NYCSchools
//
//  Created by Ali Mohiuddin on 14/03/23.
//

import UIKit

class SchoolListCell: UITableViewCell {

    @IBOutlet weak var discriptionLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var schoolNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dataSource(item : Schools?){
        
        self.schoolNameLbl.text = item?.school_name ?? ""
        self.phoneNumberLbl.text = item?.phone_number ?? ""
        self.discriptionLbl.text = item?.overview_paragraph ?? ""
        
    }
    
}
