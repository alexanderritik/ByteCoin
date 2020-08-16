//
//  CoinData.swift
//  ByteCoin
//
//  Created by Ritik Srivastava on 22/07/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData : Decodable {
    let rate:Double
    let asset_id_quote:String
}
