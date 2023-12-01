//
//  UserDefaultsManager.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 17/08/2021.
//

import UIKit

class UserDefaultsManager
{
    //----------------------------------------------------------------------------------
    //MARK:- SectionName
    //----------------------------------------------------------------------------------
    
    static func storePersonsDataInUserDefaults(persons: [PersonsModel])
    {
        do
        {
            let personsData = try JSONEncoder().encode(persons)
            UserDefaults.standard.set(personsData, forKey: UserDefaultKeys.PERSONS_LIST_KEY)
        }
        catch
        {
            print(error)
        }
    }
    
    //----------------------------------------------------------------------------------
    //MARK:- SectionName
    //----------------------------------------------------------------------------------
    
    static func retrievePersonsDataFromUserDefaults() -> [PersonsModel]?
    {
        do
        {
            if UserDefaults.standard.data(forKey: UserDefaultKeys.PERSONS_LIST_KEY) == nil
            {
                UserDefaultsManager.storePersonsDataInUserDefaults(persons: [PersonsModel]())
            }
            
            let personsData = UserDefaults.standard.data(forKey: UserDefaultKeys.PERSONS_LIST_KEY)!
            
            let persons = try JSONDecoder().decode([PersonsModel].self, from: personsData)
            return persons
        }
        catch
        {
            print(error)
        }
        
        return nil
    }
    
    //----------------------------------------------------------------------------------
    //MARK:- SectionName
    //----------------------------------------------------------------------------------
    
    static func addNewPersonsInList(person: PersonsModel) -> Bool
    {
        guard var personsList = retrievePersonsDataFromUserDefaults()
        else { return false }
        
        personsList.append(person)
        storePersonsDataInUserDefaults(persons: personsList)
        return true
    }
    
    //----------------------------------------------------------------------------------
    //MARK:- SectionName
    //----------------------------------------------------------------------------------
    
    static func clearPersonsInList()
    {
        UserDefaultsManager.storePersonsDataInUserDefaults(persons: [PersonsModel]())
    }
}
