//
//  MainViewController.swift
//  Front-End
//
//  Created by Dennis Rudolph on 4/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var northDoorImageView: UIImageView!
    @IBOutlet weak var eastDoorImageView: UIImageView!
    @IBOutlet weak var southDoorImageView: UIImageView!
    @IBOutlet weak var westDoorImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var roomView: UIView!
    @IBOutlet weak var screenView: UIView!
    
    //Test Room
//    var room = Room(name: "Starting Room", description: "The first Room", northRoomID: nil, southRoomID: 1234, eastRoomID: 4312, westRoomID: nil)
    
    let apiController = APIController()
    var currentRoom: Room?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImages()
        updateDoorViews()
        updateDescriptionViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if apiController.bearer == nil {
            performSegue(withIdentifier: "LoginModalSegue", sender: self)
        } else {
            self.apiController.getRooms { (error) in
                if let error = error {
                    print("Error occured during world fetch \(error)")
                } else {
                    print("World was successfully fetched")
                    print(self.apiController.roomData[1]?.title)
                    print(self.apiController.roomData[5]?.title)
                }
            }
        }
    }
    
    func setupImages() {
        characterImageView.image = UIImage(named: "stickFigure")
        northDoorImageView.image = UIImage(named: "door")
        southDoorImageView.image = UIImage(named: "door")
        eastDoorImageView.image = UIImage(named: "door")
        westDoorImageView.image = UIImage(named: "door")
    }
    
    func updateDescriptionViews() {
        guard let currentRoom = self.currentRoom else { return }
        descriptionTextView.text = "Current Room: \(currentRoom.title)\nDescription: \(currentRoom.description)\nPlayers: \(String(describing: currentRoom.players))"
    }
    
    func updateDoorViews() {
        if currentRoom?.n_to != nil{
            self.northDoorImageView.isHidden = false
        } else {
            self.northDoorImageView.isHidden = true
        }
        
        if currentRoom?.s_to != nil{
            self.southDoorImageView.isHidden = false
        } else {
            self.southDoorImageView.isHidden = true
        }
        
        if currentRoom?.e_to != nil{
            self.eastDoorImageView.isHidden = false
        } else {
            self.eastDoorImageView.isHidden = true
        }
        
        if currentRoom?.w_to != nil{
            self.westDoorImageView.isHidden = false
        } else {
            self.westDoorImageView.isHidden = true
        }
    }
    
    @IBAction func northTapped(_ sender: UIButton) {
        guard currentRoom?.n_to != 0 else { return }
        let n = DirectionMoved(direction: "n")
        
        apiController.directionSelected(direction: n) { (error) in
            if let error = error {
                print("Error moving in the north direction: \(error)")
            } else {
                print("Movement worked.")
            }
        }
    }
    @IBAction func eastTapped(_ sender: UIButton) {
        guard currentRoom?.e_to != 0 else { return }
        let e = DirectionMoved(direction: "e")
        
        apiController.directionSelected(direction: e) { (error) in
            if let error = error {
                print("Error moving in the north direction: \(error)")
            } else {
                print("Movement worked.")
            }
        }
    }
    @IBAction func southButton(_ sender: UIButton) {
        guard currentRoom?.s_to != 0 else { return }
        let s = DirectionMoved(direction: "s")
        
        apiController.directionSelected(direction: s) { (error) in
            if let error = error {
                print("Error moving in the north direction: \(error)")
            } else {
                print("Movement worked.")
            }
        }
    }
    @IBAction func westTapped(_ sender: UIButton) {
        guard currentRoom?.w_to != 0 else { return }
        let w = DirectionMoved(direction: "w")
        
        apiController.directionSelected(direction: w) { (error) in
            if let error = error {
                print("Error moving in the north direction: \(error)")
            } else {
                print("Movement worked.")
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginModalSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.apiController = apiController
            }
        }
    }
}
