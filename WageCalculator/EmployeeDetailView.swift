//
//  EmployeeDetailView.swift
//  WageCalculator
//
//  Created by Hana  Demas on 3/16/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class EmployeeDetailView: UIView {
    
    // MARK: subviews
    private lazy var leftView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private lazy var rightView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.italicSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var profilePic: UIImageView = {
        let profilePic = UIImageView(image: UIImage(named: "profilePic.png"))
        return profilePic
    }()
    
    private lazy var monthlyWageLabel: UILabel = {
        let salaryLabel = UILabel()
        salaryLabel.numberOfLines = 1
        salaryLabel.text = "Monthly Wage: "
        salaryLabel.font = UIFont.italicSystemFont(ofSize: 12)
        return salaryLabel
    }()
    
    private lazy var eveningCompensationLabel: UILabel = {
        let eveningLabel = UILabel()
        eveningLabel.numberOfLines = 3
        eveningLabel.text = "Monthly Evening Compensation: "
        eveningLabel.font = UIFont.italicSystemFont(ofSize: 12)
        return eveningLabel
    }()
    
    private lazy var overtimeCompensationLabel: UILabel = {
        let overtimeLabel = UILabel()
        overtimeLabel.numberOfLines = 3
        overtimeLabel.text = "Monthly Overtime Compensation: "
        overtimeLabel.font = UIFont.italicSystemFont(ofSize: 12)
        return overtimeLabel
    }()
    
    //MARK: Properties
    var name: String? {
        didSet {
            self.nameLabel.text = name
        }
    }
    var monthlyWage: String? {
        didSet {
            self.monthlyWageLabel.text = monthlyWage
        }
    }
    var eveningCompensation: String? {
        didSet {
            self.eveningCompensationLabel.text = eveningCompensation
        }
    }
    var overtimeCompensation: String? {
        didSet {
            self.overtimeCompensationLabel.text = overtimeCompensation
        }
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        //add subviews
        self.addSubview(leftView)
        self.addSubview(rightView)
        leftView.addSubview(profilePic)
        leftView.addSubview(nameLabel)
        rightView.addSubview(monthlyWageLabel)
        rightView.addSubview(eveningCompensationLabel)
        rightView.addSubview(overtimeCompensationLabel)
        //add constraints
        addConstraintToContainerSubViews()
        addConstraintsToLeftView()
        addConstraintsToRightView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: custom methods to add constraints to views
    func addConstraintToContainerSubViews() {
        leftView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(80)
            make.left.equalTo(0)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        rightView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(80)
            make.right.equalTo(-20)
            make.width.equalTo(self.snp.width).multipliedBy(0.67)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
    }
    
    func addConstraintsToLeftView() {
        profilePic.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(leftView.snp.top)
            make.centerX.equalTo(leftView.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(leftView.snp.centerX)
            make.top.equalTo(profilePic.snp.bottom).offset(20)
        }
    }
    
    func addConstraintsToRightView() {
        monthlyWageLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(rightView.snp.left).offset(20)
        }
        eveningCompensationLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(monthlyWageLabel.snp.bottom).offset(20)
            make.left.equalTo(rightView.snp.left).offset(20)
        }
        overtimeCompensationLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(eveningCompensationLabel.snp.bottom).offset(20)
            make.left.equalTo(rightView.snp.left).offset(20)
        }
    }
}
