#import "version.h"

static NSDate *lastLocked; // Static variable that holds the NSDate of the last locked time
static NSTimer *updateEverySecond;
static NSUserDefaults *dontationAlertSettings;
static NSString *language = [[[NSLocale preferredLanguages] objectAtIndex:0] substringToIndex:2];


@interface NZ9TimeFormat : NSObject

+ (NSString *)nz9_lastLockedTimeFormat; // Class method that will be used to format the time string

@end

@implementation NZ9TimeFormat : NSObject

+ (NSString *)nz9_lastLockedTimeFormat {
	NSInteger secondCount = 0; // Initialize the secondCount to 0

	if(lastLocked) {
		secondCount = ceil(lastLocked.timeIntervalSinceNow*(-1)); // If the lastLocked date exists, set the secondCount to the total number of seconds passed
	}

	NSInteger minuteCount = floor(secondCount / 60); // Calculate number of minutes
	NSInteger hourCount = floor(minuteCount / 60); // Calculate number of hours
	NSInteger dayCount = floor(hourCount / 24); // Calculate number of days
	NSInteger monthCount = floor(dayCount / 30.42); // Calculate number of months
	NSInteger yearCount = floor(monthCount / 12); // Calculate number of years

	secondCount = secondCount % 60; // Calculate the number of actual seconds (between 0 and 60 seconds)
	minuteCount = minuteCount % 60; // Calculate the number of actual minutes
	hourCount = hourCount % 24; // Calculate the number of actual hours
	dayCount = dayCount % 30; // Calculate the number of actual days
	monthCount = monthCount % 12; // Calculate the number of actual months

  NSString *formattedString = @"LastLocked: Language not supported.";

  if([language isEqualToString: @"nl"]) { // Dutch format
    formattedString = @"Vergrendeld"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld jr", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld jr", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld maand", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mdn", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dg", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dgn", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld uur", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld u", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sec", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sec", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" geleden"]; // Append "ago" to the string
  }
  else if([language isEqualToString: @"he"]) { // Hebrew format
    formattedString = @"ננעל לפני"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
    if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld שנה", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld שנים", (long)yearCount];
  	}
    if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld חודש", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld חודשים", (long)monthCount];
  	}
    if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld יום", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ימים", (long)dayCount];
  	}
    if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld שעה", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld שעות", (long)hourCount];
  	}
    if(minuteCount > 0) {
  		if(minuteCount == 1)
    		formattedString = [formattedString stringByAppendingFormat: @" %ld דקה", (long)minuteCount];
    	else
    		formattedString = [formattedString stringByAppendingFormat: @" %ld דקות", (long)minuteCount];
    }
    if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld שנייה", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld שניות", (long)secondCount];
  }
  else if([language isEqualToString: @"sv"]) { // Swedish format
    formattedString = @"Låst"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld år", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld år", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mån", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld månader", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dag", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dagar", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld tim", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld tim", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sek", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sek", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" sedan"]; // Append "ago" to the string
  }
  else if([language isEqualToString: @"ja"]) { // Japanese format
    formattedString = @"最後のロック :"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 年", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 年", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ヶ月", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ヶ月", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 日", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 日", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 時間", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 時間", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 分", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld 分", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld 秒", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld 秒", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" 前"]; // Append "ago" to the string
  }
  else if([language isEqualToString: @"ar"]) { // Arabic format
    formattedString = @"قلف ‌شده بود"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld سال", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld سال ها", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ماه", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ماها", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld روز", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld روز ها", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ساعت", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ساعت ها", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld دقیقه", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld دقیقه ها", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld ثانیه", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld ثانیه ها", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" قبل"]; // Append "ago" to the string
  }
  else if([language isEqualToString: @"tr"]) { // Turkish format
    formattedString = @""; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld yıl", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld yıl", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ay", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld ay", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld gün", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld gün", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld saat", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld saat", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dakika", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld dakika", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld saniye", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld saniye", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" önce kilitlendi"]; // Append "ago" to the string
  }
  else { // English format (default)
    formattedString = @"Locked"; // Begin formatting string

  	// Do all of the formatting stuff by appending the string
  	if(yearCount > 0) {
  		if(yearCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld yr", (long)yearCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld yrs", (long)yearCount];
  	}
  	if(monthCount > 0) {
  		if(monthCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mon", (long)monthCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mons", (long)monthCount];
  	}
  	if(dayCount > 0) {
  		if(dayCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld day", (long)dayCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld days", (long)dayCount];
  	}
  	if(hourCount > 0) {
  		if(hourCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld hr", (long)hourCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld hrs", (long)hourCount];
  	}
  	if(minuteCount > 0) {
  		if(minuteCount == 1)
  			formattedString = [formattedString stringByAppendingFormat: @" %ld min", (long)minuteCount];
  		else
  			formattedString = [formattedString stringByAppendingFormat: @" %ld mins", (long)minuteCount];
  	}
  	if(secondCount == 0 || secondCount == 1)
  		formattedString = [formattedString stringByAppendingFormat: @" %ld sec", (long)secondCount];
  	else
  		formattedString = [formattedString stringByAppendingFormat: @" %ld secs", (long)secondCount];

  	formattedString = [formattedString stringByAppendingFormat: @" ago"]; // Append "ago" to the string
  }

	return formattedString; // Return the formatted string
}

