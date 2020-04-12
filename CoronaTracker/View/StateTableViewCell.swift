//
//  StateTableViewCell.swift
//  CoronaTracker
//
//  Created by Roushil singla on 4/13/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class StateTableViewCell: UITableViewCell {

    @IBOutlet weak var stateName: UILabel!
    @IBOutlet weak var totalCases: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureStateCases(state: Statewise){
        self.stateName.text = state.state
        self.totalCases.text = "Confirmed:\t\t\(state.confirmed ?? 0)"
    }
}
