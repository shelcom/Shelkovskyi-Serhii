//
//  RequestDelegateProtocol.swift
//  ToDoList
//
//  Created by Serhii on 13.02.2022.
//

import Foundation

protocol RequestDelegateProtocol: NSObjectProtocol {
   func didLoadWeatherData(with data: [Weather])
   func didLoadWeathersData()
   func didLoadWeatherForFifteenHours()
}
