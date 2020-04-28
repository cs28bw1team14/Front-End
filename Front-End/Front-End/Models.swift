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
