//
//  EmployeeDetailViewController.swift
//  WageCalculator
//
//  Created by Hana  Demas on 3/16/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    
    //MARK: Properties
    var subView: EmployeeDetailView!
    //appdelegate singlton instance to use a global variable
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: Viewcontroller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.subView = EmployeeDetailView(frame: self.view.frame)
        //setup the view with selected employee info
        if let name = appDelegate.selectedEmployee?.name {
            subView.name =  name
        }
        if let  salary = appDelegate.selectedEmployee?.monthlyWage {
            subView.monthlyWage =  "Monthly Wage: $\(salary)"
        }
        if let  eveningCompensation = appDelegate.selectedEmployee?.monthlyEveningCompensation{
            subView.eveningCompensation =  "Monthly Evening Compensation: $\(eveningCompensation)"
        }
        if let  overtimeCompensation = appDelegate.selectedEmployee?.monthlyOvertimeCompensation {
            subView.overtimeCompensation =  "Monthly Overtime Compensation: $\(overtimeCompensation)"
        }
        //add the subview to main view
        self.view.addSubview(subView)
    }
    
    //redraw View when screen rottates
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.subView.frame  = self.view.frame
    }
}
