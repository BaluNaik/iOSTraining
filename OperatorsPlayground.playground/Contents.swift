import Foundation

var aValue: Int? = 10
var bValue: Int = 20
var sumValue: Int?

//sumValue = aValue! + bValue //No we can't do like this

sumValue = (aValue ?? 0) + bValue
print(sumValue!)

aValue = nil
sumValue = (aValue ?? 40) + bValue
// op_variable ?? default_value(if op is nill it returns default value)
print(sumValue!)

/* simple if-else stement */

let xValue = 10
let yValue = 20
let zValue = 30
var maxValue: Int?

/* if xValue > yValue && xValue > zValue {
    maxValue = xValue
} else if yValue > zValue {
    maxValue = yValue
} else {
    maxValue = zValue
} */
// Conditional operator or ternary
maxValue = xValue > yValue && xValue > zValue ? xValue : yValue > zValue ? yValue : zValue


print("Max Value:\(maxValue ?? 0)")

if maxValue != nil {
    print("Max Value:\(maxValue ?? 0)")
}

/*
    && T,T---> T   T,F or F,T or F F ----> F
    || TT, TF, FT ---> T     FF---> F
    !   ---> if True ---> FALSE    if FALAS ---> TRUE
    
 */

/* Working with switch statement */

let deviceName = "iPhone"

switch deviceName {
case "iPhone":
    print("It's iPhone")
    //fallthrough
case "iPad":
    print("It's iPad")
    //fallthrough
case "MacBook":
    print("it's MackBook")
    //fallthrough
default:
    print("No any device!!!!")
}
/*
 1. Every switch statement must have default(else error)
 2. Switch statement can take any kind of argument (but in c only integer)
 3. Case can be combine with multiple condition / exp / tuple also
 4. Nested condition also possible with "where" keyword
 5. in c or other lanaguges from matching case untill break is occured every thing will prints(but in swift only matching case will print)
 6. in-order print next statements we have to use "fallthrough"
 */

let myCode: Character = "d"
switch myCode {
case "a", "b", "c", "d":
    print("Alpha char's abcd")
case "i":
    print("Its matching case")
default:
    ()
}









