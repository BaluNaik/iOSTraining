import Foundation


// Declaring a set
//Syntax: let setName:Set<DataType> = [values]

//let setName:Set<DataType> = Set()

// let setName = Set<DataType>()

let stringSet = Set<String>()    //Empty set

print(stringSet.isEmpty)  // true
print(stringSet.count)    // 0

let colorSet: Set = ["Red", "Yellow", "Green", "Red"]
print(colorSet.isEmpty)  //false
print(colorSet.count)    // 3

print(colorSet) // ["Yellow", "Red", "Green"]


/* Inserting and Removing Elements from a Set */

//colorSet.insert("Blue") // Error: its immutable cant change (because of let)

var numberWordsSet = Set<String>()

print(numberWordsSet.count) // 0

numberWordsSet.insert("One")
numberWordsSet.insert("Three")
numberWordsSet.insert("Two")
print(numberWordsSet.count) //3
print(numberWordsSet)   // ["Three", "Two", "One"]

print(numberWordsSet.contains("Four"))  // false
print(numberWordsSet.contains("One"))   //true

//numberWordsSet.insert(100)  // Error ---> type check

print(numberWordsSet.remove("Four")) //returning nil
print(numberWordsSet.remove("One")) //removed and returns removed object
print(numberWordsSet.count) // 2

numberWordsSet.removeAll()
print(numberWordsSet.count) // 0


var integerSet: Set<Int> = [10,20,30,40,50,40]

let xValue = integerSet.remove(20)
print(xValue)   // Optional(20)

let yValue = integerSet.remove(100)
print(yValue)   // nil (remove method always returns Optional value)

let firstObjectIndex = integerSet.firstIndex(of: 40)
//print(firstObjectIndex)
if let objectIndex = firstObjectIndex {
    print(objectIndex)  //hasValue
    integerSet.remove(at: objectIndex)
}
print(integerSet)  //[10, 30, 50]



/* Find an element in a set */

print(integerSet.contains(50))

/* The capacity of the set */

print(integerSet.count)



/* Creating a Set from an Array */

let intArray: [Int] = [10,20,30]

let verSet1: Set<Int> = Set(intArray)
print(verSet1)   // [30, 10, 20]

let verSet2: Set<Int> = Set([40, 50,60])
print(verSet2)

let monthsArray = ["Jan", "Feb", "Mar"]
let stringSet1 = Set(monthsArray)

print(stringSet1)  //["Feb", "Jan", "Mar"]


let sequenceSet = Set<Int>(1..<10)
print(sequenceSet)



/* Iterating over a set */

let newSetString: Set<String> = ["www", "balututorial", "com"]

for word in newSetString  {
    print(word)
}



/* Sorting the set */

let sequenceSet1 = Set<Int>(1...10)
print(sequenceSet)  //[7, 9, 2, 1, 3, 5, 8, 6, 4]

for word in sequenceSet1.sorted() {
    print(word)
}

for word in newSetString.sorted() {
    print(word)
}


/* Swift Set Operations */

//1. Subset and Superset

var setA: Set<String> = ["A", "B", "C", "D", "E"];
var setB: Set<String> = ["C", "D", "E"];
var setC: Set<String> = ["A", "B", "C", "D", "E"];

print(setB.isSubset(of: setA)) // true
print(setB.isStrictSubset(of: setA)) // true

print(setC.isSubset(of: setA)) // true

var setD: Set<String> = ["F", "G"]

setD.isDisjoint(with: setA) //true (no nay elements are common)































