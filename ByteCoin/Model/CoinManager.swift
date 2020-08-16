//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didCurrencyUpdate(_ data: CoinModel)
    func didCurrencyFail(_ error : Error)
}

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "F76481C5-4064-4AFC-ABDF-19C24F80B422"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func performRequest(for urlString:String){
        let url = "\(baseURL)/\(urlString)/?apikey=\(apiKey)"
//        print(url)
        
                if let url = URL(string: url) {
                
                // 2 . Create a URL session
                    let session=URLSession(configuration: .default)
                 
                // 3 . Give the session a task
                    let task = session.dataTask(with: url) {(data , response,error) in
                        if error != nil {
                            self.delegate?.didCurrencyFail(error!)
                            //print(error!)
                            return
                        }
                        if let safeData = data {
                            if let data = self.parseJson(currencyData: safeData)
                            {
                                self.delegate?.didCurrencyUpdate(data)
//                                print(data)
                            }
                        }
                        
                    }

                    
                    task.resume()
                }
        
    }
    
    func parseJson(currencyData : Data) -> CoinModel? {
            let decode = JSONDecoder()
        do {
            let money = try decode.decode(CoinData.self , from: currencyData)
            let coinModel = CoinModel(coinString: money.rate , currency: money.asset_id_quote)
            return coinModel
        } catch {
            print(error)
            self.delegate?.didCurrencyFail(error)
            return nil
        }
    }
    
}
