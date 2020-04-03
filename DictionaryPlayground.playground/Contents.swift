import Foundation

/* Creating a dictionary */

//Synatx: let dictionaryName:Dictionary<Key,ValuType> = [:]

let studentMarks:Dictionary<String,Int> = ["Raju": 430,
                                           "Kishore": 540,
                                           "Alex": 456,
                                           "Krish": 432]

let employeMobile:[String:String] = ["Alex": "123-1233444",
                                     "Krish": "000-348499",
                                     "Rajesh": "087-15679"]

var testDictionary = [1:10,
                      2:20,
                      3:30,
                      4: 40]

print(studentMarks.isEmpty) //false
print(studentMarks.count) // 4
print(studentMarks.keys)  // returns all kesy ["Alex", "Krish", "Raju", "Kishore"]

print(studentMarks["Alex"])  // getting values form dictionary  //prints 456

print(studentMarks["xyz"])  //prints nil

print(employeMobile.count)   //prints 3
print(employeMobile)   //["Rajesh": "087-15679", "Alex": "123-1233444", "Krish": "000-348499"]

print(testDictionary.keys)  //[2, 3, 1, 4]
testDictionary[10] = 100
testDictionary[6] = 60
print(testDictionary)

testDictionary.removeValue(forKey: 2)
print(testDictionary[2]) // prints nil

testDictionary.removeAll()
print(testDictionary.isEmpty)
print(testDictionary.count)


/* Swift Dictionary Properties and Functions */
//  1. remove
//  2. count
//  3. isEmpty
//  4. removeAll
//  4. keys

/* Iterating over a Swift Dictionary */

var countryCode:[String: Int] = [:]   // Empty dictionary creation

// var countryCode:Dictionary<String, Int> = [:]

countryCode["india"] = 91
countryCode["USA"] = 1
countryCode["UAE"] = 971
print(countryCode.keys)

countryCode["pakistan"] = 92
countryCode["bangladesh"] = 880
countryCode["srilanka "] = 94

for item in countryCode {
    print(item)  //key and value both
}

for item in countryCode {
    print("\(item.key) : \(item.value)")
}

for (index, item) in countryCode.enumerated() {
    print("\(index) : \(item.key): \(item.value)")
}

/* Getting first */

print(countryCode.first)
print(countryCode.removeValue(forKey: "USA"))

print(countryCode)

/* Merge Dictionary */

let employeName = ["Balu": "Naik",
                   "Rakesh": "Soft",
                   "Web": "Tutorial"]

var stduentName = ["One": "Puneet",
                   "Two": "Ramesh",
                   "Three": "Kabir",
                   "Four" : "Ankita"]

//let result = employeName + stduentName  Error

var result = employeName
result.merge(stduentName, uniquingKeysWith: +)  // 2nd one appending to first one with all keys
print(result)

print(result.keys) //["Four", "Web", "Balu", "Two", "One", "Three", "Rakesh"]

for item in result {
    print("Key: \(item.key) value:\(item.value)")
}

 /* Creating a Dictionary from two arrays */

let list1: [Int] = [10,20,30,40,50]
let list2: [Int] = [60,70,80,90]

let listDictionary:[String: [Int]] = ["list1": list1, "list2": list2]
print(listDictionary)

let resultList1 = listDictionary["list1"]
var resultString = ""
for value in resultList1 ?? [] {
    resultString += " \(value)"
}
print(resultString)

let resultList2 = listDictionary["list2"]
resultString = ""
for value in resultList2 ?? [] {
    resultString += " \(value)"
}
print(resultString)


 /* Creating a nested dictionary */

let names = ["first" : "One",
             "second": "Two",
             "Third": "Three"]

let mobile = ["iPhone" : "Apple",
              "Jeo": "Samsung",
              "Android": "Google"]

let myDictionary:[String: Dictionary<String, String>] = ["names" : names,
                                                         "mobile": mobile]
print(myDictionary)
/*
    ["mobile": ["Android": "Google",
                "Jeo": "Samsung",
                "iPhone": "Apple"],
    "names": ["second": "Two",
              "first": "One",
              "Third": "Three"]
    ]
 */

print(myDictionary["mobile"]?["iPhone"])  //Optional("Apple")
print(myDictionary["names"]?["first"])   //Optional("One")

for rootDictionary in myDictionary {
    //let subDictionary: Dictionary<String, String>? = rootDictionary.value
    for item in rootDictionary.value ?? [:] {
        print("\(item.key): \(item.value)")
    }
}

/* Handling Duplicate Keys */

//let websites: [String: String] = ["google": "www.google.com",
//                                  "fb": "www.facebook.com",
//                                  "website": "www.balututorial.com",
//                                  "website": "https://www.balututorial.com"]
//print(websites)  //Fatal error: Dictionary literal contains duplicate keys

//let websitesUrl = ["google": "www.google.com",
//                                  "fb": "www.facebook.com",
//                                  "website": "www.balututorial.com",
//                                  "website": "https://www.balututorial.com"]
//print(websitesUrl)  //Fatal error: Dictionary literal contains duplicate keys
//
//let uniqValues: Dictionary<String, String> = Dictionary(uniqueKeysWithValues: zip(websitesUrl, repeatElement(1, count: websitesUrl.count)))























