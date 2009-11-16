//
//  EGOTextFieldAlertView.m
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

#import "EGOTextFieldAlertView.h"
#import <QuartzCore/QuartzCore.h>

@interface EGOTextFieldAlertView (Internal)
- (CGFloat)_estimatedHeight;
@end

@interface EGOAlertTextFieldBack : UIView

@end

@implementation EGOTextFieldAlertView

- (void)layoutSubviews {
	[super layoutSubviews];

	if([self numberOfTextFields] > 0) {
		for(UITextField* textField in __textFields) {
			[textField.superview removeFromSuperview];
			[textField removeFromSuperview];
		}

		CGFloat offsetY = 0.0f;
		
		for(UIView* view in self.subviews) {
			if(![view isKindOfClass:[UIControl class]]) {
				if(CGRectGetMaxY(view.frame) > offsetY) {
					offsetY = CGRectGetMaxY(view.frame);
				}
			}
			
			if([view isKindOfClass:[EGOAlertTextFieldBack class]]) {
				[view removeFromSuperview];
			}
		}
		
		offsetY += 5.0f;

		for(UITextField* textField in __textFields) {
			EGOAlertTextFieldBack* backView = [[EGOAlertTextFieldBack alloc] initWithFrame:CGRectMake(11.0f, offsetY, 262.0f, 31.0f)];
			textField.frame = CGRectMake(5.0f, 4.0f, backView.frame.size.width-10.0f, backView.frame.size.height-9.0f);
			[backView addSubview:textField];
			[self addSubview:backView];
			
			offsetY = CGRectGetMaxY(backView.frame) + 10.0f;
			[backView release];
		}
		
		for(UIView* view in self.subviews) {
			if([view isKindOfClass:[UIControl class]] && ![view isKindOfClass:[UITextField class]]) {
				CGRect viewRect = view.frame;
				viewRect.origin.y = offsetY;
				view.frame = viewRect;
			}
		}
	}
}

- (void)show {
	if([self numberOfTextFields] > 0) {
		self.transform = CGAffineTransformTranslate(self.transform, 0.0f,  150.0f);
		
		// A delay is used here, because if the show animation gets choppy if the
		// keyboard is animated up at the same time, not sure why.
		[self.firstTextField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.4];
	}

	[super show];
}

- (void)setFrame:(CGRect)frame {
	if((frame.origin.x > 0 || frame.origin.x < -1) && !overrodeHeight) {
		frame.size.height += textFieldHeightOffset;
		overrodeHeight = YES;
	}
	
	[super setFrame:frame];
}

- (void)addTextField:(UITextField*)textField {
	if(!__textFields) {
		__textFields = [[NSMutableArray alloc] initWithCapacity:1];
	}
	
	textField.backgroundColor = [UIColor clearColor];
	textField.font = [UIFont systemFontOfSize:19.0f];
	textField.keyboardAppearance = UIKeyboardAppearanceAlert;
	
	[__textFields addObject:textField];
	
	textFieldHeightOffset = (self.numberOfTextFields * 41.0f) - 10.0f;
}

- (CGFloat)_estimatedHeight {
	CGFloat titleHeight = [self.title sizeWithFont:[UIFont boldSystemFontOfSize:17.0f] constrainedToSize:CGSizeMake(260.0f, CGFLOAT_MAX)].height;
	CGFloat messageHeight = [self.message sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(260.0f, CGFLOAT_MAX)].height;
	
	if(titleHeight > 0) {
		titleHeight += 10.0f;	
	}
	
	if(messageHeight > 0) {
		messageHeight += 10.0f;	
	}
	
	return titleHeight + messageHeight + textFieldHeightOffset + 43.0f + 30.0f; // 43.0f = button height, 35 = top/bottom padding
}

- (UITextField*)addTextFieldWithLabel:(NSString*)label {
	return [self addTextFieldWithLabel:label value:nil];
}

- (UITextField*)addTextFieldWithLabel:(NSString*)label value:(NSString*)value {
	UITextField* textField = [[UITextField alloc] initWithFrame:CGRectZero];
	textField.placeholder = label;
	textField.text = value;
	[self addTextField:textField];
	return [textField autorelease];
}

- (UITextField*)textFieldForIndex:(NSInteger)index {
	return [__textFields objectAtIndex:index];
}

- (NSInteger)numberOfTextFields {
	return __textFields.count;
}

- (UITextField*)firstTextField {
	if([self numberOfTextFields] > 0) {
		return [self textFieldForIndex:0];
	} else {
		return nil;
	}
}

- (void)dealloc {
	[__textFields release];
    [super dealloc];
}


@end

@implementation EGOAlertTextFieldBack

- (id)initWithFrame:(CGRect)frame {
	if((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	[[UIColor whiteColor] set];
	CGRect backgroundRect = CGRectMake(rect.origin.x+1.0f, rect.origin.y+1.0f, rect.size.width-2.0f, rect.size.height-3.0f);
	
	NSArray* colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.54 alpha:1.0].CGColor, [UIColor whiteColor].CGColor, [UIColor whiteColor].CGColor,nil];
	CGFloat locations[3] = {0.0, 0.10, 1.0};
	
	CGGradientRef gradient = CGGradientCreateWithColors(CGColorGetColorSpace([UIColor whiteColor].CGColor), (CFArrayRef)colors, locations);
	
	CGContextClipToRect(context, backgroundRect);
	CGContextDrawLinearGradient(context, gradient, CGPointMake(backgroundRect.origin.x, backgroundRect.origin.y), CGPointMake(backgroundRect.origin.x, CGRectGetMaxY(backgroundRect)), 0);
	
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
	
	[[UIColor blackColor] set];
	
	UIRectFill(CGRectMake(rect.origin.x, rect.origin.y, 1.0f, rect.size.height));
	UIRectFill(CGRectMake(CGRectGetMaxX(rect)-1.0f, rect.origin.y, 1.0f, rect.size.height));
	
	UIRectFill(CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 1.0f));
	UIRectFill(CGRectMake(rect.origin.x, CGRectGetMaxY(rect)-2.0f, rect.size.width, 1.0f));
	
	[[[UIColor whiteColor] colorWithAlphaComponent:0.2] set];
	UIRectFill(CGRectMake(rect.origin.x, CGRectGetMaxY(rect)-1.0f, rect.size.width, 1.0f));
}

@end