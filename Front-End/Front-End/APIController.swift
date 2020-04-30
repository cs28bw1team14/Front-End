//
//  APIController.swift
//  Front-End
//
//  Created by Niranjan Kumar on 4/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case badData
    case otherError
}


class APIController {
    
    private let baseURL = URL(string: "https://cs-28-django.herokuapp.com/")!
    
    var bearer: Bearer?
    var world: World? {
        didSet {
            setCache()
        }
    }
    var currentRoom: Room?

    var roomData: [String: Room] = [:]
    var testRoom: TestRoom?
    
    func setCache() {
        guard let rooms = world?.rooms else { return }
        for room in rooms {
            roomData[room.title] = room
        }
    }
    
    func setCurrentRoom(title: String, players: [String]) {
        if let room = roomData[title] {
            currentRoom = room
            currentRoom?.players = players
        }
    }
    
    func registerAndSignIn(with user: SignUpUser, completion: @escaping (Error?) -> ()) {
        let signUpUrl = baseURL.appendingPathComponent("api/registration/")
        
        var request = URLRequest(url: signUpUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .never
        config.httpShouldSetCookies = false
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: request) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.bearer = try decoder.decode(Bearer.self, from: responseData)
            } catch {
                print("Error decoding bearer object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }
        task.resume()
    }
    

    func signIn(with user: LoginUser, completion: @escaping (Error?) -> ()) {
        let signInUrl = baseURL.appendingPathComponent("api/login/")
        
        var request = URLRequest(url: signInUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            print(String(data: jsonData, encoding: .utf8)!)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .never
        config.httpShouldSetCookies = false
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: request) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.bearer = try decoder.decode(Bearer.self, from: responseData)
            } catch {
                print("Error decoding bearer object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }
        task.resume()
    }
    
    func directionSelected(direction: DirectionMoved, completion: @escaping (Error?) -> ()) {
        let signInUrl = baseURL.appendingPathComponent("api/adv/move/")
        guard let bearerToken = self.bearer else { return }
//        let bearerToken = self.bearer
        
        var request = URLRequest(url: signInUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(bearerToken.key)", forHTTPHeaderField: "Authorization")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(direction)
            print(String(data: jsonData, encoding: .utf8)!)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .never
        config.httpShouldSetCookies = false
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: request) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            let decoder = JSONDecoder()
            print("JSON from server for new room:\(String(data: responseData, encoding: String.Encoding.utf8)!)")
            do {
                let newRoom = try decoder.decode(Room.self, from: responseData)
                self.updateCurrentRoomAvailableDirections(newRoom: newRoom)
                
            } catch {
                print("Error decoding new room object from move: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }
        task.resume()
    }
    
    func getRooms(completion: @escaping (Error?) -> ()) {
        let getRoomsURL = baseURL.appendingPathComponent("api/adv/get_rooms/")
        
        var request = URLRequest(url: getRoomsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue(self.bearer?.key, forHTTPHeaderField: "Authorization")
        
        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .never
        config.httpShouldSetCookies = false
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: request) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on rooms")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive room data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.world = try decoder.decode(World.self, from: responseData)
            } catch {
                print("Error decoding world object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }
        task.resume()
    }
    
    func initializeRoom(completion: @escaping (Error?) -> ()) {
        let getRoomsURL = baseURL.appendingPathComponent("api/adv/initialize/")
        
        var request = URLRequest(url: getRoomsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        guard let bearerToken = self.bearer else { return }
        request.setValue("Token \(bearerToken.key)", forHTTPHeaderField: "Authorization")
        
        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .never
        config.httpShouldSetCookies = false
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: request) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on rooms")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive room data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let room = try decoder.decode(Room.self, from: responseData)
                print("PLAYERS FROM SERVER\(room.players)")
                self.setCurrentRoom(title: room.title, players: room.players ?? [])
            } catch {
                print("Error decoding room object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }
        task.resume()
    }
    
    func updateCurrentRoomAvailableDirections(newRoom: Room) {
        self.currentRoom?.n_to = roomData[newRoom.title]?.n_to
        self.currentRoom?.e_to = roomData[newRoom.title]?.e_to
        self.currentRoom?.s_to = roomData[newRoom.title]?.s_to
        self.currentRoom?.w_to = roomData[newRoom.title]?.w_to
        self.currentRoom?.description = roomData[newRoom.title]?.description ?? ""
        self.currentRoom?.title = roomData[newRoom.title]?.title ?? ""
        self.currentRoom?.players = newRoom.players
    }



}



