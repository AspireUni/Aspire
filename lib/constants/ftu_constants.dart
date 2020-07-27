import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

import './common_constants.dart';

// Onboarding Intro
const String getStartedSubTitle = 'To reach new heights';
const String getStartedBottomText = 
  'Let us find you a mentorship\nbased on your preferences';
const String getStartedButtonText = 'Get started';

// Onboarding Parts 1-3
const String onboardingPartOneText = 
  'Take the first step by creating a profile';
const String onboardingPartTwoText = 
  'Explore possibilities by matching with users';
const String onboardingPartThreeText = 
  'Take the next step by chatting with your matches';
const String onboardingPartThreeButtonText = 'Let\'s get started';
const String letsGetStartedButtonText = 'Let\'s get started';

// Animator keys
GlobalKey<AnimatorWidgetState> onboardingPartOneKey
  = GlobalKey<AnimatorWidgetState>();
GlobalKey<AnimatorWidgetState> onboardingPartTwoKey
  = GlobalKey<AnimatorWidgetState>();
GlobalKey<AnimatorWidgetState> onboardingPartThreeKey
  = GlobalKey<AnimatorWidgetState>();

// Onboarding Steps Config
List<Map<String, dynamic>> onboardingStepsConfig = [
  {
    "text": onboardingPartOneText,
    "image": Image.asset('images/onboarding/ano_standing.png', height: 150),
    "buttonText": nextButtonText, 
    "isLight": true,
    "animatorKey": onboardingPartOneKey
  },
  {
    "text": onboardingPartTwoText, 
    "image": Image.asset('images/onboarding/two_anos_and_logo.png', height: 150),
    "buttonText": nextButtonText, 
    "isLight": true,
    "animatorKey": onboardingPartTwoKey
  }, 
  {
    "text": onboardingPartThreeText, 
    "image": Image.asset('images/onboarding/two_anos_talking.png', height: 150),
    "buttonText": letsGetStartedButtonText, 
    "isLight": false,
    "animatorKey": onboardingPartThreeKey
  }
];

// Login/CreateAccount
const String loginButtonText = 'Log into your account';
const String createAccountButtonText = 'Create a new account';
const String termsAndConditions = 'Terms and Conditions';
const String privacyPolicy = 'Privacy Policy';
const String linkDivider = ' | ';

