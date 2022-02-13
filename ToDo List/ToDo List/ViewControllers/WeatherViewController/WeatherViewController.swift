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
   
   private let weatherViewModel: WeatherViewModel = WeatherViewModel()
   private var arrayNameCells = ["FirstViewCell", "SecondViewCell", "ThirdViewCell", "FourthViewCell",
                                 "FifthViewCell", "SixthViewCell", "SeventhViewCell", "EighthViewCell"]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
      prepareTableView()
      prepareCollectionView()
      requests()
   }
   
   func requests() {
      weatherViewModel.delegate = self
      weatherViewModel.loadData()
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
      for nameViewCell in arrayNameCells {
         secondUICollectionView.register(UINib.init(nibName: nameViewCell, bundle: Bundle.main), forCellWithReuseIdentifier: nameViewCell.replacingOccurrences(of: "View", with: ""))
      }
   }
}

extension WeatherViewController: RequestDelegateProtocol {
   func didLoadWeatherData(with data: [Weather]) {
      cityNameLabel.text = data.first?.cityName
      temperatureLabel.text = NSString(format: " \(Int(data.first?.temp ?? 0))" + "%@" as NSString, "\u{00B0}") as String
      descriptionLabel.text = data.first?.weather?.description
   }
   
   func didLoadWeathersData() {
      let minTemp = NSString(format: "Min: \(Int(weatherViewModel.weather?.first?.minTemp ?? 0))" + "%@" as NSString, "\u{00B0}") as String
      let maxTemp = NSString(format: "Max: \(Int(weatherViewModel.weather?.first?.maxTemp ?? 0))" + "%@" as NSString, "\u{00B0}") as String
      minTempLabel.text = minTemp
      maxTempLabel.text = maxTemp
      weatherTable.reloadData()
      secondUICollectionView.reloadData()
   }
   
   func didLoadWeatherForFifteenHours() {
      firstUICollectionView.reloadData()
   }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      weatherViewModel.weather?.count ?? 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherTableViewCell
      let weatherNew = weatherViewModel.weather ?? []
      cell.fill(with: (weatherNew[indexPath.row]))

      return cell
   }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      if collectionView == self.firstUICollectionView {
         return weatherViewModel.weatherForFifteenHours?.count ?? 0
      }
      
      if collectionView == self.secondUICollectionView {
         return weatherViewModel.aboutWather?.count ?? 0
      }
      
      return 0
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if collectionView == self.firstUICollectionView {
         let cellFirst = firstUICollectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionCell", for: indexPath) as! FirstCollectionViewCell
         let weatherNew = weatherViewModel.weatherForFifteenHours ?? []
         cellFirst.fill(with: (weatherNew[indexPath.row]))
         return cellFirst
      } else {
         let oneWeather = weatherViewModel.aboutWather?[indexPath.row]
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
         return weatherViewModel.sizeForSecondUICollection
      }
          
      return weatherViewModel.sizeForFirstUICollection
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      if collectionView == self.secondUICollectionView {
         return weatherViewModel.insetForSecondUICollection
      }
      
      return weatherViewModel.insetForFirstUICollection
   }
}
