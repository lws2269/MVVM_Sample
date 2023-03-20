//
//  UserViewModel.swift
//  MVVM_sample
//
//  Created by leewonseok on 2023/03/17.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var users = [
        User(name: "kim", age: 22),
        User(name: "lee", age: 11),
        User(name: "lim", age: 44)
    ]
    
    var canceleables = Set<AnyCancellable>()
    
    
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
    
    /// cell의 index를 받아 변경을 주는 로직
    func bindUserName(index: Int, completion: @escaping (String) -> Void) {
        $users.filter { $0.count > index }.sink { users in
            completion(users[index].name)
        }.store(in: &canceleables)
    }
    
    func bindUserAge(index: Int, completion: @escaping (String) -> Void) {
        $users.filter { $0.count > index }.sink { users in
            completion(users[index].age.description)
        }.store(in: &canceleables)
    }
    
    /// cell의 정보를 받아 처리하는 func
    func bindUserName(index: Int, store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $users.filter { $0.count > index }.sink { users in
            print("name sink")
            completion(users[index].name)
        }.store(in: &store)
    }
    
    func bindUserAge(index: Int, store: inout Set<AnyCancellable>, completion: @escaping (String) -> Void) {
        $users.filter { $0.count > index }.sink { users in
            completion(users[index].age.description)
        }.store(in: &store)
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
