//
//  Task.swift
//  Karita
//
//  Created by Cookie-san on 2022/02/27.
//

import RealmSwift

class Task: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    
    // タイトル
    @objc dynamic var karimonoTitle = ""
    
    // 名前
    @objc dynamic var name = ""
    
    // 詳細
    @objc dynamic var detail = ""
    
    //確認
    @objc dynamic var isChecked = Bool()
    
    // 日時
    @objc dynamic var date = Date()
    
    // id をプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
