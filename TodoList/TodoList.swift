//
//  TodoList.swift
//  TodoList
//
//  Created by 최혜선 on 2017. 9. 25..
//  Copyright © 2017년 최혜선. All rights reserved.
//

import Foundation

struct TodoList {
    var title: String = ""
    var content: String = ""
    
    var inputTitle: String{
        get{
            return title
        }
        set{
            title = newValue
        }
    }
    
    var inputContent: String{
        get{
            return content
        }
        set{
            content = newValue
        }
    }
}
