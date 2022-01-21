//
//  WeatherViewController.swift
//  ToDoList
//
//  Created by Serhii on 11.01.2022.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {
   
   @IBOutlet var weatherTable: UITableView!
   @IBOutlet var cityNameLabel: UILabel!
   @IBOutlet var temperatureLabel: UILabel!
   @IBOutlet var descriptionLabel: UILabel!
   @IBOutlet var minTempLabel: UILabel!
   @IBOutlet var maxTempLabel: UILabel!
   @IBOutlet var firstUICollectionView: UICollectionView!
   @IBOutlet var secondUICollectionView: UICollectionView!
   
   private var weather: [Weathers]? = nil
   private var weathers: [Weather]? = nil
   private var aboutWather: [AboutWather]?
   var weatherForFifteenHours: [WeatherForFifteenHours]? = nil
   var requestManager = RequestManager()
   var processingDataRequestManager = ProcessingDataRequestManager()
   
   let flowLayout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
       layout.minimumInteritemSpacing = 0
       layout.minimumLineSpacing = 0
       layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       return layout
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
      prepareTableView()
      prepareCollectionView()
      requests()
   }
   
   func requests() {
      getWeather()
      getWaethers()
      getWaethersForFifteenHours()
   }
   
   func getWeather() {
      let headers: HTTPHeaders = [
         "x-rapidapi-host": "weatherbit-v1-mashape.p.rapidapi.com",
         "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
      ]
      let url: String = "https://weatherbit-v1-mashape.p.rapidapi.com/forecast/daily?lat=49.4285&lon=32.0621"
      requestManager.requestOfManyDay(headers: headers, url: url) { [self] response in
         weather = response
         
         aboutWather = processingDataRequestManager.processingData(weathers: response)
         let minTemp = NSString(format: "Min: \(Int(weather?.first?.minTemp ?? 0))" + "%@" as NSString, "\u{00B0}") as String
         let maxTemp = NSString(format: "Max: \(Int(weather?.first?.maxTemp ?? 0))" + "%@" as NSString, "\u{00B0}") as String
         minTempLabel.text = minTemp
         maxTempLabel.text = maxTemp
         
         weatherTable.reloadData()
         secondUICollectionView.reloadData()
     }
   }
   
   func getWaethers() {
      let headers: HTTPHeaders = [
         "x-rapidapi-host": "weatherbit-v1-mashape.p.rapidapi.com",
         "x-rapidapi-key": "e92a2869camsh3383fa9a8d1ee5fp1df7cdjsn40fcf2dcbd7c"
      ]
      let url: String = "https://weatherbit-v1-mashape.p.rapidapi.com/current?lon=32.0621&lat=49.4285"
      requestManager.requestOfOneDay(headers: headers, url: url) { [self] response in
         weathers = response
         
         cityNameLabel.text = weathers?.first?.cityName
         temperatureLabel.text = NSString(format: " \(Int(weathers?.first?.temp ?? 0))" + "%@" as NSString, "\u{00B0}") as String
         descriptionLabel.text = weathers?.first?.weather?.description
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
         firstUICollectionView.reloadData()
     }
   }
   
   func prepareTableView() {
      weatherTable.delegate = self
      weatherTable.dataSource = self
      weatherTable.register(UINib.init(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
      weatherTable.layer.cornerRadius = 12.0
      weatherTable.backgroundView = UIImageView(image: UIImage(named: "background"))
   }
   
   func prepareCollectionView() {
      prepareFirstCollectionView()
      prepareSecondCollectionView()
   }
   
   func prepareFirstCollectionView() {
      firstUICollectionView.delegate = self
      firstUICollectionView.dataSource = self
      firstUICollectionView.register(UINib.init(nibName: "FirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstCollectionCell")
      firstUICollectionView.layer.cornerRadius = 12.0
      firstUICollectionView.backgroundView = UIImageView(image: UIImage(named: "background"))
   }
   
   func prepareSecondCollectionView() {
      secondUICollectionView.delegate = self
      secondUICollectionView.dataSource = self
      registerCellsSecondUICollection()
      secondUICollectionView.layer.cornerRadius = 12.0
      secondUICollectionView.backgroundView = UIImageView(image: UIImage(named: "background"))
   }
   
   func registerCellsSecondUICollection() {
      secondUICollectionView.register(UINib.init(nibName: "FirstViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FirstCell")
      secondUICollectionView.register(UINib.init(nibName: "SecondViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SecondCell")
      secondUICollectionView.register(UINib.init(nibName: "ThirdViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ThirdCell")
      secondUICollectionView.register(UINib.init(nibName: "FourthViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FourthCell")
      secondUICollectionView.register(UINib.init(nibName: "FifthViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FifthCell")
      secondUICollectionView.register(UINib.init(nibName: "SixthViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SixthCell")
      secondUICollectionView.register(UINib.init(nibName: "SeventhViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SeventhCell")
      secondUICollectionView.register(UINib.init(nibName: "EighthViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "EighthCell")
   }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      weather?.count ?? 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherTableViewCell
      let weatherNew = weather ?? []
      cell.fill(with: (weatherNew[indexPath.row]))

      return cell
   }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      if collectionView == self.firstUICollectionView {
         return weatherForFifteenHours?.count ?? 0
      }
      
      if collectionView == self.secondUICollectionView {
         return aboutWather?.count ?? 0
      }
      
      return 0
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if collectionView == self.firstUICollectionView {
         let cellFirst = firstUICollectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionCell", for: indexPath) as! FirstCollectionViewCell
         let weatherNew = weatherForFifteenHours ?? []
         cellFirst.fill(with: (weatherNew[indexPath.row]))
         return cellFirst
      } else {
         let oneWeather = aboutWather?[indexPath.row]
         switch oneWeather?.type {
            case .first:
            let cell = secondUICollectionView.dequeueReusableCell(withReuseIdentifier: "FirstCell", for: indexPath) as! FirstViewCell
               cell.fill(with: oneWeather)
               return cell
            case .second:
               let cell = secondUICollectionView.dequeueReusableCell(withReuseIdentifier: "SecondCell", for: indexPath) as! SecondViewCell
               cell.fill(with: oneWeather)
               return cell
            case .third:
               let cell = secondUICollectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCell", for: indexPath) as! ThirdViewCell
               cell.fill(with: oneWeather)
               return cell
            case .fourth:
               let cell = secondUICollectionView.dequeueReusableCell(withReuseIdentifier: "FourthCell", for: indexPath) as! FourthViewCell
               cell.fill(with: oneWeather)
               return cell
            case .fifth:
               let cell = secondUICollectionView.dequeueReusableCell(withReuseIdentifier: "FifthCell", for: indexPath) as! FifthViewCell
               cell.fill(with: oneWeather)
               return cell
            case .sixth:
               let cell = secondUICollectionView.dequeueReusableCell(withReuseIdentifier: "SixthCell", for: indexPath) as! SixthViewCell
               cell.fill(with: oneWeather)
               return cell
            case .seventh:
               let cell = secondUICollectionView.dequeueReusableCell(withReuseIdentifier: "SeventhCell", for: indexPath) as! SeventhViewCell
               cell.fill(with: oneWeather)
               return cell
            default:
               let cell = secondUICollectionView.dequeueReusableCell(withReuseIdentifier: "EighthCell", for: indexPath) as! EighthViewCell
               cell.fill(with: oneWeather)
               return cell
         }

      }
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
      if collectionView == self.secondUICollectionView {
         let width = CGFloat(325.0)
         let numberOfItemsPerRow: CGFloat = 2
         let spacing: CGFloat = flowLayout.minimumInteritemSpacing
         let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
         let itemDimension = floor(availableWidth / numberOfItemsPerRow)
         return CGSize(width: itemDimension, height: itemDimension)
      }
      return CGSize(width: 40, height: 200)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      if collectionView == self.secondUICollectionView {
         return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
      }
      
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
   }
}
