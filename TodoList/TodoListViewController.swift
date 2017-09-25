//
//  ViewController.swift
//  TodoList
//
//  Created by 최혜선 on 2017. 9. 25..
//  Copyright © 2017년 최혜선. All rights reserved.
//

import UIKit
// 할일 저장 리스트 (전역변수)
var list = [TodoList]()

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var todoListTableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTap))
    
    // done 버튼 tap시 수정모드 종료
    @objc
    func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = editButton
        todoListTableView.setEditing(false, animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        // 리스트 비어있을 때 return
        guard !list.isEmpty else {
            return
        }
        self.navigationItem.leftBarButtonItem = doneButton
        todoListTableView.setEditing(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        
        loadAllData()
        print(list.description)
        
        doneButton.style = .plain
        doneButton.target = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        saveAllData()
        todoListTableView.reloadData()
    }
    
    // userdefault 저장
    func saveAllData() {
        let data = list.map {
            [
                "title": $0.title,  // $0 : 0번부터
                "content": $0.content!,
                "isComplete": $0.isComplete
            ]
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "items")
        userDefaults.synchronize()
    }
    
    func loadAllData() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else {
            return
        }
        
        print(data.description)
        
        // list 배열에 저장하기
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].title
        cell.detailTextLabel?.text = list[indexPath.row].content
        if list[indexPath.row].isComplete {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // 수정모드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        todoListTableView.reloadData()
    }
    
    // 리스트 선택시 완료된 일로 표시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 이미 체크되있는 경우 return
        guard !list[indexPath.row].isComplete else {
            return
        }
        
        // 리스트 선택 시 완료된 할일 표시(checkmark)
        list[indexPath.row].isComplete = true
        
        let dialog = UIAlertController(title: "Todo List", message: "일을 완료했습니다!!!!!", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
        dialog.addAction(action)
        self.present(dialog, animated: true, completion: nil)
        
        todoListTableView.reloadData()
    }
}

