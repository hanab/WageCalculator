//
//  WageCalculatorTests.swift
//  WageCalculatorTests
//
//  Created by Hana  Demas on 3/12/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import WageCalculator

class WageCalculatorTests: XCTestCase {
    //objects to be used in test
    var employeeModel = EmployeesViewModel()
    var wageViewModel = WageViewModel()
    
    //MARK: Functions
    override func setUp() {
        super.setUp()
        employeeModel.getEmployeeObjectsFromCSV(file: "HourList201403", delimiter: ",")
    }
    
    func testDataParsing(){
        let numberOfRowsInCSV = employeeModel.rowsReadFromCSV
        XCTAssert(numberOfRowsInCSV == 69, "more or less than data than expected \(numberOfRowsInCSV)")
    }
    
    func testDataParsingToEmployeeObjects(){
        let numberOfEmployees = employeeModel.employess.count
        XCTAssert(numberOfEmployees == 3, "more or less Employees than expected \(numberOfEmployees)")
        var employeeShiftsCount:Int = 0
        for var emp in employeeModel.employess {
            for var workHors in emp.workHours {
                for _ in workHors.shift {
                  employeeShiftsCount += 1
                }
            }
        }
        XCTAssert(employeeShiftsCount == 67, "Erorr creating object from file \(employeeShiftsCount)")
        XCTAssert(employeeModel.employess[0].name == "Scott Scala")
        XCTAssert(employeeModel.employess[1].name == "Janet Java")
        XCTAssert(employeeModel.employess[2].name == "Larry Lolcode")
    }
    
    func testWageCalculation() {
        let scottScalaDailyWage2March:Double = wageViewModel.calculateDailyWage(workHour: employeeModel.employess[0].workHours[0]).0
        XCTAssert(scottScalaDailyWage2March == 30, "Daily wage calculation Error \(scottScalaDailyWage2March)")
        let janetJavaDailyWage6March =  wageViewModel.calculateDailyWage(workHour: employeeModel.employess[1].workHours[3])
        XCTAssert(janetJavaDailyWage6March.2 == 1.875, "Daily wage calculation Error \(janetJavaDailyWage6March.2 )")
        XCTAssert(janetJavaDailyWage6March.1 == 4.6, "Daily wage calculation Error \(janetJavaDailyWage6March.1 )")
        XCTAssert(janetJavaDailyWage6March.0 == 43.98, "Daily wage calculation Error \(janetJavaDailyWage6March.0 )")
    }
}
