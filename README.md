# ✈️ Flight Booking App

A simple Flutter application that demonstrates a flight search and booking flow using **local mock data** (no APIs).

This project was built as part of a Flutter assignment to showcase UI design, navigation, filtering, and logic practices.

---

# 📱 Features

* Phone number login with validation
* Flight search using:

  * From city
  * To city
  * Date picker
* Custom bottom sheet calendar
* Flight listing with:

  * Airline logo
  * Departure & arrival time
  * Duration
  * Stops information
* Filters

  * Non-stop toggle
* Sorting

  * Price Low → High
  * Price High → Low
* Flight booking summary
* Booking confirmation popup
* Automatic redirect after booking

---

# 🧱 Architecture

The app follows a clean separation of **UI and logic**.

Folder structure:

lib/
controllers/
models/
extensions/
data/
pages/
widgets/

State management: **GetX**

Navigation: **GoRouter**

---


# 🛠️ Tech Stack

Flutter
Dart
GetX
GoRouter
Flutter ScreenUtil

---

# 🚀 How to Run

1. Clone the repository

git clone https://github.com/dvlpr-shubhamsawant/flybnb

2. Install dependencies

flutter pub get

3. Run the project

flutter run

---

# 📂 Mock Data

Flight data is stored locally in:

lib/data/mock_flights.dart

This includes:

* Airline name
* Price
* Departure time
* Arrival time
* Duration
* Stops

---

# 👨‍💻 Author

Shubham Sawant
Flutter Developer
