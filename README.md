# 📝 Offline Task Manager

A Flutter application that allows users to manage tasks **offline using sqflite**, and **syncs automatically to Firebase Firestore when online**. Built with `GetX` for reactive state management and clean architecture.

---

## 🚀 Features

- ✅ Create, update, delete tasks locally with sqflite
- 🔄 Automatic synchronization to Firestore when online
- 🌐 Real-time network connectivity monitoring using `connectivity_plus`
- 📶 Offline-first support for full functionality without internet
- ⚡ Smooth reactive UI powered by GetX
- 🧪 Basic unit testing for controller logic

---

## 🛠 Tech Stack

| Layer            | Technology               |
|------------------|---------------------------|
| UI               | Flutter + GetX            |
| Local Storage    | sqflite + path            |
| Remote Storage   | Firebase Firestore        |
| Sync Trigger     | connectivity_plus         |
| State Mgmt       | GetX                      |
| Testing          | flutter_test              |

---

## 📁 Project Structure

```
lib/
├── infrastructure/
│   ├── db/
│   │   └── local_db.dart               # Local sqflite database handler
│   ├── services/
│   │   └── firestore_service.dart      # Firestore API for remote sync
│   ├── models/
│   │   └── task_model.dart             # Task model
│   ├── constant/
│   │   ├── color_constant.dart         # Color constants
│   │   ├── app_constant.dart           # App-wide constants
│   │   └── image_constant.dart         # Asset constants
│   └── routes/
│       ├── app_pages.dart              # GetX route pages
│       └── route_constant.dart         # Named route strings
├── ui/
│   ├── common_widgets/
│   │   └── common_button.dart          # Custom button
│   └── home/
│       ├── home_screen.dart            # Task screen UI
│       ├── home_controller.dart        # GetX controller
│       └── home_bindings.dart          # Controller bindings
└── main.dart                           # App entry point
```

---

## 🔧 Setup Instructions

### 🔥 Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Add your Android/iOS app
4. Download:
    - `google-services.json` for Android → place in `android/app/`
    - `GoogleService-Info.plist` for iOS → place in `ios/Runner/`
5. Enable **Firestore** in Firebase Console

---

## 🔁 Sync Strategy

- Every task has an `updatedAt` timestamp.
- When online, sync runs automatically:

| Condition                       | Action             |
|--------------------------------|--------------------|
| `local.updatedAt > remote`     | Push to Firestore  |
| `remote.updatedAt > local`     | Pull from Firestore |
| Only in local/remote           | Add missing entry  |

- Sync is triggered by connectivity changes.

---

## 🧪 Testing

Run unit tests using:

```bash
flutter test
```

Tests included for controller logic.

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get:
  sqflite:
  path:
  connectivity_plus:
  firebase_core:
  cloud_firestore:

dev_dependencies:
  flutter_test:
    sdk: flutter
```

---

## 📌 TODO

- [ ] Add Firebase Auth for user-specific data
- [ ] Add task priority, deadlines, and labels
- [ ] Implement sync retry logic and error logging
- [ ] Add UI animations, light/dark themes

---

## 📸 Screenshots
![1](https://github.com/user-attachments/assets/522aabe4-0c69-450d-a1d7-3fb3563108dc) ![2](https://github.com/user-attachments/assets/d38413a3-24c7-4ac2-b5b1-28e9f29b5927) ![3](https://github.com/user-attachments/assets/2491b19e-8896-45d9-ba3d-84d7788b3b5b) ![4](https://github.com/user-attachments/assets/b2130cfb-cd50-410d-83ed-c5a90956dbfa) ![5](https://github.com/user-attachments/assets/1e2eb0cf-1752-47b9-a73d-e9d66ad38d55)




---

## 💡 License

This project is licensed under the MIT License.  
Feel free to use, modify, and contribute!

---
