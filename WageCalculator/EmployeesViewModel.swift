//
//  EmployeesViewModel.swift
//  WageCalculator
//
//  Created by Hana  Demas on 3/14/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//
import Foundation

//class for getting employee objects from .CSV file
class EmployeesViewModel {
    
    //MARK: Properties
    var employess:[Employee] = []
    //only to be used in the unit test file to check if the number of rows read from CSV are as expected
    public  var rowsReadFromCSV:Int = 0
    
    //MARK: Functions
    
    //Function to read the CSV File
    private func readDataFromFile(file:String)-> String!{
        guard let filepath = Bundle.main.path(forResource: file, ofType: "csv") else {
                return nil
        }
        do {
            let contents = try String(contentsOfFile: filepath, encoding: .utf8)
            return contents
        } catch {
            print ("File Read Error")
            return nil
        }
    }
    
    //Function to clean up rows to contain newline character only as a separeter
    private func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    
    //Function to Construct Employees array from CSV
    public func getEmployeeObjectsFromCSV(file:String, delimiter:String){
        //date formates for hours and date
        let dateFormat = "dd.MM.yyyy"
        let hoursFormat = "HH:mm"
        //variable for getting first row of csv(titles of columns)
        var columnTitles:[String] = []
        var idExists:[Int] = []
        var dateExistsDic:[Int:[Date]] = [Int:[Date]]()
        //read file and clean it
        guard let fileToParse = readDataFromFile(file: file) else {
            return
        }
        let rows = cleanRows(file: fileToParse).components(separatedBy: "\n")
        
        if rows.count > 0 {
            guard let firstRow = rows.first else {
                return
            }
            columnTitles = firstRow.components(separatedBy: delimiter)
            //to check if all line has been read
            self.rowsReadFromCSV = rows.count
            
            for row in rows{
                let fields = row.components(separatedBy: ",")
                if fields.count != columnTitles.count {continue}
                guard let id = Int(fields[1]) else {
                    continue
                }
                let name = fields[0]
                let date = fields[2]
                let start = fields[3]
                let end =  fields[4]
                //consrtuct date objects from Strings
                guard let dateDay = date.toDateString(inputFormat: dateFormat) else {
                    continue
                }
                guard  let startTime = start.toDateString(inputFormat: hoursFormat) else {
                    continue
                }
                guard let endTime = end.toDateString(inputFormat:hoursFormat) else {
                    continue
                }
                
                let shift = Shift(startTime: startTime, endTime: endTime)
                var  workHour = WorkHour(date: dateDay)
                var employee = Employee(id: id, name: name)
                //check if id already exists and append workours to it if it exists(asuming the person with the id has the same name always)
                if idExists.contains(id) {
                    for i in 0...employess.count - 1 {
                        if employess[i].id == id {
                            // if a date already exists append to shifts in that day
                            if (dateExistsDic.keys.contains(id) && dateExistsDic[id]!.contains(dateDay)){
                                for j in 0...employess[i].workHours.count - 1{
                                    if employess[i].workHours[j].date == dateDay {
                                        employess[i].workHours[j].addShift(shift: shift)
                                    }
                                }
                            } else {
                                workHour.addShift(shift: shift)
                                employess[i].addWorkHour(workHour: workHour)
                                dateExistsDic[id]?.append(dateDay)
                            }
                        }
                    }
                } else {
                    workHour.addShift(shift: shift)
                    employee.addWorkHour(workHour: workHour)
                    employess.append(employee)
                    idExists.append(id)
                    dateExistsDic[id] = [dateDay]
                }
            }
        } else {
            print("No data in file")
        }
    }
}
