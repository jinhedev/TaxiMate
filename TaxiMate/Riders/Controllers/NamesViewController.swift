//
//  NamesViewController.swift
//  HSD
//
//  Created by rightmeow on 12/14/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

class NamesViewController: UIViewController, AddUserViewControllerDelegate {

    var addUserViewController: AddUserViewController?

    static let storyboard_id = String(describing: NamesViewController.self)

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addUserViewController?.navigationItem.title = "Add Rider"
        self.firstNameTextField.becomeFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.firstNameTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if firstNameTextField.isFirstResponder {
            firstNameTextField.resignFirstResponder()
        } else if lastNameTextField.isFirstResponder {
            lastNameTextField.resignFirstResponder()
        }
    }

    // MARK: - AddUserViewControllerDelegate

    func addUserViewController(_ currentViewController: UIViewController, didTapControl button: UIButton, viewControllerToPush: UIViewController) {
        if let vc = viewControllerToPush as? AvatarViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
