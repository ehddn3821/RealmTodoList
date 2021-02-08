//
//  AddViewController.swift
//  RealmTodoList
//
//  Created by dwKang on 2021/02/08.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    let realm = try! Realm()

    @IBOutlet var todoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // Cancel
    @IBAction func cancelClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // Add Todo
    @IBAction func saveClicked(_ sender: UIBarButtonItem) {
        let todo = Todo(todo: todoTextView.text)
        
        try! realm.write {
            realm.add(todo)
        }
    }
}
