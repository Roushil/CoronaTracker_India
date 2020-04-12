//
//  JsonViewModel.swift
//  CoronaTracker
//
//  Created by Roushil singla on 4/12/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation
import UIKit

class DataViewModel: NSObject{
    
    static var shared = DataViewModel()
    
    var history: [History]?
}
