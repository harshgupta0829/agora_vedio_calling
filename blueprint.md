# TalknEarn Blueprint

## Overview

TalknEarn is a mobile application that allows users to earn rewards by chatting with others. The application uses Agora for real-time messaging, includes a wallet feature for managing rewards, and integrates Razorpay for in-app purchases.

## Implemented Features

*   **Authentication:**
    *   Login screen
*   **Chat:**
    *   Real-time messaging using Agora RTM
    *   Displaying chat messages
    *   Sending chat messages
*   **Wallet:**
    *   Mock wallet repository for managing rewards
*   **Payments:**
    *   Integrated `razorpay_flutter` for in-app purchases.
    *   Created a `RazorpayService` to handle payment logic.
    *   Added a "Buy Credits" button on the home screen to initiate payments.
*   **Theming:**
    *   Light and dark theme support
*   **Routing:**
    *   GoRouter for navigation
*   **State Management:**
    *   Bloc for state management

## Current Plan

The current plan was to integrate Razorpay for payments. This involved:

*   Adding the `razorpay_flutter` package.
*   Creating a `RazorpayService` to manage payment flows.
*   Adding a "Buy Credits" button to the `HomeScreen`.
*   Updating the project documentation.
