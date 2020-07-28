import 'package:flutter/material.dart';

import '../ftu/login_create_account/login_create_account.dart';
import '../ftu/onboarding/screens.dart';
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

// Onboarding Screen Config
const double imageHeight = 150.0; 
var onboardingScreensConfig = [
  {
    "text": onboardingPartOneText,
    "image": Image.asset('images/onboarding/ano_standing.png', height: imageHeight),
    "nextScreen": (context) => OnboardingScreens(screenNum: 1), 
    "buttonText": nextButtonText, 
    "isLight": true
  },
  {
    "text": onboardingPartTwoText, 
    "image": Image.asset('images/onboarding/two_anos_and_logo.png', height: imageHeight),
    "nextScreen": (context) => OnboardingScreens(screenNum: 2),
    "buttonText": nextButtonText, 
    "isLight": true
  }, 
  {
    "text": onboardingPartThreeText, 
    "image": Image.asset('images/onboarding/two_anos_talking.png', height: imageHeight),
    "nextScreen": (context) => LoginCreateAccount(), 
    "buttonText": letsGetStartedButtonText, 
    "isLight": false
  }
];

// Login/CreateAccount
const String loginButtonText = 'Log into your account';
const String createAccountButtonText = 'Create a new account';
const String termsAndConditions = 'Terms and Conditions';
const String privacyPolicy = 'Privacy Policy';
const String linkDivider = ' | ';

// Sign Up Funnel
const String funnelQuestionText = 'Are you a mentor or a mentee?';
const String isMentorAction = 'I am a mentor';
const String isMenteeAction = 'I am a mentee';