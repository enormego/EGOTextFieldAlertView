//
//  UIAlertView+Private.h
//

#import <UIKit/UIKit.h>

//
//	DO NOT USE THESE IN A SUBMITTED BINARY!
//	These are only provided for comparison, your app will be rejected it if you use them.
//

@interface UIAlertView (Private)
+ (UIImage*)_popupAlertBackground:(BOOL)toggle;
- (UITextField*)addTextFieldWithValue:(NSString*)aValue label:(NSString*)aLabel;
- (UITextField*)textFieldAtIndex:(NSInteger)index;
- (NSInteger)textFieldCount;
- (UITextField*)textField;
- (id)keyboard;

@property(nonatomic,assign) BOOL groupsTextFields;
@end