//
//  TodoModel.swift
//  RealmTodoList
//
//  Created by dwKang on 2021/02/08.
//

import Foundation
import RealmSwift

class Todo: Object {
    @objc dynamic var id: Int = 0  // PK
    @objc dynamic var todo: String = ""  // todo(NN)
    @objc dynamic var regDate: Date = Date()  // 등록일(NN)
    @objc dynamic var isComplete: Bool = false  // 완료체크(NN)
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // PrimaryKey AutoIncrement
    func autoIncrementId() -> Int {
        let realm = try! Realm()
        
        if let retNext = realm.objects(Todo.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        } else {
            return 0
        }
    }
}
