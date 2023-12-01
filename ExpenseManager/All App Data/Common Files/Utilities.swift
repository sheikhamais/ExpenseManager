//
//  Utilities.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

class Utilities
{
    //------------------------------------------------------------
    //MARK:- setAsWindowRoot
    //------------------------------------------------------------
    
    static func setAsWindowRoot(viewControllerInsideNavigationController vc: UIViewController)
    {
        let rootNavigationController = UINavigationController(rootViewController: vc)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        let window = sceneDelegate.window
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
    
    //----------------------------------------------------------------------------------
    //MARK:- SectionName
    //----------------------------------------------------------------------------------

    static func printPersons(persons: [PersonsModel])
    {
        for person in persons
        {
            print("Person => Name: \(person.name) Balance: \(person.outstandingAmount)")
        }
    }
//
//    //----------------------------------------------------------------------------------
//    //MARK:- SectionName
//    //----------------------------------------------------------------------------------
//
//    static func storePersonsDataInUserDefaults(persons: [PersonsModel])
//    {
//        do
//        {
//            let personsData = try JSONEncoder().encode(persons)
//            UserDefaults.standard.set(personsData, forKey: UserDefaultKeys.PERSONS_LIST_KEY)
//        }
//        catch
//        {
//            print(error)
//        }
//    }
//
//    //----------------------------------------------------------------------------------
//    //MARK:- SectionName
//    //----------------------------------------------------------------------------------
//
//    static func retrievePersonsDataFromUserDefaults() -> [PersonsModel]?
//    {
//        do
//        {
//            if UserDefaults.standard.data(forKey: UserDefaultKeys.PERSONS_LIST_KEY) == nil
//            {
//                Utilities.storePersonsDataInUserDefaults(persons: [PersonsModel]())
//            }
//
//            let personsData = UserDefaults.standard.data(forKey: UserDefaultKeys.PERSONS_LIST_KEY)!
//
//            let persons = try JSONDecoder().decode([PersonsModel].self, from: personsData)
//            return persons
//        }
//        catch
//        {
//            print(error)
//        }
//
//        return nil
//    }
//
//    //----------------------------------------------------------------------------------
//    //MARK:- SectionName
//    //----------------------------------------------------------------------------------
//
//    static func addNewPersonsInList(person: PersonsModel) -> Bool
//    {
//        guard var personsList = retrievePersonsDataFromUserDefaults()
//        else { return false }
//
//        personsList.append(person)
//        storePersonsDataInUserDefaults(persons: personsList)
//        return true
//    }
}
