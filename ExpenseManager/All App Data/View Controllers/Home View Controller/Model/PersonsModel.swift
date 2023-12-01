//
//  PersonsModel.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//
    
import UIKit

class PersonsModel: Codable
{
    var name: String
    var outstandingAmount: String
    
    init(name: String, outstandingAmount: String)
    {
        self.name = name
        self.outstandingAmount = outstandingAmount
    }
    
    static func createMockData() -> [PersonsModel]
    {
        let totalRecords = 4
        var personsArr = [PersonsModel]()
        
        for i in 0...totalRecords - 1
        {
            var name: String = ""
            
            if i == 0
            { name = "Akhtar" }
            else if i == 1
            { name = "Shamail" }
            else if i == 2
            { name = "Naz" }
            else
            { name = "Some" }
            
            let person = PersonsModel(name: name, outstandingAmount: "100")
            personsArr.append(person)
        }
        
        return personsArr
    }
}
