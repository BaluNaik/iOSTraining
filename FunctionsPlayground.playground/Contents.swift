import Foundation

/* Function */

/*
 - Functions are self-contained chunks of code that perform a specific task.
 - Functions let you define re-usable pieces of code that perform specific pieces of functionality.
 - Usually functions are able to receive some values to modify the way they work, but it's not required.
 */

/* Defining the function */

/*
    func functionName(parameters) -> returnType {
     function body
     return statement
 }
 
 */

/* No argument and no return type */

func testFunction() {
    print("Hello Function!!!")
}

testFunction()  // calling


/* No argumrnt with return type */

func getIntegerValue() -> Int {
    
    return 100
}

let xValue = getIntegerValue()
print("xValue=\(xValue)")  // xValue=100


/* with arguments and no return type */

func printSumValue(value1: Int, value2:Int) {
    print("sum value=\(value1+value2)")
}

printSumValue(value1: 10, value2: 20)
// We have paramets name


func sumValue(_ value1:Int, _ value2: Int) {
     print("sum value=\(value1+value2)")
}
sumValue(10, 20)
//We dont have any paramets name


func printMessage(message msg1: String, welcomeNote note: String) {
    
    print("\(msg1) \(note)")
}

printMessage(message: "Hello", welcomeNote: "Welcome")
/* Internal and extranal parameters naming
   1. message and welcomeNote are extranal
   2. msg1 and note is interal names
 */


/* With parameters and return type */

func getSumValue(value1: Int, integerValue value2:Int) -> Int {
    
    return value1 + value2
}

let sum = getSumValue(value1: 10, integerValue: 20)
print("Sum value=\(sum)") //Sum value=30

/* inout type */

/*func swap(value1: Int, value2:Int) {
    var temp = value1
    value1 = value2
    value2 = temp
}*/

func swap(value1: Int, value2:Int) -> (Int, Int) {   // function returning tuple
    var temp: Int = 0
    var v1: Int = value1
    var v2: Int = value2
    
    temp = value1
    v1 = v2
    v2 = temp
    
    return (v1, v2)
}
var x: Int = 10
var y: Int = 20

var result = swap(value1: x, value2: y)
x = result.0
y = result.1
print("x=\(x) y=\(y)")


/* How to use inout */

func swapInteger(_ x: inout Int, _ y: inout Int) {
    let temp = x
    x = y
    y = temp
}

var integerValue1: Int = 10
var integerValue2: Int = 20
swapInteger(&integerValue1,&integerValue2)

print("value1:\(integerValue1) value2:\(integerValue2)") //value1:20 value2:10


/* Default Parameter Values */

func sumOfInteger(value1: Int, value2: Int = 20) -> Int {
    
    return (value1 + value2)
}
let sum1 = sumOfInteger(value1: 10)   // return 10 + 20
let sum2 = sumOfInteger(value1: 10, value2: 30) // return 10 + 30

print("sum1:\(sum1) sum2:\(sum2)") //sum1:30 sum2:40


/* Variadic Parameters */
// Argument list or arg list
//by using this approch we can pass 'n' no of paramets to a function
// its required ...(3 dots)

func printSentence(words: String...) -> String {
    var sentence = ""
    for word in words {
        sentence = sentence + " " + word
    }
    
    return sentence
}
print(printSentence(words: "Hello", "Welcome", "to", "Balu", "Tutorial"))
//Hello Welcome to Balu Tutorial



/* Nested Functions */
// function within the function

func mainFunction() {
    print("i'm in mainFunction ")
    
    func nestedFunction() {
        print("i'm in nested function")
    }
    nestedFunction()
}
mainFunction()


/* Functions can take optinal type and retuns optinal also */

func findMaxOfList(list: [Int]?) -> Int? {
    var result: Int?
    result = 0
    if let listData = list {  // optinal binding
        for value in listData {
            if value > result ?? 0 {
                result = value
            }
            // result = value > result ? value : result
        }
    }
    
    return result
}

let maxValue = findMaxOfList(list: [10,20,60,50,30]) // function returning int?
print(maxValue ?? 0)




















