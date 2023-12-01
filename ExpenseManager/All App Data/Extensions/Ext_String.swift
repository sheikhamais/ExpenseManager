//
//  Ext_String.swift
//  ExpenseManager
//
//  Created by Amais Sheikh on 15/08/2021.
//

import UIKit

extension String
{
    //String Extension Variables
    
    // Return Empty, Non-Empty Status
    var isNotEmpty: Bool
    {
        return !self.isEmpty
    }
 
    // Remove white spaces and new Line
    var trim: String
    {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // checks if the current string has only numbers in it
    var isDigitsOnly : Bool
    {
        let charSet = CharacterSet(charactersIn: self)
        return charSet.isSubset(of: CharacterSet.decimalDigits)
    }
    
    // checks if the current string has only alphabets
    var isAlphabetsOnly : Bool
    {
        let charSet = CharacterSet(charactersIn: self)
        return charSet.isSubset(of: CharacterSet.letters)
    }
    
    // checks if the current string has at least 8 characters
    var isAtLeastEightCharacters : Bool
    {
        if self.count >= 8
        { return true } else { return false }
    }
    
    // checks if the current string has at least 7 characters
    var isAtLeastSevenCharacters : Bool
    {
        if self.count >= 7
        { return true } else { return false }
    }
    
    //makes and stores attributed string of the current string
    var asAttributedString: NSAttributedString?
    {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
    
    //verify that the string has at least a space
    var hasSpace: Bool
    {
        var hasSpace = false
        for char in self
        {
            if char == " "
            { hasSpace = true }
        }
        return hasSpace
    }
    
    var cgFloatValue: CGFloat?
    {
        guard let num = NumberFormatter().number(from: self)
        else
        {
            return nil
        }
        
        return CGFloat(truncating: num)
    }
    
    //checks white space
    var hasWhitespace: Bool
    {
        if self.rangeOfCharacter(from: .whitespaces) != nil
        { return true }
        else
        { return false }
    }
    
    //checks for an uppercase letter
    var hasAnUppercaseCharacter: Bool
    {
        if self.rangeOfCharacter(from: .uppercaseLetters) != nil
        { return true }
        else
        { return false }
    }
    
    //checks for an lowercase letter
    var hasALowercaseCharacter: Bool
    {
        if self.rangeOfCharacter(from: .lowercaseLetters) != nil
        { return true }
        else
        { return false }
    }
    
    //checks for a digit
    var hasADigit: Bool
    {
        if self.rangeOfCharacter(from: .decimalDigits) != nil
        { return true }
        else
        { return false }
    }
    
    //get attributed string from html text
    var htmlToAttributedString: NSAttributedString?
    {
        guard let data = data(using: .utf8)
        else { return nil }
        
        do
        {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        }
        catch
        { return nil }
    }
    
    //String Extension Functions
    func strikeThrough() -> NSMutableAttributedString
    {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(
        NSAttributedString.Key.strikethroughStyle,
        value: 1,
        range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }
    
    func isValidPakistaniNumberStart() -> Bool
    {
        var firstDigit: Int?
        var secondDigit: Int?
        var thirdDigit: Int?
        
        if let dig1 = self.first, let dig2 = self.dropFirst().first, let dig3 = self.dropFirst().dropFirst().first
        {
            firstDigit      = Int(String(dig1))
            secondDigit     = Int(String(dig2))
            thirdDigit      = Int(String(dig3))
        }
        
        guard firstDigit != nil, secondDigit != nil, thirdDigit != nil else { return false }
        
        if firstDigit! != 9 || secondDigit! != 2 || thirdDigit! != 3
        { return false }
        
        return true
    }
}
