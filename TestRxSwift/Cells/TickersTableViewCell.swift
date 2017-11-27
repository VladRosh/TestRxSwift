//
//  TickersTableViewCell.swift
//  TestRxSwift
//
//  Created by VLAD on 22/11/2017.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit

class TickersTableViewCell: UITableViewCell {
    
    var tickerNameLabel: UILabel!
    var lastLabel: UILabel!
    var highestBidLabel: UILabel!
    var percentChangeLabel: UILabel!
    
    var view: UIView!
    
    var myWidth: CGFloat!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let x = 10
        let width = Int(self.contentView.frame.width - 30)
        let height = 25

        tickerNameLabel = UILabel(frame: CGRect(x: x, y: 10, width: width, height: height))
        lastLabel = UILabel(frame: CGRect(x: x, y: Int(2 * height), width: width, height: height))
        highestBidLabel = UILabel(frame: CGRect(x: x, y: Int(3 * height), width: width, height: height))
        percentChangeLabel = UILabel(frame: CGRect(x: x, y: Int(4 * height), width: width, height: height))
        
        tickerNameLabel.font = UIFont(name: ".SFUIText-Medium", size: 17)
        tickerNameLabel.textColor = .white
        lastLabel.font = UIFont(name: ".SFUIText-Medium", size: 14)
        highestBidLabel.font = UIFont(name: ".SFUIText-Medium", size: 14)
        percentChangeLabel.font = UIFont(name: ".SFUIText-Medium", size: 14)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        view = UIView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: 45))
        view.backgroundColor = .lightGray
        view.roundCorners(corners: .bottomRight, radius: 15)
        
        self.view.addSubview(tickerNameLabel)
        self.contentView.addSubview(view)
        self.contentView.addSubview(lastLabel)
        self.contentView.addSubview(highestBidLabel)
        self.contentView.addSubview(percentChangeLabel)
    }
    
    // MARK: Methods
    func configureCellWithModel(tickerModel : Ticker) {
        tickerNameLabel.text = "Ticker name:  \(tickerModel.ticker)"
        lastLabel.text = "Last:  \(tickerModel.last)"
        highestBidLabel.text = "HighestBid:  \(tickerModel.highestBid)"
        percentChangeLabel.text = "PercentChange:  \(tickerModel.percentChange)"
    }
}
