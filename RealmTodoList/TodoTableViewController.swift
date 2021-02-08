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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        list = realm.objects(Todo.self)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Todo
        cell.textLabel?.text = list[indexPath.row].todo
        
        // 등록일 YY/MM/dd 형식으로 포멧
        let regDate: Date = list[indexPath.row].reg_date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        
        cell.detailTextLabel?.text = dateFormatter.string(from: regDate)
        
        return cell
    }
    
}
