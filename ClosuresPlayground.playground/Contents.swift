import Foundation

/* Closures in Swift
 
 Syntax:
          { (parameters) -> returnType in
                Closures body
          }
 
 */

// Ex1: Simple Closure

// This Simple Closure does't have any parameters and return type
let helloWorld = {
     print("Hello World!!!")
}

helloWorld()  // closure calling


// Ex1: Closure that accepts parameter
// This will take string parameter and not returning any thing

/*
 let printMessage: (String) -> () = { (name) in
    print(name)
} */

let printMessage: (String) -> () = { (name) in
    print(name)
}

printMessage("Hello World!!")
printMessage("Welcome to balututorial.com")

//Hello World!!
//Welcome to balututorial.com

// Ex3: Closure that returns value

/* let ammendString:(String, String) -> (String) = {(str1, str2) in
    
    return (str1 + str2)
} */
let ammendString:(String, String) -> (String) = { return $0 + $1 }

print(ammendString("Hello", "World!!!!"))  //HelloWorld!!!!

//Ex2:

/*
 let sumValue:(Int, Int) -> (Int) = {(valu1, value2) in
    
    return (valu1 + value2)
} */

let sumValue:(Int, Int) -> (Int) = { return $0 + $1 }

print("Sum value:\(sumValue(10, 20))") //Sum value:30



// Passing Closures as a function parameter

var addSq:(Int,Int) -> (Int) = { return ($0*$0 + $1*$1) }

func operationMath(a:Int, b:Int, myClosures: (Int, Int) -> Int) -> Int {
    
    return myClosures(a,b)
}
// What is function is doing????
// This function takes 2 int argument and a closure
// closure takes this 2 argument and return an integer value
// what value is returning from closure same value will return back from function

print("Result:\(operationMath(a: 2, b: 3, myClosures: addSq))")
//Result:13   (2*2 + 3*3) ---> 4 + 9


// Trailing Closures
//When we are passing closure as a last parameter to a function its called Trailing Closures

func sumOfExponential(from: Int, to:Int, closure:(Int) -> Int) -> Int {
    var sum = 0
    for i in from...to {
        sum = sum + closure(i)
    }
    
    return sum
}

print(sumOfExponential(from: 0, to: 5, closure: { $0 })) // 0 + 1 + 2 + 3 + 4 + 5 = 15

print(sumOfExponential(from: 0, to: 10, closure: { $0 })) //55





