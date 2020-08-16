//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate {

    var coinManager=CoinManager()
    
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource=self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
        // Do any additional setup after loading the view.
    }


}


extension ViewController:UIPickerViewDataSource {
     
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.performRequest(for : coinManager.currencyArray[row])
    }
}


extension ViewController: CoinManagerDelegate {
    func didCurrencyUpdate(_ data: CoinModel) {
        
        DispatchQueue.main.async {
            self.bitcoinLabel.text=data.coin
            self.currencyLabel.text=data.currency
            
        }
        
    }
    
    func didCurrencyFail(_ error: Error) {
        print("Error in the Connection ")
    }
    
    
}
