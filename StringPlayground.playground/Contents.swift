import Foundation

/* Swift String initialization */


let myWeb = "www.balututorial.com"

let emptyString: String = ""
// let emptString = ""

let anotherEmptyString = String()

print(myWeb.isEmpty)  //false

print(emptyString.isEmpty)  //true

print(anotherEmptyString.isEmpty) //true

let integerString = String(10)  // returns "10"
print(integerString)

let boolString = String(true)  // returns "true"
print(boolString)


let char = "A"
let testString1 = String(repeating: char, count: 10)
print(testString1)


/* Swift String Empty String check */

if emptyString.isEmpty {
    print("empty string")  //yes prints
}

if boolString.isEmpty {
    print("bool string is empty")  // no it doesn't prints
}


/* Appending Strings */

// same as using + operator

let helloString = "Hello"
let worldString = "World!!"

var helloWorld = ""

helloWorld += helloString  // Hello
//helloWorld = helloWorld + helloString

helloWorld += " "         // Hello space
//helloWorld = helloWorld + ""

helloWorld += worldString
//helloWorld = helloWorld + worldString

print(helloWorld)  //Hello World!!


/* String Interpolation */

let xValue = 10
let yValue = 20
let string = "Hello"

print("\(string) \(xValue) * \(yValue) = \(xValue * yValue)") //Hello 10 * 20 = 200

let resultString = "\(string) \(xValue) * \(yValue) = \(xValue * yValue)"
print(resultString)

/* Iterating through a String */

let myWebPage = "www.balututorial.com"

for char in myWebPage {
    print(char)
}

//Working with indices
for charIndex in myWebPage.indices {
    print(myWebPage[charIndex])
}

for (index, char) in myWebPage.enumerated() {
    print("\(index).\(char)")
}


/* Swift String Length */

print(myWebPage.count) // prints 20


/* Multi-Line String Literals (from Swift 4) */

let multiLineString = """
Line 1
Lin2 2
Line 3
"""
print(multiLineString)
// by default it include \n (new line) after every line

let multiLineString1 = """
Line 1,\
Lin2 2,\
Line 3
"""
print(multiLineString1) //Line 1,Lin2 2,Line 3

/* String Comparison */
//same as ==

let test1 = "Hello"
var test2 = "Hello"

if test1 == test2 {  // Hello == Hello
    print("both are same")
}

test2 = "hello"
if test1 != test2 {   // Hello == hello
    print("both are not same")
}

/* Convert to upper and lower case */

print(test2.uppercased()) //HELLO

print(test1.lowercased()) //hello

/* Prefix and Suffix */

/*  if your card begins with the number 4, it's a Visa;
    a 5, a MasterCard;
    a 6, Discover;
    34 or 37 American Express */

let masterCard = "5432-4134-xxxx"
let aExpressCard = "3421-4222-1234"

print(masterCard.hasPrefix("5"))  // true
print(aExpressCard.hasPrefix("5")) // false
print(aExpressCard.hasPrefix("34")) // false

print(aExpressCard.hasSuffix("1234"))  //true
print(masterCard.hasSuffix("abcd"))  //false


/* String start and end index */

let swfitProgramming = "Hello Swift!!"

print(swfitProgramming.startIndex)  // its return first car index
print(swfitProgramming.endIndex)   // this one retuns next postion of end char (out of string)

//startIndex: is the index of the first character
//endIndex: is the index after the last character.


for (index, char) in swfitProgramming.enumerated() {
    print("\(index).\(char)")
}


/* Insert and remove a character from String */

var helloSwift = "Hello Swift!!!"

print(helloSwift)

helloSwift.insert("!", at: helloSwift.startIndex)
print(helloSwift)  //!Hello Swift!!!

helloSwift.insert("@", at: helloSwift.endIndex) //!Hello Swift!!!

helloSwift.insert("&", at: helloSwift.index(before: helloSwift.endIndex))
//!Hello Swift!!!&@
print(helloSwift)

helloSwift.remove(at: helloSwift.startIndex)
print(helloSwift)  //Hello Swift!!!&@

helloSwift.remove(at: helloSwift.index(helloSwift.endIndex, offsetBy: -2))
print(helloSwift)  //Hello Swift!!!@

helloSwift.remove(at: helloSwift.index(helloSwift.startIndex, offsetBy: 2))
print(helloSwift)  //Helo Swift!!!@



/* Insert multiple characters/substring */

var testString = "Hello World!!"

print(testString)  //Hello World!!
testString.insert(contentsOf: "Hey!", at: testString.startIndex)
print(testString)  //Hey!Hello World!!

testString = testString.replacingOccurrences(of: "Hey!", with: "Hey ")
print(testString)  //Hey Hello World!!

testString = testString.replacingOccurrences(of:"Hey " , with: "")
print(testString)  //Hello World!!

let range = testString.range(of: "World")
//print(range) //Optional(Range(Swift.String.Index(_rawBits: 393216)..<Swift.String.Index(_rawBits: 720896)))

if let position = range {
    testString = testString.replacingCharacters(in: position, with: "Balu Tutorial")
}
print(testString)  //Hello Balu Tutorial!!


/* Swift String split */

//Hello Balu Tutorial!!

let stringList = testString.components(separatedBy: " ")
print(stringList.count)
print(stringList)






























