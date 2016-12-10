//
//  XYInputView.swift
//  XYInputView
//
//  Created by X140Yu on 15/5/30.
//  Copyright (c) 2015年 X140Yu. All rights reserved.
//

import UIKit

@objc protocol XYInputViewDelegate {
	func sendButtonPressedWith(_ str: String)
}

class XYInputView: UIView
{
    weak var delegate: XYInputViewDelegate!
	fileprivate var textField = UITextField()
	fileprivate var sendButton = UIButton()
	fileprivate var originFrame = CGRect()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
		self.frame = CGRect(x: 0, y: frame.minY, width: frame.width, height: frame.height)
		self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3).cgColor
		self.layer.borderWidth = 0.5
		originFrame = self.frame
		
		self.addCustomView()
		
		NotificationCenter.default.addObserver(self, selector: #selector(XYInputView.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(XYInputView.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	fileprivate func addCustomView() {
		textField.frame = CGRect(x: 8, y: 8, width: frame.width*0.8, height: 24)
		textField.backgroundColor = UIColor.white
		textField.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3).cgColor
		textField.layer.borderWidth = 0.8
		textField.borderStyle = .roundedRect
		textField.placeholder = "Message"
		self.addSubview(textField)

        sendButton = UIButton(type: .system)
		sendButton.tintColor = UIColor.gray
		sendButton.setTitle("Send", for: UIControlState())
		sendButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: UIFont.systemFontSize)
		sendButton.frame = CGRect(x: frame.width*0.8, y: 8, width: frame.width*0.2, height: 24)
		sendButton.addTarget(self, action: #selector(XYInputView.sendButtonPressed(_:)), for: .touchUpInside)
		self.addSubview(sendButton)
	}
	
	func sendButtonPressed(_ sender: UIButton) {
		if self.textField.text != "" {
			delegate?.sendButtonPressedWith(self.textField.text!)
			self.textField.text = ""
			self.endEditing(true)
		}
	}
	
	
	func keyboardWillShow(_ sender: Notification) {
		let dictionary = sender.userInfo as! Dictionary<String, AnyObject>
		let value = dictionary[UIKeyboardFrameEndUserInfoKey] as! NSValue
		let keyboardRect = value.cgRectValue;
		
		UIView.animate(
			withDuration: 0.3,
			delay: 0,
			options: UIViewAnimationOptions(),
			animations: { void in
				self.transform = CGAffineTransform(translationX: 0, y: -keyboardRect.size.height)
			}, completion: nil)
	}
	
	func keyboardWillHide(_ sender: Notification) {
		UIView.animate(
			withDuration: 0.3,
			delay: 0,
			options: UIViewAnimationOptions(),
			animations: { void in
				self.transform = CGAffineTransform(translationX: 0, y: 0)
			}, completion: nil)
		
	}
	
}
