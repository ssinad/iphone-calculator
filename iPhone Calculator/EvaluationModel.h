//
//  EvaluationModel.h
//  iPhone Calculator
//
//  Created by SS D on 30/10/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorFSMModel.h"

@interface EvaluationModel : NSObject

-(NSString *) evaluateAll;
-(NSString *) addCalculatorOperator:(NSUInteger) calculatorOperator;
-(void)addOperand:(NSDecimalNumber*) operand;
-(NSString *)replaceOperator:(NSUInteger) calculatorOperator;

@end
