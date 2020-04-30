//
//  Models.swift
//  Front-End
//
//  Created by Niranjan Kumar on 4/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


struct Room: Codable {
    var id: Int?
    var title: String
    var description: String
    var n_to: Int?
    var s_to: Int?
    var e_to: Int?
    var w_to: Int?
    var players: [String]?
    var uuid: String?
    var error_msg: String?
}

struct World: Codable {
    var rooms: [Room]
}

struct RoomID: Codable {
    var player_room: Int
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
