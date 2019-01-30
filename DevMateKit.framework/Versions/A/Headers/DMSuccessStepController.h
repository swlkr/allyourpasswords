//
//  DMSuccessStepController.h
//  DevMateActivations
//
//  Copyright (c) 2012-2018 DevMate Inc. All rights reserved.
//

#import "DMStepController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMSuccessStepController : DMStepController

@property (nonatomic, assign, nullable) IBOutlet NSTextField *thanksField;
@property (nonatomic, assign, nullable) IBOutlet NSTextField *descriptionField;
@property (nonatomic, assign, nullable) IBOutlet NSButton *finishActivationButton;

- (IBAction)finishActivation:(id _Nullable)sender;

@end

NS_ASSUME_NONNULL_END
