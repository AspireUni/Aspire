import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

import './common_constants.dart';

// Onboarding Intro
const String getStartedSubTitle = 'To reach new heights';
const String getStartedBottomText = 
  'Let us find you a mentorship based on your preferences';
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
GlobalKey<AnimatorWidgetState> onboardingImagePartOneKey
  = GlobalKey<AnimatorWidgetState>();
GlobalKey<AnimatorWidgetState> onboardingImagePartTwoKey
  = GlobalKey<AnimatorWidgetState>();
GlobalKey<AnimatorWidgetState> onboardingImagePartThreeKey
  = GlobalKey<AnimatorWidgetState>();
  GlobalKey<AnimatorWidgetState> onboardingTextPartOneKey
  = GlobalKey<AnimatorWidgetState>();
GlobalKey<AnimatorWidgetState> onboardingTextPartTwoKey
  = GlobalKey<AnimatorWidgetState>();
GlobalKey<AnimatorWidgetState> onboardingTextPartThreeKey
  = GlobalKey<AnimatorWidgetState>();

// Onboarding Steps Config
List<Map<String, dynamic>> onboardingStepsConfig = [
  {
    "text": onboardingPartOneText,
    "image": 'images/onboarding/ano_standing.png',
    "buttonText": nextButtonText, 
    "isLight": true,
    "imageKey": onboardingImagePartOneKey,
    "textKey": onboardingTextPartOneKey
  },
  {
    "text": onboardingPartTwoText, 
    "image": 'images/onboarding/two_anos_and_logo.png',
    "buttonText": nextButtonText, 
    "isLight": true,
    "imageKey": onboardingImagePartTwoKey,
    "textKey": onboardingTextPartTwoKey
  }, 
  {
    "text": onboardingPartThreeText, 
    "image": 'images/onboarding/two_anos_talking.png',
    "buttonText": letsGetStartedButtonText, 
    "isLight": false,
    "imageKey": onboardingImagePartThreeKey,
    "textKey": onboardingTextPartThreeKey
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
const String isMentorAction = 'I am a Mentor';
const String isMenteeAction = 'I am a Mentee';