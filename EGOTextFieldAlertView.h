//
//  EGOTextFieldAlertView.h
//  EGOTextFieldAlertViewDemo
//
//  Created by Shaun Harrison on 11/16/09.
//  Copyright (c) 2009 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@interface EGOTextFieldAlertView : UIAlertView {
@private
	NSMutableArray* __textFields; // Single underscore is used in UIAlertView
	BOOL overrodeHeight;
	CGFloat textFieldHeightOffset;
}

//
// All of the methods below are intentionally named differently
// than the Apple private methods, as to not cause any false rejections
//

- (void)addTextField:(UITextField*)textField;
- (UITextField*)addTextFieldWithLabel:(NSString*)label;
- (UITextField*)addTextFieldWithLabel:(NSString*)label value:(NSString*)value;

- (UITextField*)textFieldForIndex:(NSInteger)index;

@property(nonatomic,readonly) NSInteger numberOfTextFields;
@property(nonatomic,readonly) UITextField* firstTextField;
@end
