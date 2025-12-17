Problink Infocare – Delivery App
A simple Flutter delivery app built as a coding assignment for Problink Infocare LLP.
It uses Firebase OTP login, Firestore for delivery data, and QR code scanning for reading codes.

1. What this app does
Login with mobile number
Enter phone number
Validates basic format (10 digits)
Click Send OTP → triggers Firebase Phone Auth

OTP Verification
Enter 6‑digit OTP
Verifies with Firebase
Shows error messages if OTP is wrong / missing
On success → goes to Dashboard

Delivery List
Reads delivery documents from Firestore collection: deliveries
Shows:
Order ID
Customer name
Box count
Address
Date & time
Payment type
Status

QR Code Scanner
Uses mobile_scanner package
Asks for camera permission
Scans QR code and shows scanned data
“Scan Again” button to re‑scan
Back button goes back to Dashboard

2. Tech used
Flutter 
State management: provider
Firebase:
firebase_core
firebase_auth (phone auth)
cloud_firestore (delivery list)
QR code: mobile_scanner

3. How to run the app
From the project root:
flutter pub get
flutter run

4. How to test the app on a device
-Login & OTP
Open the app (splash screen will show briefly).
On the Login screen:
Enter: 7022221111
Tap Send OTP.

-On the OTP screen:
Enter: 123456
Tap Verify.
You should be taken to the Dashboard.

=Delivery List
From the bottom nav, tap Delivery.
You should see the list of deliveries from Firestore.

-QR Code Scanner
From the bottom nav, tap the Scan (center) icon.
Grant camera permission.
Point at any QR code.
When a QR is detected, you will see a “Scanned Successfully” screen with the raw data.

Important:
Delivery data is manually created in Firestore (no admin UI).
QR scanning only reads and displays data; updating delivery status in Firestore is optional and not implemented.
App is intended for a single login flow demo, not a production delivery system.
Tested primarily on Android (real device / emulator) with Firebase test phone/OTP.
