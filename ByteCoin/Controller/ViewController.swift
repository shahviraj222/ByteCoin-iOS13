//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var bitcoinLable: UILabel!
    
    @IBOutlet weak var currencyLable: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
       
    }


}

extension ViewController: UIPickerViewDelegate {

    
    //    this method for setting the title
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return coinManager.currencyArray[row]
        }
        
        //        here the "row" update automaticlly
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedRow = coinManager.currencyArray[row]
            currencyLable.text = selectedRow
            coinManager.getCoinPrice(for: selectedRow )
        }
    
}

extension ViewController: UIPickerViewDataSource {
    
//    this method for saying how many colum you have
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        number of columns we want
        return 1
    }
    
//    this method for saying how many rows you have.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        number of rows we have
        return coinManager.currencyArray.count
    }
    
}

extension ViewController: CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: Double) {
        bitcoinLable.text = String(format:"%.2f",coin)
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
}
