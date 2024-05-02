# Lotto Picker App

## Overview

This app allows users to pick lottery numbers. It displays a main random number on the screen, which changes every 0.5 seconds. Users can tap on the number to select it, and the selected numbers are displayed on the screen. The first 5 numbers are randomly generated between 1 and 49, and the last 2 numbers are randomly generated between 1 and 12. Once all 7 numbers are selected, the timer stops and the selected numbers are displayed.

## Language Used

The app is written in Swift, Apple's programming language for iOS, macOS, watchOS, and tvOS development. Swift provides a powerful and intuitive syntax, making it easy to develop robust and efficient applications for Apple platforms.

The SwiftUI framework is used for building the user interface. SwiftUI is a modern declarative UI framework that allows developers to write concise and expressive code to create dynamic and interactive user interfaces. It simplifies the process of building UI components and enables faster development with live previews and real-time updates.

## Components

### ContentView.swift

This file contains the main ContentView struct, which is the entry point of the app. It controls the visibility of the LottoPickerView based on user interaction.

### LottoPickerView.swift

This file contains the LottoPickerView struct, which represents the main view of the app. It displays the main random number, handles user interactions, and manages the selection of lottery numbers.

### LottoBall.swift

This file contains the LottoBall struct, which represents a lottery ball displayed on the screen. It displays a number inside a colored circle to simulate a lottery ball.

### LottoPickerFunctions.swift

This file contains the LottoPickerFunctions struct, which contains utility functions for selecting numbers and generating unique random numbers. These functions are used in the LottoPickerView struct to manage the selection process.

## How to Use

To use the app, simply run it on an iOS device or simulator. Tap on the main random number to select it. Continue tapping to select additional numbers. Once all 7 numbers are selected, the timer will stop, and the selected numbers will be displayed on the screen.

To reset the selection and start again, pull down on the screen.

