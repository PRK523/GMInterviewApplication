//
//  GitApiDataModel.swift
//  GMInterviewApplication
//
//  Created by PRANOTI KULKARNI on 12/21/20.
//

import UIKit

struct UserData: Codable {
    let sha : String?
    let commit : Commit?
    
    struct Commit: Codable {
        let author: Author?
        let message: String?
    }
    
    struct Author: Codable {
        let name: String?
    }
}
