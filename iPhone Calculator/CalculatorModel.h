//
//  CalculatorModel.h
//  iPhone Calculator
//
//  Created by SS D on 29/10/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject
typedef NS_ENUM(NSUInteger, CalculatorState) {
    CalculatorStateInitial,
    CalculatorStateEnteringFirstNumber,
    CalculatorStateEnteringNumber,
    CalculatorStateFirstOperatorSelected,
    CalculatorStateOperatorSelected,
    CalculatorStateEqual
};
typedef NS_ENUM(NSUInteger, CalculatorOperator) {
    N = -1,
    ADD = 0,
    SUBTRACT = 1,
    MULTIPLY = 2,
    DIVIDE = 3
};
@property (readonly) CalculatorState state;
-(void)addCharacter:(NSString *) character;
-(NSString *)addOperator:(CalculatorOperator) calculatorOperator andLabelText: (NSString *) number;
-(void)resetAll;
@end
