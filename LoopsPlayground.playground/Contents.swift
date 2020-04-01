import Foundation

/* While loop Example (print even numbers from 2 - 20) */

var iValue = 2
let maxValue = 20

/* while iValue <= maxValue {
    print("\(iValue)")
    iValue += 2 // ivalue = iValue + 2
} */

//String interpolation (placing any other type within string)

var result = ""
while iValue <= maxValue {
    result = result + "\(iValue)" + " "
    iValue = iValue + 2 // iValue += 2
}
print(result)


/* Working with for - in */

result = ""

for iValue in 2...20 {  // closed range
    result += "\(iValue)" + " "
}
print(result)

result = ""

for iValue in 2..<20 {   //half range
    result += "\(iValue)" + " "
}
print(result)

/* repeat- while (same as do-while) */
// once statement will executed without checking condition

var xValue = 10

repeat {
    print(xValue)
    xValue += 2
} while xValue < 5


/* Swith in for-in loop */

for value in 1...20 {
    switch value {
    case 1...20 where value % 2 == 0:
         print("Even:\(value)")
    case 1...20 where value % 3 == 0:
         print("Other:\(value)")
    default:
        ()
    }
}






