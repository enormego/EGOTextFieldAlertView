//
//  RootViewController.m
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

#import "RootViewController.h"
#import "UIAlertView+Private.h"
#import "EGOTextFieldAlertView.h"

@interface RootViewController (Internal)
- (void)triggerUIAlertView;
- (void)triggerEGOTextFieldAlertView;
@end

@implementation RootViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	cell.textLabel.text = indexPath.row == 0 ? @"UIAlertView" : @"EGOTextFieldAlertView";

    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if(indexPath.row == 0) {
		[self triggerUIAlertView];
	} else {
		[self triggerEGOTextFieldAlertView];
	}
}

- (void)triggerUIAlertView {
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Authorization"
														message:@"Lorem ipsum dolor sit."
													   delegate:self
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:@"Login",nil];
	
	[alertView addTextFieldWithValue:@"" label:@"Username"];
	[alertView addTextFieldWithValue:@"" label:@"Password"];
	
	[alertView textFieldAtIndex:1].secureTextEntry = YES;
	[[alertView textFieldAtIndex:0] performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.05];
	
	[alertView show];
	[alertView autorelease];
}

- (void)triggerEGOTextFieldAlertView {
	EGOTextFieldAlertView* alertView = [[EGOTextFieldAlertView alloc] initWithTitle:@"Authorization"
														  message:@"Lorem ipsum dolor sit."
														 delegate:self
												cancelButtonTitle:@"Cancel"
												otherButtonTitles:@"Login",nil];
	
	[alertView addTextFieldWithLabel:@"Username"];
	[alertView addTextFieldWithLabel:@"Password"];
	
	[alertView textFieldForIndex:1].secureTextEntry = YES;
	
	[alertView show];
	[alertView autorelease];
}

- (void)dealloc {
    [super dealloc];
}


@end

