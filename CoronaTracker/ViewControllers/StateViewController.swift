//
//  StateViewController.swift
//  CoronaTracker
//
//  Created by Roushil singla on 4/12/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class StateViewController: UIViewController {

    @IBOutlet weak var stateWiseTableView: UITableView!
    
    var states: [State]?
    
    var date: String?{
        didSet{
            self.navigationItem.title = date
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        stateWiseTableView.register(UINib(nibName: "StateTableViewCell", bundle: nil), forCellReuseIdentifier: "StateTableViewCell")
        stateWiseTableView.reloadData()
    }
}

extension StateViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = stateWiseTableView.dequeueReusableCell(withIdentifier: "StateTableViewCell", for: indexPath) as! StateTableViewCell
        let state = states![indexPath.row]
        cell.configureStateCases(state: state)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let state = states![indexPath.row]
        let mapVC = self.storyboard?.instantiateViewController(identifier: "StateMapViewController") as! StateMapViewController
        mapVC.state = state
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
