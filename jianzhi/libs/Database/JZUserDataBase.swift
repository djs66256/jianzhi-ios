//
//  JZMessageDataBase.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserDataBase: JZDataBase {
    static let sharedDataBase = JZUserDataBase()
    
    override func dbPath() -> String? {
        let path = JZPath.userPath("db", file: "user.db")
        return path
    }
    
    override func prepareDatabase() {
        let sqls = [
            "CREATE TABLE IF NOT EXISTS message (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "uid INTEGER," +
                "gid INTEGER," +
                "uuid CHAR(32)," +
                "text TEXT," +
                "date DATE," +
                "type INTEGER," +
                "uploaded BOOL," +
                "readed BOOL" +
            ");",
            "CREATE TABLE IF NOT EXISTS user (" +
                "id INTEGER PRIMARY KEY," +
                //            "username TEXT," +
                "nickname TEXT," +
                "headimage TEXT," +
                "description TEXT," +
                "gender CHAR(1)," +
                "user_type INTEGER," +
                "update_date DATE" +
            ");",
            "CREATE TABLE IF NOT EXISTS message_group (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "title TEXT," +
                "type INTEGER," +
                "uid INTEGER," +
                "rid INTEGER," +
                "create_date DATE" +
            ");"
        ]
        
        sqls.forEach { update($0) }
    }
    
    func insertMessage(message: JZMessage) {
        let sql = "INSERT INTO message" +
            " (uid, gid, uuid, text, date, type, uploaded, readed)" +
        " VALUES (:uid, :gid, :uuid, :text, :date, :type, :uploaded, :readed);"
        let params : [String: AnyObject] = [
            "uid": message.user.uid,
            "gid": message.group.id,
            "uuid": message.uuid,
            "text": message.text,
            "date": message.date,
            "type": message.type.rawValue,
            "uploaded": message.uploaded,
            "readed": message.readed]
        
        update(sql, params)
    }
    
    func insertUser(user: JZUserInfo) {
        let sql = "INSERT INTO user" +
        " (id, nickname, headimage, description, gender, user_type)" +
        " VALUES (:id, :nickname, :headimage, :description, :gender, :userType)"
        let params : [String:NSObject] = [
            "id": user.uid,
            "nickname": user.nickName ?? "",
            "headimage": user.headImage ?? "",
            "description": user.descriptions ?? "",
            "gender": user.gender.rawValue,
            "userType": user.userType.rawValue
        ]
        
        update(sql, params)
    }
    
    func findUserById(uid: Int, callback: (JZUserInfo?)->Void){
        let sql = "SELECT id, nickname, headimage, description, gender, user_type"
            + " FROM user"
            + " WHERE id=:id"
        let params = ["id": uid]
        queryAll(sql, params: params, unpack: { (result:FMResultSet) -> JZUserInfo? in
            let uid = Int(result.intForColumn("id"))
            let user = JZUserInfo(uid: uid, userName: "")
            user.nickName = result.stringForColumn("nickname")
            user.headImage = result.stringForColumn("headimage")
            user.descriptions = result.stringForColumn("description")
            user.gender = JZGenderType(rawValue: result.stringForColumn("gender")) ?? .unknow
            user.userType = JZUserType(rawValue: Int(result.intForColumn("user_type"))) ?? .unknow
            return user
            }, callback: { callback($0.first) })
        
    }
    
    func insertMessageGroup(group: JZMessageGroup) {
        let sql = "INSERT INTO message_group"
            + " (title, type, uid, rid, create_date)"
            + " VALUES (:title, :type, :uid, :rid, :create_date)"
        let params = [
            "title": group.title,
            "type": group.type.rawValue,
            "uid": group.user?.uid ?? 0,
            "rid": 0,
            "create_date": group.createDate
        ]
        
        update(sql, params)
    }
    
    func updateMessageGroup(group: JZMessageGroup) {
        let sql = "UPDATE message_group"
            + " SET title=:title, date=:date"
            + " WHERE id = :gid"
        let params : [String:NSObject] = [
            "title": group.title,
            //            "date": group.date,
            "gid": group.id
        ]
        update(sql, params)
    }
    
    func updateMessage(message: JZMessage) {
        JZLogInfo("[ERROR] no message need update")
    }
    
    func saveMessage(message:JZMessage) {
        if message.id == 0 {
            insertMessage(message)
        }
        else {
            updateMessage(message)
        }
    }
    
    func findMessageById(id: Int, callback: (JZMessage)->Void) {
        let sql = "select * from message"
    }
    
    func findMessageByUUID(uuid: String, callback: (JZMessage)->Void) {
    }
    
    func findMessageByGroup(group: JZMessageGroup, index: Int, count: Int, callback: ([JZMessage])->Void) {
        let sql = "SELECT m.id AS mid, m.gid AS mgid, m.uuid AS muuid, m.text AS mtext, m.date AS mdate, m.type AS mtype, m.uploaded AS muploaded, m.readed AS mreaded, " +
        "u.id AS uid, u.nickname AS unickname, u.description AS udescriptions, u.gender AS ugender, u.user_type AS utype " +
        "FROM message m JOIN user u ON m.uid=u.id " +
        "WHERE m.gid=:gid " +
        "LIMIT :index, :count;"
        let params = ["gid": group.id, "index": index, "count": count]
        
        queryAll(sql, params: params, unpack: { (result:FMResultSet) -> JZMessage? in
            
            let userType = JZUserType(rawValue: Int(result.intForColumn("utype"))) ?? JZUserType.unknow
            let user : JZUserInfo
            switch userType {
            case .jobseeker: user = JZJobseekerUserInfo()
            case .boss: user = JZBossUserInfo()
            default: user = JZUserInfo()
            }
            user.uid = Int(result.intForColumn("uid"))
            user.nickName = result.stringForColumn("unickname")
            user.descriptions = result.stringForColumn("udescriptions")
            user.gender = JZGenderType(rawValue: result.stringForColumn("ugender")) ?? JZGenderType.unknow
            
            let mid = Int(result.intForColumn("mid"))
            let uuid = result.stringForColumn("muuid")
            let mtext = result.stringForColumn("mtext")
            let mdate = result.dateForColumn("mdate")
            let mtype = JZMessageType(rawValue: Int(result.intForColumn("mtype"))) ?? JZMessageType.None
            
            let message = JZMessage(id: mid, uuid: uuid, user: user, text: mtext, date: mdate, type: mtype, group: group)
            message.uploaded = result.boolForColumn("muploaded")
            message.readed = result.boolForColumn("readed")
            return message
            }, callback: callback)
    }
    
    func findGroups(callback:([JZMessageGroup])->Void) {
        let sql = "SELECT" + groupQueryItems + "," + userQueryItems
        + " FROM message_group"
        + " LEFT JOIN user ON user.id=message_group.uid"
        queryAll(sql, params: nil, unpack: { (result) -> JZMessageGroup? in
            if let group = self.unpackGroup(result) {
                group.user = self.unpackUser(result)
                return group
            }
            return nil
            }, callback: callback)
    }
    
    func findGroupByToUser(toUser: JZUserInfo, callback:(JZMessageGroup?)->Void) {
        let filter = "WHERE g.type=:gtype AND u.id=:uid"
        let params = [
            "gtype": JZMessageGroupType.Person.rawValue,
            "uid": toUser.uid]
        findGroupByFilter(filter, params: params) { (groups:[JZMessageGroup]) -> Void in
            callback(groups.first)
        }
    }
    
    func findGroupByFilter(filter:String, params:[String:AnyObject], callback:([JZMessageGroup])->Void) {
        let sql = "SELECT id, title, type, uid, rid, create_date FROM message_group g LEFT JOIN user u ON u.id=g.uid " + filter
        queryAll(sql, params: params, unpack: { (result) -> JZMessageGroup? in
            let group = JZMessageGroup()
            group.id = Int(result.intForColumn("id"))
            group.title = result.stringForColumn("title")
            return group
            }, callback: callback)
    }
    
    let userQueryItems = " user.id AS uid, user.nickname AS unickname, user.description AS udescriptions, user.gender AS ugender, user.user_type AS utype "
    func unpackUser(result:FMResultSet) -> JZUserInfo? {
        let user : JZUserInfo
        let userType = JZUserType(rawValue: Int(result.intForColumn("utype"))) ?? JZUserType.unknow
        switch userType {
        case .jobseeker: user = JZJobseekerUserInfo()
        case .boss: user = JZBossUserInfo()
        default: user = JZUserInfo()
        }
        user.uid = Int(result.intForColumn("uid"))
        user.nickName = result.stringForColumn("unickname")
        user.descriptions = result.stringForColumn("udescriptions")
        user.gender = JZGenderType(rawValue: result.stringForColumn("ugender") ?? "u") ?? JZGenderType.unknow
        
        return user
    }
    
    let groupQueryItems = " message_group.id AS gid, message_group.title AS gtitle, message_group.type AS gtype, message_group.uid AS guid, message_group.rid AS grid, message_group.create_date AS gcreate_date "
    func unpackGroup(result: FMResultSet) -> JZMessageGroup? {
        let group = JZMessageGroup()
        group.id = Int(result.intForColumn("gid"))
        group.title = result.stringForColumn("gtitle")
        
        return group
    }
}
