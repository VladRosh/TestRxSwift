//
//  APIManager.swift
//  TestRxSwift
//
//  Created by VLAD on 22/11/2017.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class APIManager {
    
    static let sharedManager = APIManager()
    
    let disposeBag = DisposeBag()
    var ticks = [Ticker]()

    func getTickers(command: String, completionWithData:@escaping (_ result: [Ticker])->(),completionWithError: @escaping (_ error: Error)->()) {
        guard !command.isEmpty,
        let url = URL(string: "https://poloniex.com/public?command=\(command)") else { return }
        
        var tickers =  [Ticker]()
        
        RxAlamofire.requestJSON(.get, url)
            .debug()
            .subscribe(onNext:
                { (any, json) in
                    
                    if let dict = json as? [String: AnyObject] {
                        let keys = dict.map({ $0.key })
                        keys.forEach({ (str) in
                            let valDict = dict[str] as! Dictionary<String, AnyObject>
                            
                            let ticker = str
                            let last = valDict["last"] as! String
                            let highestBid =  valDict["highestBid"] as! String
                            let percentChange = valDict["percentChange"] as! String
                            
                            tickers.append(Ticker(ticker: ticker, last: last, highestBid: highestBid, percentChange: percentChange))
                        })
                    }
                    completionWithData(tickers)  
            }, onError: {  (error) in
                print("error \(error)")
            })
            .disposed(by: disposeBag)
    }
}
