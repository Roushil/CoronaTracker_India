//
//  CoronaDataCell.swift
//  CoronaTracker
//
//  Created by Roushil singla on 4/12/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class CoronaDataCell: UITableViewCell {

    @IBOutlet weak var dayCases: UILabel!
    @IBOutlet weak var totalCases: UILabel!
    @IBOutlet weak var activeCases: UILabel!
    @IBOutlet weak var recoveredCases: UILabel!
    @IBOutlet weak var deathCases: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configureTotalCases(cases: History){
        
        self.dayCases.text = getDate(caseDate: cases.day!)
        self.totalCases.text = "Confirmed:\t\t\(cases.total?.confirmed ?? 0)"
        self.activeCases.text = "Active:\t\t\(cases.total?.active ?? 0)"
        self.recoveredCases.text = "Recovered:\t\t\(cases.total?.recovered ?? 0)"
        self.deathCases.text = "Deaths:\t\t\(cases.total?.deaths ?? 0)"
    }
    
    func getDate(caseDate: String) -> String{
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM d, yyyy"
        let dates: Date? = dateFormatterGet.date(from: "\(caseDate)")
        return (dateFormatterPrint.string(from: dates!))
    }
}

