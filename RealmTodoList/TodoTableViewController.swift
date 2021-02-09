//
//  TodoTableViewController.swift
//  RealmTodoList
//
//  Created by dwKang on 2021/02/08.
//

import UIKit
import RealmSwift

class TodoTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var list: Results<Todo>!
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        list = realm.objects(Todo.self)
        
        token = NotificationCenter.default.addObserver(forName: AddViewController.newTodoDisInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        
        // Todo
        cell.todoLabel.text = list[indexPath.row].todo
        
        // 등록일 YY/MM/dd 형식으로 포멧
        let regDate: Date = list[indexPath.row].reg_date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        
        cell.regDateLabel.text = dateFormatter.string(from: regDate)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "삭제하시겠습니까?", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { [self] (UIAlertAction) in
                if let item = list?[indexPath.row] {
                    try! realm.write {
                        realm.delete(item)
                    }
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
            alert.addAction(okAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
}
