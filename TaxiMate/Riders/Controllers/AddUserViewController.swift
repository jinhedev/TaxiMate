//
//  AddUserViewController.swift
//  HSD
//
//  Created by rightmeow on 12/13/17.
//  Copyright © 2017 rightmeow. All rights reserved.
//

import UIKit

protocol AddUserViewControllerDelegate: NSObjectProtocol {
    func addUserViewController(_ currentViewController: UIViewController, didTapControl button: UIButton, viewControllerToPush: UIViewController)
}

class AddUserViewController: UIViewController {

    var keyboardHeight: CGFloat? {
        didSet {
            self.adjustedViewHeightForKeyboardAnimation(keyboardHeight: keyboardHeight!)
        }
    }
    var keyboardNotification: Notification?
    weak var delegate: AddUserViewControllerDelegate?

    static let storyboard_id = String(describing: AddUserViewController.self)

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var nextButtonBottomLayoutConstraint: NSLayoutConstraint!

    @IBAction func handleCancel(_ sender: UIBarButtonItem) {
        let alerController = self.initAlertController(title: "Cancel", message: "Are you sure you want to cancel rider creation?")
        self.present(alerController, animated: true, completion: nil)
    }

    @IBAction func handleNext(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: AvatarViewController.storyboard_id) as? AvatarViewController {
            self.delegate?.addUserViewController(self, didTapControl: sender, viewControllerToPush: vc)
        }
    }

    private func initAlertController(title: String, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        return alert
    }

    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
        }
    }

    private func adjustedViewHeightForKeyboardAnimation(keyboardHeight: CGFloat) {
        self.nextButtonBottomLayoutConstraint.constant = 16 + keyboardHeight
        UIView.animate(withDuration: 0.15, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    private func setupNextButton() {
        self.nextButton.layer.cornerRadius = 8
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeKeyboardNotifications()
        self.setupNextButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let namesViewController = segue.destination as? NamesViewController {
            namesViewController.addUserViewController = self
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // REMARK: remove observes if target is below iOS version 9.0
    }

}
