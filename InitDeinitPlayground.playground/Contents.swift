import Foundation

class Vehicle: NSObject {   // What is NSObject? it's a root/parent class in Obj-c and swift
    
    private var wheels: Int?
    private var maxSpeed: Int?         //by default its
    
    /* Designated initializers */
    override init() {  // it's from NSObject
        self.wheels = 0
        self.maxSpeed = 0     // Whats is self? its a keyword refers to current object
    }
    
    convenience init(noOfwheels: Int, maxSpeed: Int) {
        self.init()
        self.wheels = noOfwheels
        self.maxSpeed = maxSpeed
    }
    
    func setVehicle( noOfWheels: Int, speed: Int) {
        self.wheels = noOfWheels
        self.maxSpeed = speed
    }
    
    func getVehicleInformation() {
        print("Wheels:\(self.wheels!) maxSpeed:\(maxSpeed!)")
        //print("Wheels:\(self.wheels ?? 0) maxSpeed:\(maxSpeed ?? 0)"
    }
    
}


   /*
    //let myVehicle = Vehicle()
    let myVehicle = Vehicle(noOfwheels: 3, maxSpeed: 100)
    //myVehicle.maxSpeed = 100   Error
    //myVehicle.wheels = 2       //Error
    myVehicle.getVehicleInformation()  //Wheels:0 maxSpeed:0
 */

 

/* Subclass */

class RaceCar: Vehicle {   // Vehicle has private memebrs so cant access in RaceCar
    
    internal var hasSpoiler: Bool?
    
    /* Designated initializers */
    override init() {
        super.init()   // called Vehicle init() and set default state
        self.hasSpoiler = false
    }
    
    override func getVehicleInformation() {
        super.getVehicleInformation()   // called super method  first inorder to print infomarion
        print("RaceCar having Spoiler = \(self.hasSpoiler!) ")
    }
    
}

/*
    let raceCar = RaceCar()
    raceCar.getVehicleInformation()
    //raceCar.hasSpoiler = true  (yes possible because of internal)
    //Wheels:0 maxSpeed:0   (this is from super class)
    //RaceCar having Spoiler = false (this is from subclass)
 */


final class Ferrari: RaceCar {  // From here not possible to do subclassing
    
    var carColor: String?
    
    /* Designated initializers */
    override init() {
        super.init() // -> RaceCar.init() -> Vehicle.init() -> NSobject.init()
        self.carColor = "Red"
    }
    
    final override func getVehicleInformation() {
        super.getVehicleInformation()
        print("Ferrari color:\(self.carColor!)")
    }
    
    /* convenience initializers */
    
    convenience init(noOfwheels: Int, maxSpeed: Int, hasSpoiler: Bool, color: String) {
        self.init()
        super.setVehicle(noOfWheels: noOfwheels, speed: maxSpeed)
        self.carColor = color
        self.hasSpoiler = hasSpoiler
    }
    
    deinit {
        self.carColor = nil
        print("Ferrari deinit")
    }
    
}

//let ferrari = Ferrari()
let ferrari = Ferrari(noOfwheels: 4, maxSpeed: 500, hasSpoiler: true, color: "Blue")
ferrari.getVehicleInformation()

/* Output:
        Wheels:0 maxSpeed:0
        RaceCar having Spoiler = false
        Ferrari color:Red
 */

/*
 Wheels:4 maxSpeed:500
 RaceCar having Spoiler = true
 Ferrari color:Blue
 */

var testFerrari: Ferrari?
testFerrari = Ferrari()
testFerrari = nil // When i'm assigning nil it will call deinit method






