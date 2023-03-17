//
//  Model.swift
//  MVVM_sample
//
//  Created by leewonseok on 2023/03/16.
//

import Foundation

struct User {
    var id: UUID
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.id = UUID()
        self.name = name
        self.age = age
    }
}

struct Users {
    var info: [(name:String, age:Int)] = [("kim", 23), ("lee", 33), ("min", 15)]
}
