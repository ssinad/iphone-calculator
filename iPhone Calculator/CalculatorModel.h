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
    N = -1,
    ADD = 0,
    SUBTRACT = 1,
    MULTIPLY = 2,
    DIVIDE = 3
};

-(NSString * )addOperator:(CalculatorOperator) calculatorOperator;
-(void)addOperand:(NSString *) operand;
+(BOOL)isValidNumber : (NSString *) string;
-(void)resetAll;
-(NSString *) equalEval;
-(NSString *) equalEval:(NSString *) operand;
-(NSString *) percentEval;
-(void) eval;

@property (readonly) NSString * resultString;
@property NSError * error;

@end
