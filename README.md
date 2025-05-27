# 🛡️ PhishGuard

**AI-powered phishing detection app** built with Flutter to scan and secure links clicked across the device—automatically and in real time.**


---

## 🚀 Features

- 🔍 **Real-time URL Scanning** – Detects phishing links with over 92% accuracy.
- 🧠 **AI-Powered Risk Score** – Scores each URL from 0–100 based on threat level.
- 🌐 **Click-to-Scan From Any App** – Automatically detects and scans links clicked anywhere on the device, even if the PhishGuard app is not open.
- 🛡️ **In-App Secure Browser** – Opens verified links within a protected browser environment.
- 🚨 **Phishing Report System** – Allows users to report suspicious links in one tap.
- 🔒 **SSL Pinning** – Protects against man-in-the-middle attacks.
- ⚡ **Optimized Performance** – URL scan time reduced from 5s to 2.3s.
- 🔁 **Secure API Integration** – RESTful APIs with token authentication.

---

## 📱 Screenshots

| Home Screen | Scan Result | Report Phishing |
|-------------|-------------|-----------------|
| ![Home](assets/home.png) | ![Scan](assets/scan.png) | ![Report](assets/report1.png) |

---

## 🛠️ Tech Stack

- **Flutter & Dart** – UI development
- **Node.js + Express.js** – Backend REST APIs
- **MongoDB Atlas** – Threat database
- **Google Safe Browsing API** – URL threat evaluation
- **Platform-specific Intents/Listeners** – For intercepting link clicks across the device

---

## 🔐 Security Measures

- SSL Pinning  
- Sandboxed URL Execution  
- Token-based API Access  
- Input Validation and URL Encoding

---

## 📦 Installation

```bash
git clone https://github.com/am-saksham/PhishGuard.git
cd phish-guard
flutter pub get
flutter run
