//
//  ViewController.swift
//  WageCalculator
//
//  Created by Hana  Demas on 3/12/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit
import Foundation

class EmployeesViewController: UITableViewController {
    
    //MARK: Properties
    fileprivate let cellIdentifer = "Cell"
    fileprivate let wageModel = WageViewModel()
    var employees:[Employee] = [Employee]()
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let dateFormatter = "MM/yyyy"
    
    //MARK: Viewcontoller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //get employees wage and sort them by id
        employees = wageModel.calcuateWageForEmployees()
        employees.sort {$0.id < $1.id}
        //tableview properties
        self.registerCellsForTableView(tableView: tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor(red: 31/255, green: 148/255, blue: 206/255, alpha: 1.0)
        self.title = "Employess"
    }
}

//TableView Datasource and delegate methods
extension EmployeesViewController {
    
    //MARK: Datasource
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        if (indexPath.row == 0) {
            if let wageMonth = self.employees[0].workHours[0].date.stringFromDate(inputFormat: dateFormatter){
                cell.textLabel?.text = "Monthly Wages " + wageMonth
            }
            cell.backgroundColor = UIColor.brown
            cell.textLabel?.textAlignment = .center
        }else {
            var employee = self.employees[indexPath.row - 1]
            cell.textLabel?.text = "\(employee.id)" + ", " + employee.name + ",   $ \(employee.monthlyWage)"
        }
        return cell
    }
    
    //MARK: Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.selectedEmployee = self.employees[indexPath.row - 1]
        let secondViewController:EmployeeDetailViewController = EmployeeDetailViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
}


