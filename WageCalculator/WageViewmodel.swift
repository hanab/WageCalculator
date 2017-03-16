//
//  WageViewmodel.swift
//  WageCalculator
//
//  Created by Hana  Demas on 3/15/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation

// custom type used for dailywage, dailycompensation and overttimedaily
typealias WageAndComponetns = (Double, Double, Double)
//class for calculatiing wage for every employee
class WageViewModel {
    
    //MARK: Properties
    var employeeViewModel = EmployeesViewModel()
    var hourlyWage: Double = 3.75
    var hourlyEveningcompensation:Double = 1.15
    
    //MARK: Functions
    //functoion to calculate daily wage
    func calculateDailyWage(workHour: WorkHour) ->WageAndComponetns{
        
        var totalDailyWage: Double = 0.0
        var overTimeDiuration = 0.0
        var normalDuration = 0.0
        var eveningDuration = 0.0
        var wk = workHour
        
        for shift in wk.shift{
            //get double hours from DATE type
            let start: Double = shift.startTime.doubleHours()
            let end: Double = shift.endTime.doubleHours()
            //get the normal working hours per shift
            var normalDurationPerShift = 0.0
            if (start < end) {
                normalDurationPerShift += (end - start)
            } else {
                normalDurationPerShift += (24 - start + end)
            }
           //get evening hours per shift
            var eveninghoursePerShift = 0.0
            if(start >= 18 || start < 6){
                eveninghoursePerShift += normalDurationPerShift
            } else if(start < 18  && (end > 18 || end < 6)){
                eveninghoursePerShift += (normalDurationPerShift - (18 - start))
            }
            //add to working hours total of the day
            normalDuration += normalDurationPerShift
            eveningDuration += eveninghoursePerShift
        }
        //check for overt time
        if(normalDuration > 8) {
            overTimeDiuration += (normalDuration - 8)
        }
        //calculate overtime compensation
        var overTimeComponsation = 0.0
        if(overTimeDiuration <= 2) {
            overTimeComponsation = 0.25 * hourlyWage * overTimeDiuration
        } else if(2 < overTimeDiuration && overTimeDiuration <= 4) {
            overTimeComponsation = 0.5 * hourlyWage * (overTimeDiuration - 2) + 0.25 * hourlyWage * 2
        }else {
            overTimeComponsation = hourlyWage * (overTimeDiuration-4) + 0.5 * hourlyWage * 2 + 0.25 * hourlyWage * 2
        }
        //calculate daily normal wage and evening compensation
        let normalDailyWage = normalDuration * hourlyWage
        let nightDailyCompnsation = eveningDuration * hourlyEveningcompensation
        totalDailyWage += (normalDailyWage + nightDailyCompnsation + overTimeComponsation)
        
        return (round(totalDailyWage * 100)/100, round(nightDailyCompnsation * 100)/100, round(overTimeComponsation * 100)/100)
    }
    
    //function to calculate montly wage
    func calculateMonthlyWage(workhours: [WorkHour]) ->WageAndComponetns  {
        var monthlyWage = 0.0
        var monthlyEveningCompensation = 0.0
        var monthlyOverTimeCompensation = 0.0
        for workHour in workhours {
            let dailyWage = self.calculateDailyWage(workHour: workHour)
            monthlyWage += dailyWage.0
            monthlyEveningCompensation += dailyWage.1
            monthlyOverTimeCompensation += dailyWage.2
        }
        return (monthlyWage, monthlyEveningCompensation, monthlyOverTimeCompensation)
    }
    
    //set the wage of every employee
    func calcuateWageForEmployees() -> [Employee]{
        employeeViewModel.getEmployeeObjectsFromCSV(file: "HourList201403", delimiter: ",")
        
        for i in 0...self.employeeViewModel.employess.count-1 {
            let wage = self.calculateMonthlyWage(workhours: self.employeeViewModel.employess[i].workHours)
                self.employeeViewModel.employess[i].setWage(wage: wage.0)
                self.employeeViewModel.employess[i].setEveningCompensation(compensation: wage.1)
                self.employeeViewModel.employess[i].setOvertimeCompensation(compensation: wage.2)
        }
        return self.employeeViewModel.employess
    }
}
