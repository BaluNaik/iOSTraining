import Foundation   // #include <stdio.h>

print("Welcome to balututorial.com")
print("Two")


/* Variable & constants */

var aValue = 10    // No data type name here, because by default its an int
var aFloatValue = 12.8  //No need type because its float

//print("Int value=%d float value=%f", aValue, aFloatValue) No

print("Int value=\(aValue) \nFlaot Value=\(aFloatValue)")


//aValue = 12.34  // Swift has type checking

//aFloatValue = 15

var aStringType = "Welcome to balututorial.com"
print(aStringType)

/* We have 2 tpes names conv

    1. camel case
    2. snake case
 
 camel case: First char should be in lower case and every next word first char should be in upper case
  Ex: aIntValue, floatValue, myName, testString
 
 *** We use camel case for variable and functions/methods ******
 
 snake case: every thing in lower case and have to use _ for every word
 Ex: int_value, float_value, my_name, test_string
 
 */

/* Constants */

let myIntValue = 10
myIntValue = 100   //Error

let myName = "Balu"

myName = "Balu Naik"


var testInteger: Int = 20
//var testInteger = 20

var testName: String = "Balu Naik"
//var testName = "Balu Naik"

// Syntax1#---->   var variableName = value (or)   var variableName: DataType = value
// Synatx2# --->   let variableName = value   (or) let variableName: DataType = value













