//
//  WeatherController.swift
//  ToDoList
//
//  Created by Serhii on 20.01.2022.
//

import Foundation

class WeatherController {
   
   func findIndexElement(string: String, elem: Character) -> Int {
      if let i = string.firstIndex(of: elem) {
        return i.utf16Offset(in:string)
      } else {
         return 00
      }
   }
   
   func formatDate(date: String) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "YY-MM-dd"
      if let newDate = dateFormatter.date(from: date) {
         let newDateToString: String = "\(newDate)"
         let startIndex = date.index(date.startIndex, offsetBy: 5)
         let endIndex = date.index(date.startIndex, offsetBy: 10)
         return String(newDateToString[startIndex..<endIndex])
                  .replacingOccurrences(of: "-", with: ".")
      } else {
         return ""
      }
   }
   
   func formatDateForHours(date: String) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
      dateFormatter.timeZone = TimeZone.current
      
      if let newDate = dateFormatter.date(from: date) {
         let newDateToString: String = "\(newDate)"
         let startIndex = date.index(date.startIndex, offsetBy: 10)
         let endIndex = date.index(date.startIndex, offsetBy: 13)
         return String(newDateToString[startIndex..<endIndex])
      } else {
         return "Now"
      }
   }
   
   func formatMinAndMaxTemp(temp: String) -> String {
      if findIndexElement(string: temp, elem: ".") == 00 {
         return NSString(format: temp + "%@" as NSString, "\u{00B0}") as String
      } else {
         let startIndex = temp.index(temp.startIndex, offsetBy: 0)
         let Index = findIndexElement(string: temp, elem: ".")
         let endIndex = temp.index(temp.startIndex, offsetBy: Index)
         let newTemp = temp[startIndex..<endIndex]
         return NSString(format: newTemp + "%@" as NSString, "\u{00B0}") as String
      }
   }
   
   func formatValueForPrecip(value: String) -> String {
      if value.count == 1 {
         let startIndex = value.index(value.startIndex, offsetBy: 0)
         let newValue = value[startIndex]
         return String(newValue) + " mm"
      } else {
         let startIndex = value.index(value.startIndex, offsetBy: 0)
         let Index = findIndexElement(string: value, elem: ".") + 2
         let endIndex = value.index(value.startIndex, offsetBy: Index)
         let newValue = value[startIndex..<endIndex]
         return String(newValue + " mm")
      }
   }
   
   func formateValueForFeelsLike(value: String) -> String {
      let startIndex = value.index(value.startIndex, offsetBy: 0)
      let Index = findIndexElement(string: value, elem: ".")
      let endIndex = value.index(value.startIndex, offsetBy: Index)
      let newValue = value[startIndex..<endIndex]
      return NSString(format: newValue + "%@" as NSString, "\u{00B0}") as String
   }
   
   func formateValueForVisibility(value: String) -> String {
      let startIndex = value.index(value.startIndex, offsetBy: 0)
      let Index = findIndexElement(string: value, elem: ".")
      let endIndex = value.index(value.startIndex, offsetBy: Index)
      let newValue = value[startIndex..<endIndex]
      return String(newValue + " km")
   }
   
   func formateValueForSunrise(value: String) -> String {
      let startIndex = value.index(value.startIndex, offsetBy: 11)
      let endIndex = value.index(value.startIndex, offsetBy: 16)
      let newValue = value[startIndex..<endIndex]
      return String(newValue + " AM")
   }
}
