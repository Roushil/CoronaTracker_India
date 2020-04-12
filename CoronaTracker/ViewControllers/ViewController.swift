//
//  ViewController.swift
//  CoronaTracker
//
//  Created by Roushil singla on 4/12/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var coronaCasesTableView: UITableView!
    var coronaCases: [History]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData(){
        
        Service.getJSONData { (success) in
            if success{
                
                self.coronaCases = DataViewModel.shared.history?.reversed()
                DispatchQueue.main.async {
                    self.coronaCasesTableView.register(UINib(nibName: "CoronaDataCell", bundle: nil), forCellReuseIdentifier: "CoronaDataCell")
                    self.coronaCasesTableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coronaCases?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coronaCasesTableView.dequeueReusableCell(withIdentifier: "CoronaDataCell", for: indexPath) as! CoronaDataCell
        let coronaCase = coronaCases![indexPath.row]
        cell.configureTotalCases(cases: coronaCase)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let coronaCase = coronaCases![indexPath.row]
        let vc = self.storyboard?.instantiateViewController(identifier: "StateViewController") as! StateViewController
        vc.date = coronaCase.day
        vc.states = coronaCase.statewise
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 232
    }
}
