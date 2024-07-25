
# Flutter - Webscraper Web application

A Web application that enable us to scrap, analyse an html and does the following.

## Features

- Takes input and validate if the url conforms to a valide url (https, http, 127.0.0.1, localhost)
- Display the data taken from a server

## Architecture Overview

The project follows the Clean Architecture principles, separating the app into different layers:

- **Presentation Layer**: Contains the Flutter widgets, Blocs, and UI-related logic.
- **Domain Layer**: Contains business logic and use cases.
- **Data Layer**: Manages data sources such as APIs.

## State Management

The app uses the Bloc pattern for state management. Blocs are responsible for managing the application's state and business logic.

## Getting Started

1. Install dependencies:\
   **N.B:** We are using flutter version **3.22.4**

   ```bash
   flutter pub get

2. Run the app:

   ```bash
   flutter run


