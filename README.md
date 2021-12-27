# WTest
- Started as a chalenge for an iOS position, but will be updated during my free time with good pratices and code examples.
- Structured by modules with two clean architecture examples:
        - VIPER-B
        - MVVM(-C) with combine
- SwiftUI example (to be developed).
- Swift Package Manager for dependecies.

App current behaviour:
  - Starts downloading a CSV file with postal codes from Portugal.
  - All data is saved in Realm database.
  - If by some reason the app is closed during the CSV file download, the process restarts when launched again.
  - The postal codes are presented as a list.

Note: Work in progress
