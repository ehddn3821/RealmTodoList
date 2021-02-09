//
//  AddViewController.swift
//  RealmTodoList
//
//  Created by dwKang on 2021/02/08.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    @IBOutlet var todoTextView: UITextView!
    
    let realm = try! Realm()
    
    static let newTodoDisInsert = Notification.Name(rawValue: "newTodoDisInsert")
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // Cancel
    @IBAction func cancelClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // Add Todo
    @IBAction func saveClicked(_ sender: UIBarButtonItem) {
        
        // 아무것도 입력하지 않았을때
        guard let todo = todoTextView.text, todo.count > 0 else {
            let alert = UIAlertController(title: "Todo를 입력해주세요.", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil )
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
       
        let newTodo = Todo(value: [
            "id" : Todo().autoIncrementId(),
            "todo" : todoTextView.text!,
            "reg_date" : Date()
        ])
        
        try! realm.write {
            realm.add(newTodo)
        }
        
        NotificationCenter.default.post(name: AddViewController.newTodoDisInsert, object: nil)
        
        dismiss(animated: true, completion: nil)
    }
}
