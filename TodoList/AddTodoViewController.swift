//
//  AddTodoViewController.swift
//  TodoList
//
//  Created by 최혜선 on 2017. 9. 25..
//  Copyright © 2017년 최혜선. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBAction func addListItemAction(_ sender: Any) {
        let todoItem: TodoList = TodoList(title: titleTextField.text!, content: contentTextView.text, isComplete: false)
        
        print("Add List title : \(todoItem.title)")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentTextView.layer.borderColor = UIColor.gray.cgColor
        contentTextView.layer.borderWidth = 0.1
        contentTextView.layer.cornerRadius = 1.0
        contentTextView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
