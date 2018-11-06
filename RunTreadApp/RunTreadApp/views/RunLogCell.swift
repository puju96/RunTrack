//
//  RunLogCell.swift
//  RunTreadApp
//
//  Created by Apple on 06/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {

    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var AvgPaceLbl: UILabel!
    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
      
    }
    
    func configure(run : Run){
        
        durationLbl.text = run.duration.formatDurationString()
        totalDistanceLbl.text = "\(run.distance.meterTomiles(places: 2)) mi"
        AvgPaceLbl.text = run.pace.formatDurationString()
        dateLbl.text = run.date.getDateString()
    }

    

}
