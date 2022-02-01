import UIKit

//Adapter Example 1
protocol Jumping {
   func jump()
}

class Dog: Jumping {
   func jump() {
      print("Jumps")
   }
}

class Puma: Jumping {
   func jump() {
      print("Pounces")
   }
}

class Horse {
   func leap() {
      print("Leaps")
   }
}

extension Horse: Jumping {
   func jump() {
      leap()
   }
}

func jumpAll(animals: [Jumping]) {
   for animal in animals {
      animal.jump()
   }
}

let dog = Dog()
let puma = Puma()
var horse = Horse()
var animals: [Jumping] = [dog, puma, horse]
jumpAll(animals: animals)
print("-")


//Adapter Example 2
protocol BirdProtocol {
   func sing()
}

class Rooster: BirdProtocol {
   
   func sing() {
      print("CuCaReCU")
   }
}

class Raven {
    
   func vioce() {
      print("Kar-kar")
   }
}

class RavenAdapter: BirdProtocol {
   private let raven: Raven
    
   init(adaptee: Raven) {
      self.raven = adaptee
   }
    
   func sing() {
      raven.vioce()
   }
}

func  birdSing(aBird: [BirdProtocol]) {
   for bird in aBird {
      bird.sing()
   }
}

let rooster = Rooster()
let simpleRaven = Raven()
let ravenAdapter = RavenAdapter(adaptee: simpleRaven)
var birds: [BirdProtocol] = [rooster, ravenAdapter]
birdSing(aBird: birds)
print("-")


//Composite Example 1
protocol Deputy {
   func governingTheCountry()
}

class President: Deputy {
   func governingTheCountry() {
      print("Governs the whole country")
   }
}

class DeputyHead: Deputy {
   func governingTheCountry() {
      print("Governs the whole country except the President")
   }
}

class TheVerkhovnaRada: Deputy {
   private var deputies: [Deputy]
    
   init(deputies: [Deputy]) {
      self.deputies = deputies
   }
    
   func governingTheCountry() {
      for deputy in self.deputies {
         deputy.governingTheCountry()
      }
   }
}

var deputies: [Deputy] = [President(), DeputyHead()]
var theVerkhovnaRada = TheVerkhovnaRada.init(deputies: deputies)
theVerkhovnaRada.governingTheCountry()
print("-")


//Composite Example 2
protocol Composite {
   var name: String {get set}
   func showContent() -> Any
   func addComponent(c: Composite)
}

class File: Composite {
   var name: String
    
   init(name: String) {
      self.name = name
   }
    
   func showContent() -> Any {
      return name
   }
    
   func addComponent(c: Composite) {
      print("К файлу не могу добавить папку")
   }
}

class Folder: Composite {
   var name: String
    
   init(name: String) {
      self.name = name
   }
    
   var content: [Composite] = []
    
   func showContent() -> Any {
      return content
   }
    
   func addComponent(c: Composite) {
      content.append(c)
   }
}

func printComposite(folder: Composite, tab: String = "") {
   for composite in (folder.showContent() as! [Composite]) {
      print(tab + composite.name)
      if composite is Folder {
         printComposite(folder: composite, tab: tab + "\t")
      }
   }
}

var mainFolder: Composite = Folder(name: "Main Folder 1")
mainFolder.addComponent(c: File(name: "File 1"))
mainFolder.addComponent(c: File(name: "File 2"))
var secondFolder: Composite = Folder(name: "Folder 2")
mainFolder.addComponent(c: secondFolder)
secondFolder.addComponent(c: File(name: "File 1"))
secondFolder.addComponent(c: File(name: "File 2"))
secondFolder.addComponent(c: File(name: "File 3"))
print(mainFolder.name)
printComposite(folder: mainFolder, tab: "\t")
print("-")


//Bridge Example 1
class BaseHeadphones {
   
   func playSimpleSound(){
      print("Psh.....")
   }
   
   func playBassSound() {
      print("Bum.....")
   }
}

class CheapHeadphones: BaseHeadphones {
   
   override func playSimpleSound() {
      print("Psh")
   }
   
   override func playBassSound() {
      print("Bum")
   }
}

class ExpensiveHeadphones: BaseHeadphones {
   
   override func playSimpleSound() {
      print("BlaBlaBla")
   }
    
   override func playBassSound() {
      print("BumBumBumBumBum")
   }
}

class MusicPlayer {
   
   var headPhones: BaseHeadphones?
    
   func playMusic() {
      headPhones?.playBassSound()
      headPhones?.playSimpleSound()
   }
}

let player = MusicPlayer()
let cheap = CheapHeadphones()
let expensive = ExpensiveHeadphones()
player.headPhones = cheap
player.playMusic()
print("and")
player.headPhones = expensive
player.playMusic()
print("-")


//Bridge Example 2
protocol DeviceProtocol {
   func on()
   func off()
}

class TV: DeviceProtocol {
   
   func on() {
      print("TV on")
   }
    
   func off() {
      print("TV off")
   }
}

class Remote {
   
   var device: DeviceProtocol?
    
   func on() {
      device?.on()
   }
    
   func off() {
      device?.off()
   }
}

var remote = Remote()
var tv = TV()
remote.device = tv
remote.on()
remote.off()
