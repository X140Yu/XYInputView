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

		let keyboardInputView = XYInputView(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.height - 40, width: UIScreen.mainScreen().bounds.width, height: 40))
		keyboardInputView.delegate = self
		self.view.addSubview(keyboardInputView)
	}
	
	func sendButtonPressedWith(str: String) {
		messages.append(str)
		tableView.reloadData()
	}
	
	func scrollViewWillBeginDragging(scrollView: UIScrollView) {
		self.view.endEditing(true)
	}
	
	
	// MARK: UITableView Data Source

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messages.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
		cell.textLabel?.text = messages[indexPath.row]
		return cell
	}

}


