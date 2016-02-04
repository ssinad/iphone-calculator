//
//  EvaluationModel.m
//  iPhone Calculator
//
//  Created by SS D on 30/10/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import "EvaluationModel.h"

@interface EvaluationModel ()

@property NSMutableArray<NSNumber *> * operators;
@property NSMutableArray<NSDecimalNumber *> * operands;
@property NSString * evalString;
//@property CalculatorOperator lastOperator;
//@property NSDecimalNumber * lastOperand;
@property NSDecimalNumber * result;

-(BOOL)shouldPushIntoOperatorStack:(CalculatorOperator) calculatorOperator;
-(NSDecimalNumber *) calculateFirstOperand:(NSDecimalNumber *) a calculatorOperator:(CalculatorOperator)calculatorOperator secondOperator: (NSDecimalNumber*) b;
//-(NSString *)evaluateWithOperand: operand;
-(void)logCalculationWithFirst:(NSDecimalNumber *) a calculatorOperator:(CalculatorOperator)calculatorOperator second: (NSDecimalNumber*) b andResult:(NSDecimalNumber *) result;

@end

@implementation EvaluationModel


-(NSString *)evaluateAll{
    while (self.operators.count != 0){
        [self popFromStacks];
    }
    return [self.operands.lastObject stringValue];
}

-(void)addOperand:(NSDecimalNumber *)operand{
    [self.operands addObject:operand];
//    self.lastOperand = operand;
}

-(NSString *)replaceOperator:(NSUInteger) calculatorOperator{
    [self.operators removeLastObject];
    return [self addCalculatorOperator:calculatorOperator];
}

-(NSString *)addCalculatorOperator:(NSUInteger)calculatorOperator{
//    NSString * temporaryString = @"";
    NSDecimalNumber * temporaryResult = self.operands.lastObject;
    while (![self shouldPushIntoOperatorStack:calculatorOperator]){
        temporaryResult = [self popFromStacks];
    }
    [self.operators addObject:@(calculatorOperator)];
//    self.lastOperator = calculatorOperator;
//    NSLog(@"%@", temporaryResult);
//    NSNumberFormatter numberFormatter = [[NSNumberFormatter alloc]init];
    return [temporaryResult stringValue];
}

-(NSDecimalNumber*) popFromStacks{
    CalculatorOperator calculatorOperator = [self.operators.lastObject intValue];
    [self.operators removeLastObject];
    NSDecimalNumber* b = self.operands.lastObject;
    [self.operands removeLastObject];
    NSDecimalNumber* a = self.operands.lastObject;
    [self.operands removeLastObject];
    NSDecimalNumber* c = [self calculateFirstOperand:a calculatorOperator:calculatorOperator secondOperator:b];
    [self.operands addObject:c];
    return c;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // superclass successfully initialized, further
        // initialization happens here ...
        self.operands = [[NSMutableArray alloc]init];
        self.operators = [[NSMutableArray alloc]init];
        self.result = (NSDecimalNumber*) @(0);
    }
    return self;
}


-(BOOL)shouldPushIntoOperatorStack:(CalculatorOperator)calculatorOperator{
    if (self.operators.count == 0)
        return YES;
    if (( calculatorOperator == MULTIPLY || calculatorOperator == DIVIDE) && ([self.operators.lastObject isEqualToNumber:@(ADD)] || [self.operators.lastObject isEqualToNumber:@(SUBTRACT)])){
        return YES;
    }
    return NO;
}


-(NSDecimalNumber *) calculateFirstOperand:(NSDecimalNumber *) a calculatorOperator:(CalculatorOperator)calculatorOperator secondOperator: (NSDecimalNumber*) b{
    NSDecimalNumber *c;
    
    
    switch (calculatorOperator) {
        case ADD:
            //c = a + b;
            c = [a decimalNumberByAdding:b];
            //NSDecimalAdd(c, a, b, NSRoundPlain);
            break;
        case SUBTRACT:
            //c = a - b;
            c = [a decimalNumberBySubtracting:b];
            break;
        case MULTIPLY:
            //c = a * b;
            c = [a decimalNumberByMultiplyingBy:b];
            break;
        case DIVIDE:
            //c = a / b;
            if ([b doubleValue] == 0){
//                NSLog(@"Division by zero");
                return 0;
            }
            c = [a decimalNumberByDividingBy:b];
            break;
        default:
            c = 0;
            break;
    }
//    [self logCalculationWithFirst:a calculatorOperator:calculatorOperator second:b andResult:c];
    NSNumber * abs = [NSNumber numberWithDouble:fabs([c doubleValue])];
    if (abs > 0 && [abs compare:@1e-90] == NSOrderedAscending){
        [NSException exceptionWithName:@"UnderflowException" reason:@"Underflow" userInfo:nil];
        [NSException raise:@"UnderFlowException" format:@"Underflow"];
    }
    return c;
}


-(void)logCalculationWithFirst:(NSDecimalNumber *)a calculatorOperator:(CalculatorOperator)calculatorOperator second:(NSDecimalNumber *)b andResult:(NSDecimalNumber *)result{
    NSString * evalStr = [NSString stringWithFormat:@"%@ ", a];
    switch (calculatorOperator) {
            
            case ADD:
//                        self.result = [self.result decimalNumberByAdding:operand];
            evalStr = [evalStr stringByAppendingString:@" + "];
                        break;
                    case SUBTRACT:
            evalStr = [evalStr stringByAppendingString:@" - "];
//                        self.result = [self.result decimalNumberBySubtracting:operand];
                        break;
                    case MULTIPLY:
            evalStr = [evalStr stringByAppendingString:@" × "];
//                        self.result = [self.result decimalNumberByMultiplyingBy:operand];
                        break;
                    case DIVIDE:
//                        if ([self.lastOperand compare:@(0)] == NSOrderedSame){
//                            return @"Division By Zero";
//                        }
//                        self.result = [self.result decimalNumberByDividingBy:operand];
            evalStr = [evalStr stringByAppendingString:@" ÷ "];
                        break;
                    default:
                        break;
                }
    evalStr = [evalStr stringByAppendingString:[NSString stringWithFormat:@"%@ = %@", b, result]];
    NSLog(@"%@", evalStr);
}
//-(NSString *)evaluateWithOperand: (NSDecimalNumber *) operand{
//    NSLog(@"%ld %@ %@", (long)self.lastOperator, self.result, operand);
//    switch (self.lastOperator) {
//        case ADD:
//            self.result = [self.result decimalNumberByAdding:operand];
//            break;
//        case SUBTRACT:
//            self.result = [self.result decimalNumberBySubtracting:operand];
//            break;
//        case MULTIPLY:
//            self.result = [self.result decimalNumberByMultiplyingBy:operand];
//            break;
//        case DIVIDE:
//            if ([self.lastOperand compare:@(0)] == NSOrderedSame){
//                return @"Division By Zero";
//            }
//            self.result = [self.result decimalNumberByDividingBy:operand];
//            break;
//        default:
//            break;
//    }
//    return [NSString stringWithFormat:@"%@", self.result];
//}


@end
