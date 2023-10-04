///
//  SchoolModal.swift
//  20230314-AliMohiuddin-NYCSchools
//
//  Created by Ali Mohiuddin on 14/03/23.
//

import UIKit

class SchoolDetailCell: UITableViewCell {

    @IBOutlet weak var readingScoreLbl: UILabel!
    @IBOutlet weak var schoolNameLbl: UILabel!
    
    @IBOutlet weak var mathScoreLbl: UILabel!
    @IBOutlet weak var writingScoreLbl: UILabel!
    @IBOutlet weak var targetScoreLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dataSource(item: SchoolDetail? ){
        
        self.schoolNameLbl.text = item?.school_name ?? ""
        self.targetScoreLbl.text = item?.num_of_sat_test_takers ?? ""
        self.readingScoreLbl.text = item?.sat_critical_reading_avg_score ?? ""
        self.writingScoreLbl.text = item?.sat_writing_avg_score ?? ""
        self.mathScoreLbl.text = item?.sat_math_avg_score ?? ""
        
    }
    
}
