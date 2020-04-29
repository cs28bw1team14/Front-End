//
//  Models.swift
//  Front-End
//
//  Created by Niranjan Kumar on 4/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


struct Room {
    var name: String
    var description: String
    var northRoomID: Int?
    var southRoomID: Int?
    var eastRoomID: Int?
    var westRoomID: Int?
    var players: [String] = ["Nar", "Dennis"]
}


struct Bearer: Codable {
    let key: String
}


struct SignUpUser: Codable {
    let username: String
    let password1: String
    let password2: String
}

struct LoginUser: Codable {
    let username: String
    let password: String
}


struct DirectionMoved: Codable {
    let direction: String
}

struct TestRoom: Codable {
    var name: String
    var title: String
    var description: String
    var players: [String]
    var error_msg: String
}
