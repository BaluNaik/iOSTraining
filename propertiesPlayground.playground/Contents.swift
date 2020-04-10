import Foundation

//Stored properties

/*
 class Circle {
    
    var radius: Double = 0  // this a stored propertie because it has value
}

let myCircle = Circle() // instance is created
myCircle.radius = 30
print("radius:\(myCircle.radius)") // radius:30.0 */

/*
 - Circle has an instance variable called  radius with a default value of 0.
 - In Swift, every instance variable is automatically a property.
 - So we have the possibility to add property observers.
 - In Swift there a two types of property observers:
       1. One is called before the new value is assigned(willSet)
       2. other one afterwards(didSet)
 */

/* class Circle {
    
    var radius: Double = 0 {
        willSet {
            print("About to assign the new value:\(newValue)") //  newValue by default avilable
        }
        didSet {
            if radius < 0 {
                radius = oldValue  // its by default aviable (oldValue)
            }
        }
    }
}

let circle = Circle()
circle.radius = -10.0
print("Radius:\(circle.radius)") //Radius:0.0

circle.radius = 10.0
print("Radius:\(circle.radius)") //Radius:10.0 */

/* - The property observer, which is called after the assignment, is marked with the keyword  didSet
   - We can also use the property observer  willSet, which is called before the new value is assigned
 */


/* Computed Properties
 - computed properties don’t have a stored value.
 - computed properties will be computed data when we are using,i.e calculated.
 - A computed property always needs a getter (for returning value)
 - If it lacks a setter, the property is called a read-only property.
 
 */

/*class Circle {
    
    var radius: Double = 0 {  //Stored propertie
        didSet {
            if radius < 0 {
                radius = oldValue
            }
        }
    }
    
    var area: Double {  //Computed Propertie
        get {
            
            return radius * radius * Double.pi
        }
    }
    
}

let circle = Circle()
circle.radius = -10.0
print("area:\(circle.area)")  //area:0.0

circle.radius = 5.0
print("area:\(circle.area)")  //area:78.53981633974483

circle.area = 40.0;  //Cannot assign to property: 'area' is a get-only property
//If it lacks a setter, the property is called a read-only property.
print("area:\(circle.radius)") */


class Circle {
    
    var radius: Double = 0 {  //Stored propertie
        didSet {
            if radius < 0 {
                radius = oldValue
            }
        }
    }
    
    var area: Double {  //Computed Propertie
        get {
            
            return radius * radius * Double.pi
        }
        set(newValue) {
            radius = sqrt(newValue) / Double.pi
        }
    }
}
let circle = Circle()
circle.radius = 5.0;
print("Radius:\(circle.radius) Area:\(circle.area)") //Radius:5.0 Area:78.53981633974483

circle.area = 78.0;
print("Radius:\(circle.radius) Area:\(circle.area)") //Radius:2.811236796163274 Area:24.828171122335682



/* Initilization of stored properties
 Every stored property has to have a value after its instance has been created.
   There are two ways:
     1. initialize the value
     2. initialize the value inside the init method

 */

//class TestClass {
//
//    var myValue: Double
//
//    init(value: Double) {
//        self.myValue = value
//    }
//}
//let tt = TestClass(value: 12.0)


/* Lazy Properties */


class TestClass {
    
    //var testString: String = "TestString"
    //stored propertie will be crerated when class instance is created
    // that means if you are not using that memeber still ints created in memory
    
    lazy var testString: String = "TestString"
    //The property will not initalized until it gets accessed.
    //'lazy' must not be used on a computed property
    
}

let testObject = TestClass()
print(testObject.testString) // now it will be created

/* Type Properties
   - it's a static member for a class
   - for all instances of the classes will use same member
   - it will created with 'static' keyword
   - Type properties should access by using class name
 */

class SomeClass {
    
    static var testString: String = "balututorial.com"
    // Type Propertie
}
let obj = SomeClass()
//obj.testString;  /// No its static type so we can't access using an instance variable
//When class is loaded in memeory static type will created

print(SomeClass.testString) // this the way to access static/type memebrs


/* Public Properties With Private Setters */

class TestCircle {
    
    public private(set) var area: Double = 0.0
    
    public private(set) var radius: Double = 0.0
    
    init(with area: Double) {
        self.area = area
    }
    
    init(with area: Double, and radius: Double) {
        self.radius = radius
        self.area = area
    }
}

let testObj = TestCircle(with: 10.0, and: 30.0)
//testObj.area = 10.0  //Cannot assign to property: 'area' setter is inaccessible because setter is private
//testObj.radius = 30.0; //Error

print("Area:\(testObj.area) Radius:\(testObj.radius)")












