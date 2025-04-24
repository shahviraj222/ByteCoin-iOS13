//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdateCoin(_ coinManager:CoinManager, coin:Double)
    func didFailWithError(error:Error)
}
struct CoinManager {
    
    let baseURL = "https://api-realtime.exrates.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "ab73a321-d8d6-40d5-b0a0-59531857c32f"
    var delegate:CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency:String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlstring:String){
        if let url = URL(string:urlstring){
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: url, completionHandler: {data,response,error in
              
                if error != nil{
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safedata = data{
//                    step1 stringfying
//                    let dataString = String(data:safedata , encoding: .utf8)
//                    print(dataString!)
                    
                    if let data = parseJSON(safedata){
                        print(data)
                        self.delegate?.didUpdateCoin(self,coin:data)
                    }
                    
                }
            }
            )
            dataTask.resume()
        }
    }
    
    func parseJSON(_ coinData:Data)->Double?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let lastprice = decodedData.rate
            return lastprice
        }catch{
            return nil
        }
    }
    
}
