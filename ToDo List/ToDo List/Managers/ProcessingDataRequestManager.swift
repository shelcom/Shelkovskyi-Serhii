//
//  ProcessingDataRequest.swift
//  ToDoList
//
//  Created by Serhii on 15.01.2022.
//

import Foundation

class ProcessingDataRequestManager {
   
   private var aboutWather: [AboutWather]?
   
   func processingData(weathers: [Weathers]?) -> [AboutWather]? {
      let weather = weathers?.first
      aboutWather = [.init(title: "UV-Index", intValue: nil, type: .first, doubleValue: weather?.uv),
                     .init(title: "Sunrise", intValue: nil, type: .second, doubleValue: weather?.sunriseTs),
                     .init(title: "Wind", intValue: nil, type: .third, doubleValue: weather?.windSpd),
                     .init(title: "Precip", intValue: nil, type: .fourth, doubleValue: weather?.precip),
                     .init(title: "Feels Like", intValue: nil, type: .fifth, doubleValue: weather?.appMaxTemp),
                     .init(title: "Humidity", intValue: weather?.rh, type: .sixth, doubleValue: nil),
                     .init(title: "Visibility", intValue: nil, type: .seventh, doubleValue: weather?.vis),
                     .init(title: "Pressure", intValue: nil, type: .eighth, doubleValue: weather?.pres)]
      
      return aboutWather
   }
}
