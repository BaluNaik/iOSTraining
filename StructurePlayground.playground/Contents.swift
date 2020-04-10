import Foundation

/*
  Use struct keyword
  Syntax:
     struct structureName {
      members
      methods
    }
 */
/*
 To manage employee department we can enum
 - enum is a value type data and creates sequential constant of any type
 */

enum Department: String {
    
    case Tech = "Technology"
    case Admin = "Administrator"
    case Finance = "Finance"
    case Legal = "Legal"
    
}

enum test: Int {
    case Zero
    case One
    case Two
    case Three
}

struct Employee {
    
    private var empID: Int?
    internal var empName: String?
    public var empSalary: UInt?
    var empDept: Department = Department.Admin
    
    init(with id: Int, name: String, salary: UInt) {
        empID = id
        empName = name
        empSalary = salary
    }
    
    init(with id: Int, name: String, salary: UInt = 1200, dept:Department) {
        empID = id
        empName = name
        empSalary = salary
        empDept = dept
    }
    
    func printEmpInformation() {
        print("ID:\(empID!) Name:\(empName!) Salary:\(empSalary!) Dept:\(empDept)")
    }
    
}

let emp1 = Employee(with: 101, name: "Alex", salary: UInt(1200))
emp1.printEmpInformation()  //ID:101 Name:Alex Salary:1200 Dept:Admin

let emp2 = Employee(with: 102, name: "Wandy", dept: .Tech)
emp2.printEmpInformation()  //ID:102 Name:Wandy Salary:1200 Dept:Tech




