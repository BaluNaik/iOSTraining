import Foundation

/* Creating an Array */

//Syntax:   let arrayName: [Type] = [value1, value2, value3,...]

let arrayOfInteger: [Int] = [10,20,30,40,50]
let arrayOfString: [String] = ["Balu", "Tutorial", ".com"]


/* Creating an empty array */

//Syntax: var arayName = [Type]()

var arrayOfFloat = [Float]()
var arrayOfString1 = [String]()


/* Creating an array with default values */

var arrayOfDefaultInteger: [Int] = Array(repeating: 5, count: 10) //default value is 5 for 10 elements

//Array is a class name here


/* Swift Array Length */
// Length alway returns no of elemts in collection type

print(arrayOfInteger.count)
print(arrayOfString.count)

print(arrayOfFloat.count)
print(arrayOfString1.count)
print(arrayOfDefaultInteger.count)
print(arrayOfDefaultInteger)  //[5, 5, 5, 5, 5, 5, 5, 5, 5, 5]

/* Element access */

print(arrayOfString) //["Balu", "Tutorial", ".com"]

print(arrayOfString[0])

print(arrayOfString[2])

print(arrayOfString[arrayOfString.count - 1])

/* Accessing the first and last elements of an array */

print(arrayOfString.first)

print(arrayOfString.last)




/* Empty status check */

print(arrayOfString.isEmpty)

print(arrayOfString1.isEmpty)

if !arrayOfString1.isEmpty {
    print(arrayOfString1[0])
}


/* Adding elements to an array */

print(arrayOfString1.count)
print(arrayOfString1.isEmpty)

arrayOfString1.append("www")  // index 0
arrayOfString1.append("balu")  //index 1
arrayOfString1.append("tutorials") //index 2
arrayOfString1.append("com") //index 3

print(arrayOfString1.count)
print(arrayOfString1.count)


/* Inserting and removing at a specified index */
arrayOfString1.insert(".", at: 1) //When we added this element positions are changed
arrayOfString1.insert(".", at: 4)
print(arrayOfString1)


/* Accessing and modifying a range of elements */

arrayOfString1.remove(at: 3)
//arrayOfString1.removeAll()  //delete every thing
print(arrayOfString1)

arrayOfString1.insert("tutorial", at: 3)
print(arrayOfString1)

arrayOfString1[3] = "tutorial"
print(arrayOfString1)



/* Find an element in Swift array */

print(arrayOfInteger.contains(40))  //true
print(arrayOfInteger.contains(100)) //false

print(arrayOfString.contains("balu"))  //false (Balu)
print(arrayOfString.contains(".com")) //true

//Note: The contains() function returns as soon as the first match is found

print(arrayOfInteger.contains(where: { $0 > 100 })) //return false???? We are asking my list values are > 100
print(arrayOfInteger.contains(where: { $0 > 10 })) //values are > 10

print(arrayOfInteger.contains(where: { $0 % 9 == 0 }))  // values % 9

/* Reverse an array in swift */

print(arrayOfInteger)
let reverseList:[Int] = arrayOfInteger.reversed()
print(reverseList)


/* Looping over an array */

for value in arrayOfInteger {
    print(value)
}

for stringValue in arrayOfString {
    print(stringValue)
}

for (index, value) in arrayOfDefaultInteger.enumerated() {
    print("index:\(index)-->\(value)")
}

for (index, value) in arrayOfString.enumerated() {
    print("index:\(index)-->\(value)")
}

for (index, value) in arrayOfInteger.enumerated() {
    print("index:\(index)-->\(value)")
}

/* Combining and comparing two arrays */

let array1:[Int] = [7,8,1,4,2]
let array2:[Int] = [5,9,6]

//let resultArray = array1 + array2

var resultArray:[Int] = Array(array1)
resultArray.append(contentsOf: array2)

print(resultArray)

let sortedlist = resultArray.sorted()
print(sortedlist)

let list = resultArray.map { (value) -> Int? in
//    if value < 5 {
//
//        return value
//    } else {
//
//        return nil
//    }
    
    return value < 5 ? value : nil  //[7, 8, 1, 4, 2, 5, 9, 6]
}
print(list)

//let list1 = resultArray.filter { (value) -> Bool in
//
//    return value > 5
//}
//print(list1)

//let list2 = resultArray.map { (value) -> Int? in
//
//    return value < 5 ? value : nil  //[7, 8, 1, 4, 2, 5, 9, 6]
//}.compactMap({ $0 })
//
//print(list2)

/* Swift Multidimensional Array */

var list1: [Int] = [1,2,3,4]
var list2: [Int] = [10,20,30,40]
var list3: [Int] = [100,200,300]

var multiArra = [[Int]]()
multiArra.append(list1)
multiArra.append(list2)
multiArra.append(list3)
print(multiArra)  //[[1, 2, 3, 4], [10, 20, 30, 40], [100, 200, 300]]

for subList in multiArra {
    var result = ""
    for value in subList {
        result += "\(value) "
    }
    print(result)
}
//1 2 3 4
//10 20 30 40
//100 200 300


var testArray:[Int] = [10,20,30,40,50]

print(testArray.count) //prints 5
//testArray[0] = 0
//testArray[1] = 0
//testArray[2] = 0

testArray[...2] = [0,0,0]  //One-Sided Ranges (...upperLimit)
print(testArray)   //[0, 0, 0, 40, 50]

testArray[3...] = [-5,-5,-5,-5,-5,-5]  //One-Sided Ranges (lowerLimit...)
print(testArray)         // 1...10    1 -> 10  closed range
                         // 1..<10    1 --> 9 half closed range operation

 

















