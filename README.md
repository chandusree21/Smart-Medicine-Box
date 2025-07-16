# 🧠 Smart Medicine Box (IoT Pill Reminder & Refill System)

**An IoT-enabled medicine dispenser with real-time reminders, pill-level tracking, and automated refill notifications—designed for better medication adherence.**

---

## 🚀 Overview

- **Platform**: Flutter Android app + Raspberry Pi microcontroller  
- **Purpose**: Alerts users to take medications on time and notifies pharmacies when refills are needed  
- **Audience**: Elderly individuals, chronic patients, caregivers, and pharmacists

---

## 🌟 Features

- 💡 **Scheduled Reminders**: App notifications, LED blinking, and buzzer alerts at dosing times  
- ⚖️ **Pill Tracking**: Load cell (weight sensor) tracks consumption and pill levels  
- 📲 **Refill Alerts**: Automatically sends SMS or app alerts to pharmacies when stock is low  
- 👥 **Caretaker Notifications**: Alerts to guardians if a dose is missed  
- ☁️ **Real-time Sync**: Firebase Firestore backend for data persistence and user authentication  

---

## 🧰 Tech Stack

| Component         | Tech / Tools                    |
|------------------|----------------------------------|
| Mobile App       | Flutter, Dart, Firebase         |
| Backend          | Firebase Firestore              |
| Hardware         | Raspberry Pi, Load Cell (HX711), PIR Sensor, LEDs |
| Languages        | Dart (Flutter), Python (Pi)     |

---

## 📱 Android App

- User login via phone/OTP  
- Manage medication schedules (CRUD)  
- Real-time alerts linked with hardware  
- Caregiver and pharmacy notifications

---

## 🖥️ Hardware Setup

1. Raspberry Pi + HX711 load cell for pill weight monitoring  
2. LEDs, buzzer, and PIR motion sensor for interactive alerts  
3. Python script interfaces with Firebase to monitor levels and dispatch refill notices  

---

## 🛠️ Setup Instructions

### Mobile App

```bash
git clone https://github.com/chandusree21/Smart-Medicine-Box.git
cd Smart-Medicine-Box/app
flutter pub get
flutter run --target lib/main.dart
