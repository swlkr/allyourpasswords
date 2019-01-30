//
//  DMIssuesWindowController.h
//  DevMateIssues
//
//  Copyright 2009-2018 DevMate Inc. All rights reserved.
//

#import "DMIssueReportWindowController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DMIssuesWindowController : DMIssueReportWindowController

+ (instancetype)defaultController;

// IBOutlets & IBActions
@property (nonatomic, assign, nullable) IBOutlet NSImageView *appIcon;
@property (nonatomic, assign, nullable) IBOutlet NSTextField *titleField;
@property (nonatomic, assign, nullable) IBOutlet NSTextField *messageField;

@property (nonatomic, assign, nullable) IBOutlet NSTextField *userNameField;
@property (nonatomic, assign, nullable) IBOutlet NSTextField *userEmailField;

@property (nonatomic, assign, nullable) IBOutlet NSTextView *commentView;
@property (nonatomic, assign, nullable) IBOutlet NSButton *attachmentButton;

@property (nonatomic, assign, nullable) IBOutlet NSTextField *anonymousInfoField;
@property (nonatomic, assign, nullable) IBOutlet NSButton *sysInfoButton;

@property (nonatomic, assign, nullable) IBOutlet NSButton *sendButton;
@property (nonatomic, assign, nullable) IBOutlet NSButton *sendRestartButton;
@property (nonatomic, assign, nullable) IBOutlet NSProgressIndicator *progressIndicator;

- (IBAction)showSysInfo:(id)sender;
- (IBAction)attachFile:(id)sender;
- (IBAction)sendReport:(id)sender;
- (IBAction)sendAndRelaunch:(id)sender;
// -------------------------------

//! User comment that will be sent. Can be overriden by subclasses.
- (NSString *)userComment;

//! User attached file URLs that will be sent. Can be overriden by subclasses.
- (NSArray *)userAttachmentURLs;

@end

NS_ASSUME_NONNULL_END
