//
//  UserViewModel.swift
//  MVVM_sample
//
//  Created by leewonseok on 2023/03/17.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published private var users = [
        User(name: "kim", age: 22),
        User(name: "lee", age: 11),
        User(name: "lim", age: 44)
    ]
    
    var userCount: Int {
        users.count
    }
    func user(index: Int) -> User {
        return users[index]
    }
    
    func userName(index: Int) -> String {
        return users[index].name
    }
    
    func userAge(index: Int) -> String {
        return users[index].age.description
    }
    
    func createUser(name: String, age: Int) {
        let newUser = User(name: name, age: age)
        self.users.append(newUser)
    }
    
    func updateUser(id: UUID, name: String, age: Int) {
        if let selectedIndex = users.firstIndex(where: { id == $0.id }) {
            users[selectedIndex].name = name
            users[selectedIndex].age = age
        }
    }
    
    func deleteUser(id: UUID) {
        if let selectedIndex = users.firstIndex(where: { id == $0.id }) {
            users.remove(at: selectedIndex)
        }
    }
}
