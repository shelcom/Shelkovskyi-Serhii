//
//  WeatherViewController.swift
//  ToDoList
//
//  Created by Serhii on 11.01.2022.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController, OpenWeatherMapDelegate {
   
   @IBOutlet var weatherTable: UITableView!
   
   var weathers: [Weather]? = nil
   var requestManager = RequestManager()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      requestManager.delegate = self
      prepareTableView()
      
      getWeather()

   }
   
   func prepareTableView() {
      weatherTable.delegate = self
      weatherTable.dataSource = self
      weatherTable.register(UINib.init(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
   }
   
   func getWeather() {
      let headers: HTTPHeaders = [
         "x-rapidapi-host": "weatherbit-v1-mashape.p.rapidapi.com",
         "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
      ]
      let url: String = "https://weatherbit-v1-mashape.p.rapidapi.com/forecast/daily?lat=38.5&lon=-78.5"
      requestManager.request(headers: headers, url: url)
   }
}

extension WeatherViewController : UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      weathers?.count ?? 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherTableViewCell
      let weather = weathers ?? []
      cell.fill(with: (weather[indexPath.row]))

      return cell
   }
   
   func updateWeatherInfo() {
      weathers = requestManager.weather
      weatherTable.reloadData()
   }
}
