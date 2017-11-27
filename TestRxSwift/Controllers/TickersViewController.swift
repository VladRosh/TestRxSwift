//
//  TickersViewController.swift
//  TestRxSwift
//
//  Created by VLAD on 22/11/2017.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TickersViewController: UIViewController {
    
    var tableView = UITableView()
    var tickers = [Ticker]()
    var isRunning = Variable(true)
    let disposeBag = DisposeBag()
    let commandStringURL  = "returnTicker"
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
     
        apiRequest()
        setupTableView()
        timerLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = "Stock tickers"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupTableView()
    }

    // MARK: Methods
    func setupTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(TickersTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
    }

    func timerLoading() {
        isRunning.asObservable()
            .debug("isRunning")
            .flatMapLatest {  isRunning in
                isRunning ? Observable<Int>.interval(5, scheduler: MainScheduler.instance) : .empty()
            }
            .enumerated().flatMap { (int, index) in Observable.just(index) }
            .debug("timer")
            .subscribe({_ in
                self.apiRequest()
            })
            .disposed(by: disposeBag)
    }
    
    func apiRequest() {
        APIManager.sharedManager.getTickers(command: commandStringURL,
                                            completionWithData: { (tickers) in
                                                
                                            self.tickers = tickers
                                            self.reloadTableView(tableView: self.tableView)
        }) { (error) in
            print("error \(error.localizedDescription)")
        }
    }
    
    func reloadTableView(tableView: UITableView) {
        UIView.transition(with: tableView,
                          duration: 0.20,
                          options: .transitionCrossDissolve,
                          animations: {
                            tableView.beginUpdates()
                            tableView.deleteSections(IndexSet(integer: 0), with: .automatic)
                            tableView.insertSections(IndexSet(integer: 0), with: .automatic)
                            tableView.endUpdates()
        })
    }
}

extension TickersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tickers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TickersTableViewCell
        cell.configureCellWithModel(tickerModel: tickers[indexPath.row])
        
        return cell
    }
}

extension TickersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 135
    }
}
