//
//  MainViewController.swift
//  Front-End
//
//  Created by Dennis Rudolph on 4/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var currentRoomImageView: UIImageView!
    @IBOutlet weak var northRoomImageView: UIImageView!
    @IBOutlet weak var eastRoomImageView: UIImageView!
    @IBOutlet weak var southRoomImageView: UIImageView!
    @IBOutlet weak var westRoomImageView: UIImageView!
    @IBOutlet weak var northWestRoomImageView: UIImageView!
    @IBOutlet weak var northEastRoomImageView: UIImageView!
    @IBOutlet weak var southWestRoomImageView: UIImageView!
    @IBOutlet weak var southEastRoomImageView: UIImageView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func northTapped(_ sender: UIButton) {
        
    }
    @IBAction func eastTapped(_ sender: UIButton) {
        
    }
    @IBAction func southButton(_ sender: UIButton) {
        
    }
    @IBAction func westTapped(_ sender: UIButton) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
