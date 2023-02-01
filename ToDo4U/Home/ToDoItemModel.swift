//
//  ToDoItemModel.swift
//  ToDo4U
//
//  Created by IFOCUS on 2/1/23.
//

import Foundation

class ToDoItemModel {
    var toDoDescription: String
    var isDone: Bool = false
    
    init(toDoDescription: String, isDone: Bool) {
        self.toDoDescription = toDoDescription
        self.isDone = isDone
    }
}