@end

%group iOS10
%hook SBUICallToActionLabel // "Hook" the SBUICallToActionLabel class to change pre-existing methods

- (id)init {
	%orig;
	updateEverySecond = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setText:) userInfo:nil repeats:YES];
	return self;
}

- (void)setText:(id)arg1 {
	NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat]; // Get formatted string
	%orig(newString); // Call the original method with the formatted string
}

- (void)setText:(id)arg1 forLanguage:(id)language animated:(BOOL)animated {
	NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat]; // Get formatted string
	%orig(newString, language, animated); // Call the original method with the formatted string
}

%end


@interface SBDashBoardViewController : UIViewController <UIAlertViewDelegate>
@end

%hook SBDashBoardViewController

- (void)loadView {
	%orig; // Call original "loadView" method
  lastLocked = [[NSDate date] retain]; // Set the lastLocked NSDate to the current date
  if([dontationAlertSettings integerForKey: @"unlockCount"] == 15) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enjoying my tweak, LastLocked?" message:@"Please consider donating so I can continue to develop tweaks like this! -NeinZedd9 <3" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Donate", nil];
    [alert show];
    [alert release];
  }
  [dontationAlertSettings setInteger: ([dontationAlertSettings integerForKey: @"unlockCount"] + 1) forKey: @"unlockCount"];
}

%new - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex != [alertView cancelButtonIndex]) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/neinzedd"]];
    }
}

%end
%end

%group iOS9

@interface SBLockScreenView : UIView <UIAlertViewDelegate>
@end

%hook SBLockScreenView

- (void)didMoveToWindow {
	%orig;
	lastLocked = [[NSDate date] retain]; // Set the lastLocked NSDate to the current date
	updateEverySecond = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setCustomSlideToUnlockText:) userInfo:nil repeats:YES];
  if([dontationAlertSettings integerForKey: @"unlockCount"] == 15) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enjoying my tweak, LastLocked?" message:@"Please consider donating so I can continue to develop tweaks like this! -NeinZedd9 <3" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Donate", nil];
    [alert show];
    [alert release];
  }
  [dontationAlertSettings setInteger: ([dontationAlertSettings integerForKey: @"unlockCount"] + 1) forKey: @"unlockCount"];

}


- (void)setCustomSlideToUnlockText:(NSString *)text {
	NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat]; // Get formatted string
	%orig(newString); // Call the original method with the formatted string
}

- (void)setCustomSlideToUnlockText:(NSString *)text animated:(BOOL)arg2 {
	NSString *newString = [NZ9TimeFormat nz9_lastLockedTimeFormat]; // Get formatted string
  %orig(newString, arg2); // Call the original method with the formatted string
}

%new - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex != [alertView cancelButtonIndex]) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/neinzedd"]];
    }
}


%end
%end



%ctor {
  dontationAlertSettings = [[NSUserDefaults alloc] initWithSuiteName: @"com.neinzedd9.LastLocked"];
  [dontationAlertSettings registerDefaults:@{
    @"unlockCount": @0
  }];
	if(IS_IOS_OR_NEWER(iOS_10_0)) {
		%init(iOS10);
	}
	else {
		%init(iOS9);
	}
}