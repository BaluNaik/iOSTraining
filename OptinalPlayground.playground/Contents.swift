import Foundation

var myInteger: Int?
var myValue: Int = 10
var result: Int = 0

//result = myValue + myInteger   // int + int?
//Error Value of optional type 'Int?' must be unwrapped to a value of type 'Int'

//result = myValue + myInteger!   // myInteger! (fource unwapping --> risk to do)
//Fatal error: Unexpectedly found nil while unwrapping an Optional value: file OptinalPlayground.playground, line 10

//myInteger = 20
//result = myValue + myInteger!  //But still its risk


/* optinal unwrapping */

if myInteger != nil {
    myInteger = myInteger! + myValue
    print("Sum value:\(result)")
} else {
    print("Ohoo no....found nil value")
}

var firstName: String? = "Balu"   // first name is there...but later may be it can be nil
var lastName: String = "Tutorial"  // last name can't be nil
var fullName: String = ""    //It must be have data (not required to do like this but its valid)

print(firstName)
print(lastName)
print(fullName) //by default it has nil value

if firstName != nil {
    print(firstName!)
}

if firstName != nil {
    fullName = firstName! + " " + lastName
}
print(fullName)

if let fName = firstName {
    fullName = fName + lastName
}









