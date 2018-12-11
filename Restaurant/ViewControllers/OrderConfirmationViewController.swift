//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Sander de Vries on 11/12/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeRemainingLabel.text = "Thanks for your order at Freesers! Your wait time is approximately \(minutes!) minutes"
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
