//
//  CalendarViewController.swift
//  HSD
//
//  Created by rightmeow on 12/14/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    var scheduleProcessViewController: ScheduleProcessViewController?

    static let storyboard_id = String(describing: CalendarViewController.self)

    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var nextButton: UIButton!

    @IBAction func handleNext(_ sender: UIButton) {
        if let timeViewController = storyboard?.instantiateViewController(withIdentifier: TimeViewController.storyboard_id) as? TimeViewController {
            self.navigationController?.pushViewController(timeViewController, animated: true)
        }
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }

    // MAKR: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }

}
