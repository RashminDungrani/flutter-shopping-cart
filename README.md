# Shopping Mall Application
This is a simple shopping mall application built with Flutter. The app has only 2 pages, the first page displays products fetched from a dummy JSON API, and the second page is the cart page where users can see added products and can also remove them. The app uses the drift database for storing cart items into the local database, and the BloC pattern is used as the state management library.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Screenshots

<div style="display:flex; justify-content:center">
    <div style="margin-right:10px; border:2px solid black; padding:2px;">
        <img src="https://user-images.githubusercontent.com/48521608/236441088-942452bb-f61f-4e98-9742-2e6ebbdf9fc9.jpg" width="400" />
    </div>
    <div style="margin-right:10px; border:2px solid black; padding:2px;">
        <img src="https://user-images.githubusercontent.com/48521608/236441103-4dbd0e7d-dc2e-406c-a3b3-048b654b409d.jpg" width="400" />
    </div>
</div>
<br>

## Prerequisites

To run this project, you need to have Flutter installed on your local machine. Follow the installation instructions [here](https://docs.flutter.dev/get-started/install).

## Installing
1. Clone this repository on your local machine using the following command:
    ```bash
    git clone https://github.com/RashminDungrani/flutter-shopping-cart
    ```
1. Navigate to the project directory:
    ```bash
    cd flutter-shopping-cart
    ```
1. Install the dependencies using the following command:
    ```bash
    flutter pub get
    ```
1. Run the app on your preferred emulator or device using the following command:
    ```bash
    flutter run
    ```

## Features
- The shopping mall application has the following features:
    - Fetch products from a dummy JSON API and display them on the Products page.
    - Add and remove products to/from the cart on the Cart page.
    - Store cart items into the local database using the drift database.
    - Use the BloC pattern as the state management library.

## Built With
- Flutter - Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- drift - A high-performance, easy-to-use SQLite database library for Flutter.
- BloC pattern - A predictable state management library that helps implement the Business Logic Component pattern.

## Authors
Rashmin Dungrani - Initial work - [Rashmin](https://github.com/RashminDungrani/)

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.