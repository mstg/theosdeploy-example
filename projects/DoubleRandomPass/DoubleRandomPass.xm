/* Created by Mustafa Gezen on 01.05.2014 */
#include "DoubleRandomPass.h"

%hook SpringBoard
    -(void)applicationDidFinishLaunching:(id)application {
        %orig;
        timesEntered = 1;
        unlockedOnce = false;
    }
%end

%hook SBDeviceLockController
    - (BOOL)attemptDeviceUnlockWithPassword:(NSString *)passcode appRequested:(BOOL)requested {
        correct = %orig;

        if (unlockedOnce) {
            if (timesEntered == 1) {
                if (correct) {
                    timesEntered++;
                    originalPasscode = [passcode stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [originalPasscode retain];
                    correct = NO;
                }
            } else if (timesEntered == 2) {
                passcode = originalPasscode;
                correct = %orig(passcode, requested);
            }
        }

        return correct;
    }
%end

%hook SBUIPasscodeLockViewWithKeypad
    - (id)statusTitleView {
        label = MSHookIvar<UILabel *>(self, "_statusTitleView");

        if (!unlockedOnce) {
            label.text = [NSString stringWithFormat:@"Unlock once after each respring"];
            return label;
        }

        return %orig;
    }
%end

%hook SBLockScreenViewController
    - (void)prepareForUIUnlock {
        timesEntered = 1;

        if (!unlockedOnce) {
            unlockedOnce = true;
        }

        %orig;
    }
%end
