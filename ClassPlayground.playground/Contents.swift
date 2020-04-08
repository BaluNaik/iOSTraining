import Foundation

/* Creating a class
   - use class keyword
   Syntax:
            class className: superClass {  // superClass is optinal
               Members  (variable)
               Methods  (functions)
            }

 */

class Vehicle {
    
    var wheels: Int = 0         //Properties
    var maxSpeed: Int = 0
    
    func drive() {            //Functions
        print("This vehicle is driving!!!")
    }
}

/* Creating instance(Object)
 
   - var objectName: ClassName =  ClassName()
 
   - var optinalObject: ClassName?
 */

var myVehicle1 = Vehicle()  //initialization

var myVehicle2:Vehicle?     //its optinal

/* accessing properties & functions
 
 - inorder to access data and functions we need to use .(dot) operator
 Syntax:
     objectName.member
     objectName.member =  value
     objectName.function()
 */

print("Vehicle1 Data: wheels=\(myVehicle1.wheels) maxSpeed:\(myVehicle1.maxSpeed)")
//Vehicle1 Data: wheels=0 maxSpeed:0

myVehicle1.wheels = 2
myVehicle1.maxSpeed = 120
print("Vehicle1 Data: wheels=\(myVehicle1.wheels) maxSpeed:\(myVehicle1.maxSpeed)")
//Vehicle1 Data: wheels=2 maxSpeed:120
myVehicle1.drive()  //This vehicle is driving!!!


print("Vehicle2 Data: wheels=\(myVehicle2?.wheels) maxSpeed:\(myVehicle2?.maxSpeed)")
//Vehicle2 Data: wheels=nil maxSpeed:nil  (initialization  not yet done)

myVehicle2?.wheels = 4
myVehicle2?.maxSpeed = 180
print("Vehicle2 Data: wheels=\(myVehicle2?.wheels ?? 0) maxSpeed:\(myVehicle2?.maxSpeed ?? 0)")
//Vehicle2 Data: wheels=nil maxSpeed:nil  (initialization  not yet done)


myVehicle2 = Vehicle()
myVehicle2?.wheels = 4
myVehicle2?.maxSpeed = 180
//print("Vehicle2 Data: wheels=\(myVehicle2?.wheels ?? 0) maxSpeed:\(myVehicle2?.maxSpeed ?? 0)")
//Vehicle2 Data: wheels=Optional(4) maxSpeed:Optional(180)

if let wheels = myVehicle2?.wheels,
    let speed = myVehicle2?.maxSpeed {
    print("Vehicle2 Data: wheels=\(wheels) maxSpeed:\(speed)")
}
myVehicle2 = nil


/* Subclassing And Inheritance */

class RaceCar: Vehicle {
    
    var hasSpoiler = true    //var isHavingSpoiler = true
    
    /* override is a keyword it allows us to re-implement super class method */
    override func drive() {  // Polymorphism
        print("i'm driving race car!!!!")
    }
}

var raceCar = RaceCar()
raceCar.wheels = 4  //its from super class properties
raceCar.maxSpeed = 400
raceCar.hasSpoiler = false
raceCar.drive() // its from sub-class because its override
print("RaceCar Data:Wheels=\(raceCar.wheels) maxSpeed=\(raceCar.maxSpeed) hasSpoiler:\(raceCar.hasSpoiler)")
//RaceCar Data:Wheels=4 maxSpeed=400 hasSpoiler:false

// Above example is indicates single Inheritance type

//Ex:2 for single Inheritance

class Bus: Vehicle {
    
    var seats: Int = 0
    var gear: Int = 1
    
    func shiftGear() {
        gear += 1
    }
}

var bus = Bus()
bus.seats = 60
bus.shiftGear()   // gear value increment by 1
bus.shiftGear()
bus.shiftGear()
print("Bus data.. Seats:\(bus.seats) current gear:\(bus.gear)")
bus.drive()  // its from super class
/* Bus data.. Seats:60 current gear:4
This vehicle is driving!!! */

/*
   - Single Inheritance: When a class created from a single base class(its root class no more parent for that i.e Vehicle )
     Ex: Bus, RaceCar
   - Multilevel Inheritance: If we are creating a class from another derived class
 */

//Ex: Multilevel Inheritance

class Ferrari: RaceCar {  // Ferrari <- RaceCar <- Vehicle
    
    var color: String = "Red"
    
    override func drive() {
        print("i'm driving ferrari \(color) color car")
    }
    
}

var ferrariCar = Ferrari()
ferrariCar.color = "Blue"
ferrariCar.hasSpoiler = false
ferrariCar.wheels = 4
ferrariCar.maxSpeed = 1000
ferrariCar.drive()
print("Ferrari Data: Wheels=\(ferrariCar.wheels) Max Speed=\(ferrariCar.maxSpeed)")
// i'm driving ferrari Blue color car
//Ferrari Data: Wheels=4 Max Speed=1000


// in iOS(Obj-c or Swift) Multiple Inheritance not supported

/* Most of the new OO languages like Small Talk, Java, C# do not support Multiple inheritance. Multiple Inheritance is supported in C++.
 
  Syntax:
          class ClassName: superClass1, superClass2, superClass3 {
 
          }
   // Inoder to support this type of structure we are wrking with protocals
 
 */
