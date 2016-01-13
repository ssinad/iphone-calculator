//
//  CalculatorModel.h
//  iPhone Calculator
//
//  Created by SS D on 10/23/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject
typedef NS_ENUM(NSUInteger, CalculatorOperator) {
    ADD = 0,
    SUBTRACT = 1,
    MULTIPLY = 2,
    DIVIDE = 3
};

-(void)addOperator:(CalculatorOperator) calculatorOperator;
-(void)addOperand:(NSDecimalNumber *) operand;
+(BOOL)isValidNumber : (NSString *) string;
@property NSDecimalNumber * result;
@property NSError * error;

@end
