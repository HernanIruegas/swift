//: Playground - noun: a place where people can play

import UIKit

let age = 13

// Greater than or equal to

if age >= 18 {
    
    print ("You can play!")
    
} else {
    
    print ("You're too young")
    
}

// Check username

let name = "rob"

if name == "rob" {
    
    print ("Hi " + name + "! You can play")
    
} else {
    
    print ("Sorry, " + name + ", you can't play")
    
}

// 2 If Statements With And

if name == "rob" && age >= 18 {
    
    print("you can play")
    
} else if name == "rob" {
    
    print("Sorry Rob, you need to get older")
    
}

// 2 If Statements With Or

if name == "rob" || name == "kirsten" {
    
    print ("Welcome " + name)
    
}

// Booleans With If Statements

let isMale = true

if isMale {
    
    print("You're male!")
    
}

// Login system. username/password variables. 1. They are correct 2. They are both wrong 3. Username is wrong 4. Password is wrong

let username = "robpercival"

let password = "myPass"

if username == "robpercival" && password == "myPass" {
    
    print ("You're in!")
    
} else if username != "robpercival" && password != "myPass" {
    
    print ("Both username and password are wrong")
    
} else if username == "robpercival" {
    
    print ("Password is wrong")
    
} else {
    
    print ("Username is wrong")
    
}

















