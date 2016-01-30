//
//  JZMessageEditViewController.swift
//  jianzhi
//
//  Created by daniel on 16/1/30.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

protocol JZMessageEditViewControllerDelegate : NSObjectProtocol {
    func messageEditViewControllerHeightDidChange(controller:JZMessageEditViewController, height: CGFloat, duration:NSTimeInterval)
//    func messageEditViewControllerWillBeginEdit(controller:JZMessageEditViewController)
    func messageEditViewControllerDidSendMessage(controller: JZMessageEditViewController, text:String)
}

class JZMessageEditViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: JZMessageEditViewControllerDelegate?
    
    @IBOutlet weak var messageEditView: JZMessageEditView!
    var heightConstraint: NSLayoutConstraint?
    private var keyboardHeight: CGFloat = 0
    private var textContentHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageEditView.textView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillChangeNotification:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillChangeNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            dispatch_async(dispatch_get_main_queue()) {
            self.updateWithKeyboardFrame(userInfo)
            }
        }
    }
    
    func updateWithKeyboardFrame(userInfo: NSDictionary) {
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval) ?? 0.25
        if //let fromFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue,
            let toFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let superview = view.superview {
//                let fromFrameIn = superview.convertRect(fromFrame.CGRectValue(), fromView: view.window)
                let toFrameIn = superview.convertRect(toFrame.CGRectValue(), fromView: view.window)
                keyboardHeight = superview.frame.height - toFrameIn.minY
                
                UIView.beginAnimations(nil, context: nil)
                if let curveRawValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int {
                    if let curve = UIViewAnimationCurve(rawValue: curveRawValue) {
                        UIView.setAnimationCurve(curve)
                    }
                }
                UIView.setAnimationDuration(duration)
                
                delegate?.messageEditViewControllerHeightDidChange(self, height: (self.messageEditView.heightConstraint?.constant ?? 0) + self.keyboardHeight, duration: duration)
                
                UIView.commitAnimations()
        }
    }
    
    
    // MARK: - text view
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            delegate?.messageEditViewControllerDidSendMessage(self, text: textView.text)
            
            textView.text = ""
            autoUpdateFrame(textView)
            return false
        }
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        autoUpdateFrame(textView)
    }
    
    func autoUpdateFrame(textView:UITextView) {
        let size = textView.sizeThatFits(CGSizeMake(textView.frame.width, CGFloat.max))
        let height = (size.height + 10)<46 ? 46 : (size.height + 10)
        guard height < 100 else { return }
        if height != textContentHeight {
            textContentHeight = height
            messageEditView.heightConstraint?.constant = textContentHeight
            UIView.beginAnimations(nil, context: nil)
            delegate?.messageEditViewControllerHeightDidChange(self, height: height + keyboardHeight, duration: 0.25)
            UIView.commitAnimations()
        }
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
//        delegate?.messageEditViewControllerWillBeginEdit(self)
        return true
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        return messageEditView.textView.becomeFirstResponder()
    }
    
    override func canResignFirstResponder() -> Bool {
        return messageEditView.textView.canResignFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return messageEditView.textView.resignFirstResponder()
    }
}
