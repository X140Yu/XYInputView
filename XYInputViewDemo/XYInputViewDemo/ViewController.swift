//
//  ViewController.swift
//  XYInputView
//
//  Created by X140Yu on 15/5/30.
//  Copyright (c) 2015年 X140Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XYInputViewDelegate, UITableViewDelegate, UITableViewDataSource
{
	
	var messages = [String]()
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		let keyboardInputView = XYInputView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 40, width: UIScreen.main.bounds.width, height: 40))
		keyboardInputView.delegate = self
		self.view.addSubview(keyboardInputView)
	}
	
	func sendButtonPressedWith(_ str: String) {
		messages.append(str)
		tableView.reloadData()
	}
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		self.view.endEditing(true)
	}
	
	
	// MARK: UITableView Data Source

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messages.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
		cell.textLabel?.text = messages[indexPath.row]
		return cell
	}

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


