import UIKit

//Momento Example 1
struct User {
   var name: String
   var surname: String
}

class UserManager {
   
   var users: [User] = []
   
   func saveUsers(newUser: User) -> [User] {
      users.append(newUser)
      return users
   }
   
   func restoreUser() -> User? {
      guard let lastUser = users.last else { return nil }
      users.removeLast()
      return lastUser
   }
}

var userManager = UserManager()
var addFirstUser = User.init(name: "Sergio", surname: "Shelkovskyi")
var addSecondUser = User.init(name: "Igor", surname: "Fedotov")
userManager.saveUsers(newUser: addFirstUser)
userManager.saveUsers(newUser: addSecondUser)
userManager.restoreUser()

//Momento Example 2
struct Apps {
   var id: NSUUID
   var name: String
   var category: String
   var price: Double?
}

class AppStore {
   
   var apps: [Apps] = []
   
   func saveApp(newApp: Apps) -> [Apps] {
      apps.append(newApp)
      return apps
   }
   
   func deleteApp(appId: UUID) -> Apps? {
      let app = apps.first(where: { $0.id as UUID == appId })
      apps.removeLast()
      return app
   }
}

var appStore = AppStore()
let uuid = NSUUID().uuidString.lowercased()
var addFirstApp = Apps.init(id: NSUUID(), name: "Top", category: "programm", price: 100.5)
var addSecondApp = Apps.init(id: NSUUID(), name: "New", category: "programm", price: 60.5)

appStore.saveApp(newApp: addFirstApp)
appStore.deleteApp(appId: addFirstApp.id as UUID)
appStore.apps
print("-")

//ChainOfResponsibility Example 1
enum RestaurantError: Error {
   case invalidOrder
   case dontPayOrder
}

class Restaurant {
   
   var order: Order?
   var menu: [Menu]?
   
   func createOrder() throws {
      if (menu?.first(where: { $0.name == order?.chooseDish?.name })) != nil {
         print("Create Order")
      } else {
         throw RestaurantError.invalidOrder
      }
   }
   
   func payForOrder() throws {
      let eat = menu?.first(where: { $0.name == order?.chooseDish?.name })?.cost
      guard let price = order?.price else { return }
      
      if price >= eat ?? 0 {
         print("You pay")
      } else {
         throw RestaurantError.dontPayOrder
      }
   }
}

struct Order {
   var price: Int
   var chooseDish: Eat?
}

struct Eat {
   var name: String
}

struct Menu {
   var name: String
   var cost: Int
}

var otherProduct = Eat.init(name: "Soup")
var restaurant = Restaurant()
var createNewOrder = Order(price: 500)
createNewOrder.price = 500
createNewOrder.chooseDish = .init(name: "Borch")

do {
   try restaurant.createOrder()
   try restaurant.payForOrder()
} catch RestaurantError.invalidOrder {
   print("Restaurant doesnt have this dish")
} catch RestaurantError.dontPayOrder {
   print("You dont pay")
}

//ChainOfResponsibility Example 2
enum TravelError: Error {
   case invalidDate
   case dontPay
   case dontFly
   case crush
}

class Travel {
   
   var human: Human?
   var country: Country?
   var airplane: Airplane?
   
   func chooseDateForFly(date: String) throws {
      if (country?.date.first(where: { $0 == date })) != nil {
         print("You can go")
      } else {
         throw TravelError.invalidDate
      }
   }
   
   func buyTicket() throws {
      if human?.money ?? 0 >= human?.bilet.price ?? 0 {
         print("Sending on a flight")
      } else {
         throw TravelError.dontPay
      }
   }
   
   func sendingAnAircraft() throws {
      if airplane?.willBeFly ?? false {
         print("The plane will fly")
      } else {
         throw TravelError.dontFly
      }
   }
   
   func flight() throws {
      if airplane?.willCrash ?? false {
         print("The plane has arrived")
      } else {
         throw TravelError.crush
      }
   }
}

struct Human {
   var bilet: Ticet
   var money: Int
}

struct Ticet {
   var country: Country?
   var date: String
   var price: Int
}

struct Country {
   var name: String
   var date: [String]
}

struct Airplane {
   var name: String
   var willBeFly: Bool
   var willCrash: Bool
}

var country = Country.init(name: "Ukraine", date: ["24.02", "25.02"])
var ticket = Ticet.init(country: country, date: "24.02", price: 100)
var human = Human.init(bilet: ticket, money: 99)
var samolet = Airplane.init(name: "Boing", willBeFly: true, willCrash: false)
var travel = Travel()

travel.human = human
travel.country = country
travel.airplane = samolet

do {
   try travel.chooseDateForFly(date: "24.02")
   try travel.buyTicket()
   try travel.sendingAnAircraft()
   try travel.flight()
} catch TravelError.invalidDate {
   print("This date is invalid")
} catch TravelError.dontPay {
   print("You dont pay")
} catch TravelError.dontFly {
   print("This airplane dont fly today")
} catch TravelError.crush {
   print("This plane crashed")
}

print("-")

//Observer Example 1
protocol PropertyObserver {
   func willChangeValue(newValue: Int)
   func oldPropertyValue(oldValue: Int)
}

class Test {
    
   var observer: PropertyObserver?
    
   var testNumber: Int = 0 {
      willSet {
         observer?.willChangeValue(newValue: newValue)
      }
      
      didSet {
         observer?.oldPropertyValue(oldValue: oldValue)
      }
   }
}

class Observer: PropertyObserver {
   
   func willChangeValue(newValue: Int) {
      if newValue == 1 {
         print("Change")
      }
   }
   
   func oldPropertyValue(oldValue: Int) {
      if oldValue == 0 {
         print("")
      }
   }
}

var observerInstance = Observer()
var test = Test()
test.observer = observerInstance
test.testNumber += 1

//Observer Example 2
protocol Bidder {
   var id: Int { get }
   func update(bid: Int)
}

class Auctioneer {
   
   var bidders = [Bidder]()

   func receiveBid (bid: Int) {
      notifyBidder(bid: bid)
   }
    
   func register(bidder: Bidder) {
      bidders.append(bidder)
   }
    
   func notifyBidder(bid: Int) {
      for bidder in bidders {
         bidder.update(bid: bid)
      }
   }
    
   func deregister(bidder: Bidder) {
      if let toRemove = bidders.enumerated().first(where: { $0.element.id == bidder.id }) {
         bidders.remove(at: toRemove.offset)
      }
   }
}

class OnlineBidder: Bidder {
   
   var id: Int
   private var subject: Auctioneer
   
   init(subject: Auctioneer, id: Int) {
      self.id = id
      self.subject = subject
      self.subject.register(bidder: self)
   }
   
   func update(bid: Int) {
      print ("Decide whether to update")
      print ("Type increased bid which would be greater than > \(bid)")
   }
}

class InpersonBidder: Bidder {
    
   var id: Int
   private var subject: Auctioneer
    
   init(subject: Auctioneer, id: Int) {
      self.id = id
      self.subject = subject
      self.subject.register(bidder: self)
   }
    
   func update(bid: Int) {
      print ("Decide whether to update")
      print ("Present bid sign which would be greater than> \(bid)")
   }
}

let auctioneer = Auctioneer()
let firstBidder = OnlineBidder(subject: auctioneer, id: 1)
let secondBidder = InpersonBidder(subject: auctioneer, id: 2)
auctioneer.receiveBid(bid: 10)
