//
//  JZMessageDataBase.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserDataBase: JZDataBase {
//    static let sharedDataBase = JZUserDataBase()
    
//    override func dbPath() -> String? {
//        let path = JZPath.userPath("db", file: "user.db")
//        return path
//    }
    
    override func prepareDatabase() {
        let sqls = [
            "CREATE TABLE IF NOT EXISTS message (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "from_uid INTEGER," +
                "to_uid INTEGER," +
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
                "avatar TEXT," +
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
            " (from_uid, to_uid, gid, uuid, text, date, type, uploaded, readed)" +
        " VALUES (:from_uid, :to_uid, :gid, :uuid, :text, :date, :type, :uploaded, :readed);"
        let params : [String: AnyObject] = [
            "from_uid": message.fromUser!.uid,
            "to_uid": message.toUser!.uid,
            "gid": message.group!.id,
            "uuid": message.uuid,
            "text": message.text,
            "date": message.date ?? "NULL",
            "type": message.type.rawValue,
            "uploaded": message.uploaded,
            "readed": message.readed]
        
        update(sql, params)
    }
    
    func setMessageReadedByGroup(gid: Int) {
        let sql = "UPDATE message SET readed=:readed WHERE gid=:gid"
        let params: [String: AnyObject] = [
            "gid": gid,
            "readed":true
        ]
        update(sql, params)
    }
    
    func unreadMessageCountByGroup(group: JZMessageGroup, callback:(Int)->Void) {
        
    }
    
    func setMessageUploaded(uuid: String) {
        if uuid.isEmpty { return }
        let sql = "UPDATE message SET uploaded=:uploaded WHERE uuid=:uuid"
        let params: [String: AnyObject] = ["uuid": uuid, "uploaded": true]
        update(sql, params)
    }
    
    func removeMessageByUuid(uuid: String) {
        if uuid.isEmpty { return }
        let sql = "DELETE FROM message"
            + " WHERE uuid=:uuid"
        let params = ["uuid": uuid]
        update(sql, params)
    }
    
    func insertUser(user: JZUserInfo, ignoreIfExists: Bool) {
        let sql = "INSERT OR \(ignoreIfExists ? "IGNORE" : "REPLACE") INTO user" +
        " (id, nickname, avatar, description, gender, user_type)" +
        " VALUES (:id, :nickname, :avatar, :description, :gender, :userType)"
        let params : [String:NSObject] = [
            "id": user.uid,
            "nickname": user.nickName ?? "",
            "avatar": user.avatar ?? "",
            "description": user.descriptions ?? "",
            "gender": user.gender.rawValue,
            "userType": user.userType.rawValue
        ]
        
        update(sql, params)
    }
    
//    func updateUser(user: JZUserInfo) {
//        let sql = "UPDATE user" +
//            " SET nickname=:nickname, avatar=:avatar, description=:description, gender=:gender, user_type=:user_type" +
//        " WHERE id=:id"
//        let params : [String:NSObject] = [
//            "id": user.uid,
//            "nickname": user.nickName ?? "",
//            "avatar": user.avatar ?? "",
//            "description": user.descriptions ?? "",
//            "gender": user.gender.rawValue,
//            "userType": user.userType.rawValue
//        ]
//        
//        update(sql, params)
//    }
    
    func findUserById(uid: Int, callback: (JZUserInfo?)->Void){
        let sql = "SELECT id, nickname, avatar, description, gender, user_type"
            + " FROM user"
            + " WHERE id=:id"
        let params = ["id": uid]
        queryAll(sql, params: params, unpack: { (result:FMResultSet) -> JZUserInfo? in
            let uid = Int(result.intForColumn("id"))
            let user = JZUserInfo(uid: uid, userName: "")
            user.nickName = result.stringForColumn("nickname")
            user.avatar = result.stringForColumn("avatar")
            user.descriptions = result.stringForColumn("description")
            user.gender = JZGenderType(rawValue: result.stringForColumn("gender")) ?? .unknow
            user.userType = JZUserType(rawValue: Int(result.intForColumn("user_type"))) ?? .unknow
            return user
            }, callback: { callback($0.first) })
        
    }
    
    func insertMessageGroup(group: JZMessageGroup, ignoreIfExists: Bool) {
        let sql = "INSERT OR \(ignoreIfExists ? "IGNORE" : "REPLACE") INTO message_group"
            + " (id, title, type, uid, rid, create_date)"
            + " VALUES (:id, :title, :type, :uid, :rid, :create_date)"
        let params = [
            "id": group.id,
            "title": group.title,
            "type": group.type.rawValue,
            "uid": group.user?.uid ?? 0,
            "rid": 0,
            "create_date": group.createDate
        ]
        
        update(sql, params)
//        insert(sql, params) { (rowId) -> Void in
//            if let rowId = rowId {
//                group.id = rowId
//                callback(group)
//            }
//            else {
//                callback(nil)
//            }
//        }
    }
    
//    func updateMessageGroup(group: JZMessageGroup) {
//        let sql = "UPDATE message_group"
//            + " SET title=:title, date=:date"
//            + " WHERE id = :gid"
//        let params : [String:NSObject] = [
//            "title": group.title,
//            //            "date": group.date,
//            "gid": group.id
//        ]
//        update(sql, params)
//    }
    
    func findMessageByUUID(uuid: String, callback: (JZMessage?)->Void) {
        let (messageItems, messageUnpack) = messageQueryItemsAndUnpackage("m")
        let sql = "SELECT \(messageItems) FROM message m WHERE m.uuid=:uuid LIMIT 1"
        let params = ["uuid": uuid]
        queryOne(sql, params: params, unpack: messageUnpack, callback: callback)
    }
    
    func findMessageByGroup(group: JZMessageGroup, index: Int, count: Int, callback: ([JZMessage])->Void) {
        let (messageItems, messageUnpack) = messageQueryItemsAndUnpackage("m")
        let (fromUserItems, fromUserUnpack) = userQueryItemsAndUnpackage("fu")
        let (toUserItems, toUserUnpack) = userQueryItemsAndUnpackage("tu")
        let sql = "SELECT \(messageItems), \(fromUserItems), \(toUserItems)"
            + " FROM message m"
            + " LEFT JOIN user fu on m.from_uid=fu.id"
            + " LEFT JOIN user tu on m.to_uid=tu.id"
            + " WHERE m.gid=:gid"
            + " LIMIT :index, :count"
        let params = ["gid": group.id, "index": index, "count": count]
        queryAll(sql, params: params, unpack: { (result:FMResultSet) -> JZMessage? in
            let message = messageUnpack(result)
            message?.fromUser = fromUserUnpack(result)
            message?.toUser = toUserUnpack(result)
            message?.group = group
            return message
            }, callback: callback)
    }
    
    func removeMessagesByGroup(gid: Int) {
        let sql = "DELETE message WHERE gid=:gid"
        let params = ["gid": gid]
        update(sql, params)
    }
    
    func findGroups(callback:([JZMessageGroup])->Void) {
        let (userQueryItems, userUnpack) = userQueryItemsAndUnpackage("u")
        let sql = "SELECT \(groupQueryItems), \(userQueryItems)"
        + " FROM message_group"
        + " LEFT JOIN user u ON u.id=message_group.uid"
        
        queryAll(sql, params: nil, unpack: { (result) -> JZMessageGroup? in
            if let group = self.unpackGroup(result) {
                group.user = userUnpack(result)
                group.unread = Int(result.intForColumn("mcount"))
                return group
            }
            return nil
            }, callback: callback)
    }
    
    func removeGroupById(id:Int) {
        let sql = "DELETE message_group WHERE id=:id"
        let params = ["id": id]
        update(sql, params)
    }
    
//    func findGroupByToUser(toUser: JZUserInfo, callback:(JZMessageGroup?)->Void) {
//        let filter = "WHERE g.type=:gtype AND u.id=:uid"
//        let params = [
//            "gtype": JZMessageGroupType.Chat.rawValue,
//            "uid": toUser.uid]
//        findGroupByFilter(filter, params: params) { (groups:[JZMessageGroup]) -> Void in
//            callback(groups.first)
//        }
//    }
    
    func findGroupByFilter(filter:String, params:[String:AnyObject], callback:([JZMessageGroup])->Void) {
        let sql = "SELECT id, title, type, uid, rid, create_date FROM message_group g LEFT JOIN user u ON u.id=g.uid " + filter
        queryAll(sql, params: params, unpack: { (result) -> JZMessageGroup? in
            let group = JZMessageGroup()
            group.id = Int(result.intForColumn("id"))
            group.title = result.stringForColumn("title")
            return group
            }, callback: callback)
    }
    
    func messageQueryItemsAndUnpackage(alias:String) -> (String, (FMResultSet) -> JZMessage?) {
        let items = "\(alias).id AS \(alias)id, \(alias).from_uid AS \(alias)from_uid, \(alias).to_uid AS \(alias)to_uid, \(alias).uuid AS \(alias)uuid, \(alias).text AS \(alias)text, \(alias).date AS \(alias)date, \(alias).type AS \(alias)type, \(alias).readed AS \(alias)readed, \(alias).uploaded AS \(alias)uploaded"
        let unpack = { (result: FMResultSet) -> JZMessage? in
            let message = JZMessage()
            message.id = Int(result.intForColumn("\(alias)id"))
            message.uuid = result.stringForColumn("\(alias)uuid")
            message.text = result.stringForColumn("\(alias)text")
            message.date = result.dateForColumn("\(alias)date")
            message.type = JZMessageType(rawValue: Int(result.intForColumn("\(alias)type"))) ?? JZMessageType.None
            message.uploaded = result.boolForColumn("\(alias)uploaded")
            message.readed = result.boolForColumn("\(alias)readed")
            return message
        }
        return (items, unpack)
    }
    
//    let userQueryItems = " user.id AS uid, user.nickname AS unickname, user.description AS udescription, user.gender AS ugender, user.user_type AS utype "
    func userQueryItemsAndUnpackage(alias:String) -> (String, (FMResultSet) -> JZUserInfo?) {
        let items = "\(alias).id AS \(alias)id, \(alias).nickname AS \(alias)nickname, \(alias).description AS \(alias)description, \(alias).gender AS \(alias)gender, \(alias).user_type AS \(alias)user_type, \(alias).avatar AS \(alias)avatar"
        let unpack = { (result:FMResultSet) -> JZUserInfo? in
            let user : JZUserInfo
            let userType = JZUserType(rawValue: Int(result.intForColumn("\(alias)user_type"))) ?? JZUserType.unknow
            switch userType {
            case .jobseeker: user = JZJobseekerUserInfo()
            case .boss: user = JZBossUserInfo()
            default: user = JZUserInfo()
            }
            user.uid = Int(result.intForColumn("\(alias)id"))
            user.nickName = result.stringForColumn("\(alias)nickname")
            user.descriptions = result.stringForColumn("\(alias)description")
            user.gender = JZGenderType(rawValue: result.stringForColumn("\(alias)gender") ?? "u") ?? JZGenderType.unknow
            user.avatar = result.stringForColumn("\(alias)avatar")
            user.userType = JZUserType(rawValue: Int(result.intForColumn("\(alias)user_type"))) ?? .unknow
            
            return user
        }
        return (items, unpack)
    }
    
//    func unpackUser(result:FMResultSet) -> JZUserInfo? {
//        return unpackUser("u", result: result)
//    }
//    
//    func unpackUser(alias:String, result:FMResultSet) -> JZUserInfo? {
//        let user : JZUserInfo
//        let userType = JZUserType(rawValue: Int(result.intForColumn("\(alias)type"))) ?? JZUserType.unknow
//        switch userType {
//        case .jobseeker: user = JZJobseekerUserInfo()
//        case .boss: user = JZBossUserInfo()
//        default: user = JZUserInfo()
//        }
//        user.uid = Int(result.intForColumn("\(alias)id"))
//        user.nickName = result.stringForColumn("\(alias)nickname")
//        user.descriptions = result.stringForColumn("\(alias)description")
//        user.gender = JZGenderType(rawValue: result.stringForColumn("\(alias)gender") ?? "u") ?? JZGenderType.unknow
//        
//        return user
//    }
    
    let groupQueryItems = " message_group.id AS gid, message_group.title AS gtitle, message_group.type AS gtype, message_group.uid AS guid, message_group.rid AS grid, message_group.create_date AS gcreate_date "
    func unpackGroup(result: FMResultSet) -> JZMessageGroup? {
        let group = JZMessageGroup()
        group.id = Int(result.intForColumn("gid"))
        group.title = result.stringForColumn("gtitle")
        group.type = JZMessageGroupType(rawValue: Int(result.intForColumn("gtype"))) ?? .None
        
        return group
    }
    
    func groupQueryItemsAndUnpackage(alias:String) -> (String, (FMResultSet)->JZMessageGroup?) {
        let groupQueryItems = "\(alias).id AS \(alias)id, \(alias).title AS \(alias)title, \(alias).type AS \(alias)type, \(alias).uid AS \(alias)uid, \(alias).rid AS \(alias)rid, \(alias).create_date AS \(alias)create_date"
        let unpack = { (result:FMResultSet)->JZMessageGroup? in
            let group = JZMessageGroup()
            group.id = Int(result.intForColumn("\(alias)id"))
            group.title = result.stringForColumn("\(alias)title")
            
            return group
        }
        return (groupQueryItems, unpack)
    }
}
