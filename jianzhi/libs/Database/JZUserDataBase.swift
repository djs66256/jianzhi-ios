//
//  JZMessageDataBase.swift
//  jianzhi
//
//  Created by daniel on 16/1/29.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZUserDataBase: JZDataBase {
    
    override func prepareDatabase() {
        let sqls = [
            "CREATE TABLE IF NOT EXISTS message (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "from_uid INTEGER," +
                "to_uid INTEGER," +
                "gid INTEGER," +
                "jid INTEGER," +
                "cid INTEGER," +
                "uuid CHAR(32)," +
                "text TEXT," +
                "date DATE," +
                "type INTEGER," +
                "uploaded BOOL," +
                "unread BOOL" +
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
                "jid INTEGER," +
                "create_date DATE" +
            ");",
            "CREATE TABLE IF NOT EXISTS job (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "title text," +
                "detail text," +
                "salary INTEGER," +
                "salary_type INTEGER" +
            ")"
        ]
        
        sqls.forEach { update($0) }
    }
    
    func insertMessage(message: JZMessage) {
        
        execuse {
            let sql = "INSERT INTO message" +
                " (from_uid, to_uid, gid, cid, jid, uuid, text, date, type, uploaded, unread)" +
            " VALUES (:from_uid, :to_uid, :gid, :cid, :jid, :uuid, :text, :date, :type, :uploaded, :unread);"
            var params : [String: AnyObject] = [
                "from_uid": message.fromUser!.uid,
                "to_uid": message.toUser!.uid,
                "gid": message.group!.id,
                "uuid": message.uuid,
                "text": message.text,
                "date": message.date ?? "",
                "type": message.type.rawValue,
                "uploaded": message.uploaded,
                "unread": message.unread,
                "jid": "",
                "cid": ""
            ]
            
            if message.type == .Job || message.type == .Post, let job = message.job {
                self.insertJobSync(job, ignoreIfExist: false, callback: {})
                params["jid"] = job.id
            }
            if message.type == .Person || message.type == .Post, let user = message.nameCard {
                self.insertUserSync(user, ignoreIfExists: false)
                params["cid"] = user.uid
            }
            
            self.insertSync(sql, params, callback: { (rowId) -> Void in
                if let rowId = rowId {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        message.id = rowId
                    })
                }
            })
        }
    }
    
    func setMessageUnreadByGroup(gid: Int) {
        let sql = "UPDATE message SET unread=:unread WHERE gid=:gid"
        let params: [String: AnyObject] = [
            "gid": gid,
            "unread":false
        ]
        update(sql, params)
    }
    
    func setMessageUnreadByUuid(uuid: String) {
        let sql = "UPDATE message SET unread=:unread WHERE uuid=:uuid"
        let params: [String: AnyObject] = [
            "uuid": uuid,
            "unread": false
        ]
        update(sql, params)
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
        execuse {
            self.insertUserSync(user, ignoreIfExists: ignoreIfExists)
        }
    }
    
    private func insertUserSync(user: JZUserInfo, ignoreIfExists: Bool) {
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
        
        insertSync(sql, params) {_ in }
    }
    
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
    
    func insertMessageGroup(group: JZMessageGroup, ignoreIfExists: Bool, callback:(JZMessageGroup?)->Void) {
        execuse {
            if group.type == .Post, let job = group.job {
                self.insertJobSync(job, ignoreIfExist: false, callback: {})
            }
            self.insertMessageGroupSync(group, ignoreIfExists: ignoreIfExists, callback: { group in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callback(group)
                })
            })
        }
    }
    
    func insertMessageGroupSync(group: JZMessageGroup, ignoreIfExists: Bool, callback:(JZMessageGroup?)->Void) {
        let sql = "INSERT OR \(ignoreIfExists ? "IGNORE" : "REPLACE") INTO message_group"
            + " (title, type, uid, jid, create_date)"
            + " VALUES (:title, :type, :uid, :jid, :create_date)"
        let params = [
//            "id": group.id,
            "title": group.title,
            "type": group.type.rawValue,
            "uid": group.user?.uid ?? 0,
            "jid": group.job?.id ?? 0,
            "create_date": group.createDate
        ]
        
        insertSync(sql, params) { (rowId) -> Void in
            if let rowId = rowId {
                group.id = rowId
                callback(group)
            }
            else {
                callback(nil)
            }
        }
    }
    
    func findMessageByUUID(uuid: String, callback: (JZMessage?)->Void) {
        let (_, messageItems, messageUnpack) = messageQueryItemsAndUnpackage("m")
        let sql = "SELECT \(messageItems) FROM message m WHERE m.uuid=:uuid LIMIT 1"
        let params = ["uuid": uuid]
        queryOne(sql, params: params, unpack: messageUnpack, callback: callback)
    }
    
    func findMessageByGroup(group: JZMessageGroup, index: Int, count: Int, callback: ([JZMessage])->Void) {
        let (_, messageItems, messageUnpack) = messageQueryItemsAndUnpackage("m")
        let (_, fromUserItems, fromUserUnpack) = userQueryItemsAndUnpackage("fu")
        let (_, toUserItems, toUserUnpack) = userQueryItemsAndUnpackage("tu")
        let (_, jobItems, jobUnpack) = jobQueryItemsAndUnpackage("j")
        let (_, nameCardItems, nameCardUnpack) = userQueryItemsAndUnpackage("cu")
        let sql = "SELECT \(messageItems), \(fromUserItems), \(toUserItems), \(jobItems), \(nameCardItems)"
            + " FROM message m"
            + " LEFT JOIN user fu ON m.from_uid=fu.id"
            + " LEFT JOIN user tu ON m.to_uid=tu.id"
            + " LEFT JOIN job j ON j.id=m.jid"
            + " LEFT JOIN user cu ON m.cid=cu.id"
            + " WHERE m.gid=:gid"
            + " ORDER BY m.id DESC"
            + " LIMIT :index, :count"
        let params = ["gid": group.id, "index": index, "count": count]
        queryAll(sql, params: params, unpack: { (result:FMResultSet) -> JZMessage? in
            let message = messageUnpack(result)
            message?.fromUser = fromUserUnpack(result)
            message?.toUser = toUserUnpack(result)
            message?.group = group
            if message?.type == .Job || message?.type == .Post {
                message?.job = jobUnpack(result)
            }
            if message?.type == .Person || message?.type == .Post {
                message?.nameCard = nameCardUnpack(result)
            }
            return message
            }, callback: {
                callback($0.reverse())
        })
    }
    
    func removeMessagesByGroup(gid: Int) {
        let sql = "DELETE FROM message WHERE gid=:gid"
        let params = ["gid": gid]
        update(sql, params)
    }
    
    func findGroups(callback:([JZMessageGroup])->Void) {
        let (_, userQueryItems, userUnpack) = userQueryItemsAndUnpackage("u")
        let (messageQueryItems, messageAliasItems, messageUnpack) = messageQueryItemsAndUnpackage("m")
        let (fromUserQueryItems, fromUserAliasItems, fromUserUnpack) = userQueryItemsAndUnpackage("fu")
        let (toUserQueryItems, toUserAliasItems, toUserUnpack) = userQueryItemsAndUnpackage("tu")
        let (_, jobAliasItems, jobUnpack) = jobQueryItemsAndUnpackage("j")
        
        let sql = "SELECT \(groupQueryItems), \(userQueryItems), unread, \(messageQueryItems), \(toUserQueryItems), \(fromUserQueryItems), \(jobAliasItems)"
            + " FROM message_group"
            + " LEFT JOIN user u ON u.id=message_group.uid"
            + " LEFT JOIN (SELECT COUNT(*) AS unread, gid AS gid from message WHERE unread=:unread GROUP BY gid) ON gid=message_group.id"
            + " LEFT JOIN job j ON j.id=message_group.jid"
            + " LEFT JOIN ("
            + "SELECT \(messageAliasItems), \(toUserAliasItems), \(fromUserAliasItems)"
            + " FROM message m"
            + " LEFT JOIN user fu on m.from_uid=fu.id"
            + " LEFT JOIN user tu on m.to_uid=tu.id"
            + " GROUP BY mgid"
            + " )"
            + " ON mgid=message_group.id"
        
        queryAll(sql, params: ["unread": true], unpack: { result -> JZMessageGroup? in
            if let group = self.unpackGroup(result) {
                group.user = userUnpack(result)
                if let lastMessage = messageUnpack(result) {
                    lastMessage.fromUser = fromUserUnpack(result)
                    lastMessage.toUser = toUserUnpack(result)
                    group.lastMessage = lastMessage
                }
                if group.type == .Post {
                    group.job = jobUnpack(result)
                }
                let unread = result.intForColumn("unread")
                group.unread = Int(unread)
                return group
            }
            return nil
            }, callback: callback)
    }
    
    func removeGroupById(id:Int) {
        let sql = "DELETE FROM message_group WHERE id=:id"
        let params = ["id": id]
        update(sql, params)
    }
    
    func findGroupByFilter(filter:String, params:[String:AnyObject], callback:([JZMessageGroup])->Void) {
        let sql = "SELECT id, title, type, uid, jid, create_date FROM message_group g LEFT JOIN user u ON u.id=g.uid " + filter
        queryAll(sql, params: params, unpack: { (result) -> JZMessageGroup? in
            let group = JZMessageGroup()
            group.id = Int(result.intForColumn("id"))
            group.title = result.stringForColumn("title")
            return group
            }, callback: callback)
    }
    
    func insertJob(job: JZJob, ignoreIfExist: Bool, callback:()->Void) {
        execuse {
            self.insertJobSync(job, ignoreIfExist: ignoreIfExist, callback: {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callback()
                })
            })
        }
    }
    
    private func insertJobSync(job: JZJob, ignoreIfExist: Bool, callback:()->Void) {
        guard let _ = job.id else {
            JZLogError("SQL: Job id can not be 0")
            return
        }
        let sql = "INSERT OR \(ignoreIfExist ? "IGNORE" : "REPLACE") INTO job"
            + " (id, title, detail, salary, salary_type)"
            + " VALUES (:id, :title, :detail, :salary, :salary_type)"
        let params: [String: AnyObject] = [
            "id": job.id!,
            "title": job.title ?? "",
            "detail": job.detail ?? "",
            "salary": job.salary ?? 0,
            "salary_type": job.salaryType.rawValue
        ]
        insertSync(sql, params) { (rowId) -> Void in
            callback()
        }
    }
    
    func messageQueryItemsAndUnpackage(alias:String) -> (String, String, (FMResultSet) -> JZMessage?) {
        let qureyItems = "\(alias)id, \(alias)gid, \(alias)from_uid, \(alias)to_uid, \(alias)uuid, \(alias)text, \(alias)date, \(alias)type, \(alias)unread, \(alias)uploaded"
        let aliasItems = "\(alias).id AS \(alias)id, \(alias).gid AS \(alias)gid, \(alias).from_uid AS \(alias)from_uid, \(alias).to_uid AS \(alias)to_uid, \(alias).uuid AS \(alias)uuid, \(alias).text AS \(alias)text, \(alias).date AS \(alias)date, \(alias).type AS \(alias)type, \(alias).unread AS \(alias)unread, \(alias).uploaded AS \(alias)uploaded"
        let unpack = { (result: FMResultSet) -> JZMessage? in
            let message = JZMessage()
            message.id = Int(result.intForColumn("\(alias)id"))
            message.uuid = result.stringForColumn("\(alias)uuid")
            message.text = result.stringForColumn("\(alias)text")
            message.date = result.dateForColumn("\(alias)date")
            message.type = JZMessageType(rawValue: Int(result.intForColumn("\(alias)type"))) ?? JZMessageType.None
            message.uploaded = result.boolForColumn("\(alias)uploaded")
            message.unread = result.boolForColumn("\(alias)unread")
            return message
        }
        return (qureyItems, aliasItems, unpack)
    }
   
    func userQueryItemsAndUnpackage(alias:String) -> (String, String, (FMResultSet) -> JZUserInfo?) {
        let queryItems = "\(alias)id, \(alias)nickname, \(alias)description, \(alias)gender, \(alias)user_type, \(alias)avatar"
        let aliasItems = "\(alias).id AS \(alias)id, \(alias).nickname AS \(alias)nickname, \(alias).description AS \(alias)description, \(alias).gender AS \(alias)gender, \(alias).user_type AS \(alias)user_type, \(alias).avatar AS \(alias)avatar"
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
        return (queryItems, aliasItems, unpack)
    }
    
    let groupQueryItems = " message_group.id AS gid, message_group.title AS gtitle, message_group.type AS gtype, message_group.uid AS guid, message_group.jid AS gjid, message_group.create_date AS gcreate_date "
    func unpackGroup(result: FMResultSet) -> JZMessageGroup? {
        let group = JZMessageGroup()
        group.id = Int(result.intForColumn("gid"))
        group.title = result.stringForColumn("gtitle")
        group.type = JZMessageGroupType(rawValue: Int(result.intForColumn("gtype"))) ?? .None
        
        return group
    }
    
    func groupQueryItemsAndUnpackage(alias:String) -> (String, (FMResultSet)->JZMessageGroup?) {
        let groupQueryItems = "\(alias).id AS \(alias)id, \(alias).title AS \(alias)title, \(alias).type AS \(alias)type, \(alias).uid AS \(alias)uid, \(alias).jid AS \(alias)jid, \(alias).create_date AS \(alias)create_date"
        let unpack = { (result:FMResultSet)->JZMessageGroup? in
            let group = JZMessageGroup()
            group.id = Int(result.intForColumn("\(alias)id"))
            group.title = result.stringForColumn("\(alias)title")
            
            return group
        }
        return (groupQueryItems, unpack)
    }
    
    func jobQueryItemsAndUnpackage(alias: String) -> (String, String, (FMResultSet)->JZJob?) {
        let queryItems = "\(alias)id, \(alias)title, \(alias)detail, \(alias)salary, \(alias)salary_type"
        let aliasItems = "\(alias).id AS \(alias)id, \(alias).title AS \(alias)title, \(alias).detail AS \(alias)detail, \(alias).salary AS \(alias)salary, \(alias).salary_type AS \(alias)salary_type"
        let unpack = { (result:FMResultSet) -> JZJob? in
            let job = JZJob()
            job.id = Int(result.intForColumn("\(alias)id"))
            job.title = result.stringForColumn("\(alias)title")
            job.detail = result.stringForColumn("\(alias)detail")
            job.salary = Int(result.intForColumn("\(alias)salary"))
            job.salaryType = JZSalaryTypeBy(rawValue: Int(result.intForColumn("\(alias)salary"))) ?? .none
            return job
        }
        return (queryItems, aliasItems, unpack)
    }
}
