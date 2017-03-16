//
//  Employee.swift
//  WageCalculator
//
//  Created by Hana  Demas on 3/12/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation

struct Employee {
    
    //MARK: Properties
    var id: Int
    var name: String
    lazy var workHours:[WorkHour] = [WorkHour]()
    lazy var monthlyWage:Double = 0.0
    //these are unnessary components , but i just added them to make it easier for display
    lazy var monthlyEveningCompensation = 0.0
    lazy var monthlyOvertimeCompensation = 0.0
    
    //MARK: Init
    init(id:Int, name:String) {
        self.id = id
        self.name = name
    }
    
    //MARK: Setter methods
    public mutating func addWorkHour(workHour:WorkHour) {
      workHours.append(workHour)
    }
    public mutating func setWage(wage: Double) {
        self.monthlyWage = wage
    }
    public mutating func setEveningCompensation(compensation: Double) {
        self.monthlyEveningCompensation = compensation
    }
    public mutating func setOvertimeCompensation(compensation: Double) {
        self.monthlyOvertimeCompensation = compensation
    }
}

//Shift object
struct Shift {
    var startTime:Date
    var endTime: Date
}

//Workhour object for one day
struct WorkHour {
    
    //MARK: Properties
    var date: Date
    lazy var shift:[Shift] = [Shift]()
    
    //MARK: Init
    init(date: Date) {
        self.date = date
        self.shift = shift
    }
    //MARK: setters
    public mutating func addShift(shift:Shift){
        self.shift.append(shift)
    }
}
