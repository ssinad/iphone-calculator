//
//  CalculatorModel.m
//  iPhone Calculator
//
//  Created by SS D on 10/23/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import "CalculatorModel.h"

@interface CalculatorModel ()
@property CalculatorOperator lastOperator;
@property NSDecimalNumber * lastOperand;


@end

@implementation CalculatorModel
-(void)addOperand:(NSDecimalNumber *)operand{
    if ([self.result compare:@(0)] == NSOrderedSame){
        self.result = [operand copy];
    }
    self.lastOperand = operand;
}

+(BOOL)isValidNumber:(NSString*) number{
    if ([number isEqualToString:@""])
        return NO;
    //NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]*(\\.[0-9]+)?" options:NSRegularExpressionCaseInsensitive error:nil];
    NSRange range = [regex rangeOfFirstMatchInString:number options:0 range:NSMakeRange(0, number.length)];
    if (range.location != 0 || range.length != number.length){
        NSLog(@"Wrong format");
        return NO;
    }
    return YES;
}


-(void) evalExpressionWithOperator:(CalculatorOperator)calculatorOperator secondOperand: (NSDecimalNumber*) operand{
//    NSDecimalNumber *c;
    
    
    switch (calculatorOperator) {
        case ADD:
            //c = a + b;
            self.result = [self.result decimalNumberByAdding:operand];
            //NSDecimalAdd(c, a, b, NSRoundPlain);
            break;
        case SUBTRACT:
            //c = a - b;
            self.result = [self.result decimalNumberBySubtracting:operand];
            break;
        case MULTIPLY:
            //c = a * b;
            self.result = [self.result decimalNumberByMultiplyingBy:operand];
            break;
        case DIVIDE:
            //c = a / b;
            if ([operand compare:@(0)] == NSOrderedSame){
                return; //@"Division By Zero";
            }
            self.result = [self.result decimalNumberByDividingBy:operand];
            break;
        default:
//            c = 0;
            break;
    }
    
}


//-(NSDecimalNumber *) calculateFirstOperand:(NSDecimalNumber *) a calculatorOperator:(CalculatorOperator)calculatorOperator secondOperator: (NSDecimalNumber*) b{
//    NSDecimalNumber *c;
//    
//    
//    switch (calculatorOperator) {
//        case ADD:
//            //c = a + b;
//            c = [a decimalNumberByAdding:b];
//            //NSDecimalAdd(c, a, b, NSRoundPlain);
//            break;
//        case SUBTRACT:
//            //c = a - b;
//            c = [a decimalNumberBySubtracting:b];
//            break;
//        case MULTIPLY:
//            //c = a * b;
//            c = [a decimalNumberByMultiplyingBy:b];
//            break;
//        case DIVIDE:
//            //c = a / b;
//            if ([b doubleValue] == 0){
//                NSLog(@"Division by zero");
//                return 0;
//            }
//            c = [a decimalNumberByDividingBy:b];
//            break;
//        default:
//            c = 0;
//            break;
//    }
//    return c;
//}

@end
