//
//  XYInputView.swift
//  XYInputView
//
//  Created by X140Yu on 15/5/30.
//  Copyright (c) 2015年 X140Yu. All rights reserved.
//

import UIKit

@objc protocol XYInputViewDelegate {
	func sendButtonPressedWith(str: String)
}

class XYInputView: UIView
{
    weak var delegate: XYInputViewDelegate!
	private var textField = UITextField()
	private var sendButton = UIButton()
	private var originFrame = CGRect()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
		self.frame = CGRect(x: 0, y: CGRectGetMinY(frame), width: CGRectGetWidth(frame), height: CGRectGetHeight(frame))
		self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3).CGColor
		self.layer.borderWidth = 0.5
		originFrame = self.frame
		
		self.addCustomView()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addCustomView() {
		textField.frame = CGRect(x: 8, y: 8, width: CGRectGetWidth(frame)*0.8, height: 24)
		textField.backgroundColor = UIColor.whiteColor()
		textField.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3).CGColor
		textField.layer.borderWidth = 0.8
		textField.borderStyle = .RoundedRect
		textField.placeholder = "Message"
		self.addSubview(textField)
		
		sendButton = UIButton.buttonWithType(.System) as! UIButton
		sendButton.tintColor = UIColor.grayColor()
		sendButton.setTitle("Send", forState: .Normal)
		sendButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: UIFont.systemFontSize())
		sendButton.frame = CGRect(x: CGRectGetWidth(frame)*0.8, y: 8, width: CGRectGetWidth(frame)*0.2, height: 24)
		sendButton.addTarget(self, action: "sendButtonPressed:", forControlEvents: .TouchUpInside)
		self.addSubview(sendButton)
	}
	
	func sendButtonPressed(sender: UIButton) {
		if self.textField.text != "" {
			delegate?.sendButtonPressedWith(self.textField.text)
			self.textField.text = ""
			self.endEditing(true)
		}
	}
	
	
	func keyboardWillShow(sender: NSNotification) {
		let dictionary = sender.userInfo as! Dictionary<String, AnyObject>
		let value = dictionary[UIKeyboardFrameEndUserInfoKey] as! NSValue
		let keyboardRect = value.CGRectValue();
		
		UIView.animateWithDuration(
			0.3,
			delay: 0,
			options: .CurveEaseInOut,
			animations: { void in
				self.transform = CGAffineTransformMakeTranslation(0, -keyboardRect.size.height)
			}, completion: nil)
	}
	
	func keyboardWillHide(sender: NSNotification) {
		UIView.animateWithDuration(
			0.3,
			delay: 0,
			options: .CurveEaseInOut,
			animations: { void in
				self.transform = CGAffineTransformMakeTranslation(0, 0)
			}, completion: nil)
		
	}
	
}
