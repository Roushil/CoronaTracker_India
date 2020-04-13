//
//  GraphViewController.swift
//  CoronaTracker
//
//  Created by Roushil singla on 4/13/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    var state: Statewise?{
        didSet{
            setValuesAndPercentage(state: state)
        }
    }
    
    @IBOutlet weak var stateName: UILabel!
    @IBOutlet weak var totalCases: UILabel!
    @IBOutlet weak var activeCases: UILabel!
    @IBOutlet weak var recoveredCases: UILabel!
    @IBOutlet weak var deathCases: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    var name: String?
    var total: Int?
    var active: Int?
    var recovered: Int?
    var deaths: Int?
    var activePercentage: Double?
    var recPercentage: Double?
    var deathPercentage: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setPieChart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pieChartView.animateChart()
    }
    
    func setPieChart(){

        guard let active = activePercentage, let recover = recPercentage, let death = deathPercentage else { return }
        pieChartView.slices = [
            Slice(percent: CGFloat(active), color: UIColor.yellow),
            Slice(percent: CGFloat(recover), color: UIColor.green),
            Slice(percent: CGFloat(death), color: UIColor.red),
            ]
    }
    
    func setValuesAndPercentage(state: Statewise?){
        
        guard let affectedState = state else { return }
        name = affectedState.state
        total = affectedState.confirmed!
        active = affectedState.active!
        recovered = affectedState.recovered!
        deaths = state!.deaths!
        
        if total != 0{
            let activeAge = (active!.double / total!.double)
            activePercentage = roundUpDigits(activeAge)
            let recoverAge = (recovered!.double / total!.double)
            recPercentage = roundUpDigits(recoverAge)
            let deathAge = (deaths!.double / total!.double)
            deathPercentage = roundUpDigits(deathAge)
        }
    }
    
    func setData(){
        stateName.text = name
        totalCases.text = "\(total ?? 0)"
        activeCases.text = "\(active ?? 0)"
        recoveredCases.text = "\(recovered ?? 0)"
        deathCases.text = "\(deaths ?? 0)"
    }
    
     func roundUpDigits(_ value: Double) -> Double{
        return Double(round(100 * value) / 100)
    }
}

extension Int{
    var double: Double{
        return Double(self)
    }
}
