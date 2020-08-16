//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Ritik Srivastava on 22/07/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let coinString:Double
    let currency:String
    
    var coin : String {
        return String(format: "%0.1f", coinString)
    }

}
