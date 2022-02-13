//
//  WeatherViewModel.swift
//  ToDoList
//
//  Created by Serhii on 12.02.2022.
//

import Foundation
import Alamofire

class WeatherViewModel {
   
   weak var delegate: RequestDelegateProtocol?
   var weather: [Weathers]?
   var weathers: [Weather]?
   var aboutWather: [AboutWather]?
   var weatherForFifteenHours: [WeatherForFifteenHours]?
   private var requestManager = RequestManager()
   private var processingDataRequestManager = ProcessingDataRequestManager()
   
   let flowLayout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
       layout.minimumInteritemSpacing = 0
       layout.minimumLineSpacing = 0
       layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       return layout
   }()
   
   let sizeForSecondUICollection: CGSize = {
      let width = CGFloat(325.0)
      let numberOfItemsPerRow: CGFloat = 2
      let spacing: CGFloat = 0
      let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
      let itemDimension = floor(availableWidth / numberOfItemsPerRow)
      return CGSize(width: itemDimension, height: itemDimension)
   }()
   
   let sizeForFirstUICollection: CGSize = {
      CGSize(width: 40, height: 200)
   }()
   
   let insetForSecondUICollection: UIEdgeInsets = {
      UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
   }()
   
   let insetForFirstUICollection: UIEdgeInsets = {
      UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
   }()
   
   func findIndexElement(string: String, elem: Character) -> Int {
      if let i = string.firstIndex(of: elem) {
        return i.utf16Offset(in:string)
      } else {
         return 00
      }
   }
   
   func loadData() {
      getWaether()
      getWeathers()
      getWaethersForFifteenHours()
   }
   
   func getWaether() {
      let headers: HTTPHeaders = [
         "x-rapidapi-host": "weatherbit-v1-mashape.p.rapidapi.com",
         "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
      ]
      let url: String = "https://weatherbit-v1-mashape.p.rapidapi.com/current?lon=32.0621&lat=49.4285"
      requestManager.requestOfOneDay(headers: headers, url: url) { [self] response in
         weathers = response
         delegate?.didLoadWeatherData(with: response ?? [])
     }
   }
   
   func getWaethersForFifteenHours() {
      let headers: HTTPHeaders = [
         "x-rapidapi-host": "weatherbit-v1-mashape.p.rapidapi.com",
         "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
      ]
      let url: String = "https://weatherbit-v1-mashape.p.rapidapi.com/forecast/hourly?lat=49.4285&lon=32.0621&hours=15"
      requestManager.requestOfFifteenHours(headers: headers, url: url) { [self] response in
         weatherForFifteenHours = response
         weatherForFifteenHours?[0].timestampLocal = "Now"
         delegate?.didLoadWeatherForFifteenHours()
     }
   }
   
   func getWeathers() {
      let headers: HTTPHeaders = [
         "x-rapidapi-host": "weatherbit-v1-mashape.p.rapidapi.com",
         "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
      ]
      let url: String = "https://weatherbit-v1-mashape.p.rapidapi.com/forecast/daily?lat=49.4285&lon=32.0621"
      requestManager.requestOfManyDay(headers: headers, url: url) { [self] response in
         weather = response
         aboutWather = processingDataRequestManager.processingData(weathers: response)
         delegate?.didLoadWeathersData()
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
