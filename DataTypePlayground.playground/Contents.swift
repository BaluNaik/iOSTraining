import Foundation

let aShortValue: Int8 = 127 // -128 to 127
var aIntValue: Int

print(aShortValue)
aIntValue = 1234555
print(aIntValue)

let aFloatValue: Float = 12.34
var aDoubleValue: Double = 1234.567890
print("float value:\(aFloatValue)")
print("Double value:\(aDoubleValue)")

let isSessionGoing: Bool = true
print("Session is going:\(isSessionGoing)")

let myWebsite: String = "balututorial.com"
print("Website Name:\(myWebsite)")

let myCode: Character = "C"
print("Char code:\(myCode)")


/* Type casting
    1. converting one type to another type is called type casting
    var variable1: DataType1 = value
    var variable2: Datatype2 = Datatype2(variable1)
    
 */

let type1: Int = 12
let type2: Double = Double(type1)
print("type1:\(type1) type2:\(type2)")

let characterType: Character = "C"
let stringType:String = String(characterType)
print("String Type:\(stringType)")


let testTuple = (12,"BaluTutorial", 12.47)
print(testTuple.0)
//print(testTuple.self)
print(testTuple.1)
print(testTuple.2)

typealias myInt = Int64

var myInt64: myInt = 12
print(myInt64)








