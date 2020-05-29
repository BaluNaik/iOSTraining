//
//  SQLiteManager.swift
//  SQLiteDBApp
//
//  Created by Balu Naik on 5/27/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation
import FMDB

class SQLiteManager {
    
    static let sharedInstance = SQLiteManager()
    private var database: FMDatabase? = nil
    
    // MARK: - Init & Deinit
    
    private init() {
        database = FMDatabase(path: self.getDocumentPath())
        if database == nil {
            fatalError("Unable to create database")
        } else {
            if let _ = database?.open() {
                print("Data base is ready to use")
                // We have to create table
                self.createtable()
            }
        }
    }
    
    deinit {
        self.database?.close()
    }
    
    
    // MARK: - Private
    
    private func getDocumentPath() -> String {
        let rootPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0]
        let filePath = rootPath.appending("/SQLiteDBApp.sqlite")
        
        return filePath
    }
    
    private func createtable() {
        let sqlStatement = "create table if not exists EMP (ID INTEGER PRIMARY KEY AUTOINCREMENT,FirstName varchar(64), LastName varchar(64),Email varchar(40),Salary INTEGER,Mobile varchar(10),Jdate varchar(10),About varchar(100))"
        if let status = self.database?.executeStatements(sqlStatement), !status {
            fatalError("Unable to create table")
        }
    }
    
    
    //MARK: - Public
    
    func insert(data: EMP, handler: ((Bool)-> Void)) {
        let sqlStatement = String(format: "insert into EMP (FirstName, LastName,Email,Salary,Mobile,Jdate,About) values (\'%@\', \'%@\',\'%@\',%i,\'%@\',\'%@\',\'%@\')", data.fistName ?? "-",
                                  data.lastName ?? "-",
                                  data.email ?? "-",
                                  data.salary ?? 0,
                                  data.mobile ?? "-",
                                  data.jDate ?? "-",
                                  data.about ?? "-")
        if let status = self.database?.executeStatements(sqlStatement), status {
            print("New record is created")
            handler(true)
        } else {
            handler(false)
        }
    }
    
    func display() -> [EMP] {
        let resultSet: FMResultSet? = self.database?.executeQuery("SELECT *from EMP", withArgumentsIn: [])
        var list:[EMP] = []
        if let result = resultSet {
            while result.next() {
                let empObj = EMP(empID: Int(result.int(forColumn: "ID")),
                                 fistName: result.string(forColumn: "FirstName"),
                                 lastName: result.string(forColumn: "LastName"),
                                 email: result.string(forColumn: "Email"),
                                 mobile: result.string(forColumn: "Mobile"),
                                 about: result.string(forColumn: "About"),
                                 jDate: result.string(forColumn: "Jdate"),
                                 salary: Int(result.int(forColumn: "Salary")))
                list.append(empObj)
            }
        }
        
        return list
    }
    
    func update(data: EMP, handler: ((Bool)-> Void)) {
        if let id = data.empID {
            let sqlStatement = String(format: "UPDATE EMP SET FirstName=\'%@\',LastName=\'%@\',Email=\'%@\',Salary=%i,Mobile=\'%@\',Jdate=\'%@\',About=\'%@\' WHERE ID=%i",
                                      data.fistName ?? "-",
                                      data.lastName ?? "-",
                                      data.email ?? "-",
                                      data.salary ?? 0,
                                      data.mobile ?? "-",
                                      data.jDate ?? "-",
                                      data.about ?? "-",
                                      id)
            if let status = self.database?.executeStatements(sqlStatement), status {
                print("Record is updated")
                handler(true)
            } else {
                handler(false)
            }
        }
    }
    
    func delete(id: Int, handler: ((Bool)-> Void)) {
        let sqlStatement = String(format: "DELETE FROM EMP WHERE ID = %u",id)
        if let status = self.database?.executeStatements(sqlStatement), status {
            print("Record is deleted")
            handler(true)
        } else {
            handler(false)
        }
    }
    
}

