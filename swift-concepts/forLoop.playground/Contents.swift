//: Playground - noun: a place where people can play

import UIKit

let array = [8, 4, 8 , 1]

//allows us to access each individual item in the array through the number variable
for number in array {
    
    print(number)
    
}

// Create an array with 4 names of friends/family print "Hi there --- !"

let familyMembers = ["Rob", "Kirsten", "Tommy", "Ralphie"]

for familyMember in familyMembers {
    
    print ("Hi there " + familyMember + "!")
    
}

var numbers = [7, 2, 9, 4, 1]

//we look for two variables this time
//enumerated() spread it into its components
for (index, value) in numbers.enumerated() {
    
    numbers[index] += 1
    
}

print (numbers)

// array containing 8, 7, 19, 28. Halve each of the values

var myArray = [Double]()

myArray = [8, 7, 19, 28]

for (index, value) in myArray.enumerated() {
    
    myArray[index] = value / 2
    
}

print (myArray)






