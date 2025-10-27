GloveCom-App
It converts the sign language into text-to-speech 🧤 GloveCom – Sign Language to Speech Translator

🚀 Bridging the gap between sign language and speech through AI, IoT, and compassion.

GloveCom is a smart wearable + mobile system that detects hand gestures using flex sensors on an ESP32, sends them via Bluetooth (BLE) to a Flutter app, and translates them into real-time text and speech output.

🌟 Key Features

Feature Description

🤖 Gesture Detection Flex sensors detect finger movements and map them to predefined words/sentences. 🔊 Speech Output Converts recognized gestures to speech using Text-to-Speech (TTS). 💬 Speech-to-Text Assistant Converts user speech into text and forms intelligent sentences. 📱 Bluetooth Communication Real-time BLE link between glove (ESP32) and Flutter app. 🖐 Gesture Training Mode Users can train new gestures and link them to custom words. 🧠 AI-Inspired UI Futuristic dark-gold theme with smooth animations. 📜 Speech History Stores translated gestures and spoken words for review.

⚙ Tech Stack

🧩 Hardware

ESP32 Dev Board

Flex Sensors (5x)

Jumper Wires

Resistors (10KΩ each)

💻 Software

Flutter (Dart) – App UI + BLE communication

Arduino (C++) – ESP32 gesture firmware

Lottie – Animations

Supabase / MongoDB – Cloud backend (optional)

🔌 System Architecture

Flex Sensors → ESP32 → Bluetooth BLE → Flutter App → Text + Speech Output

📲 App Screenshots

Home Screen Gesture Training Voice Assistant

🧠 ESP32 Firmware (C++)

#include <BLEDevice.h> #include <BLEServer.h> #include <BLEUtils.h> #include <BLE2902.h>

#define SERVICE_UUID "847b6628-2150-4b77-b731-e557d04f8fec" #define CHARACTERISTIC_UUID "8c245332-9eba-48ce-b4b8-4483dec8f06b"

#define FLEX1_PIN 34 #define FLEX2_PIN 35 #define FLEX3_PIN 32 #define FLEX4_PIN 33 #define FLEX5_PIN 25

BLEServer* pServer = NULL; BLECharacteristic* pCharacteristic = NULL; bool deviceConnected = false; int flex1, flex2, flex3, flex4, flex5;

class MyServerCallbacks : public BLEServerCallbacks { void onConnect(BLEServer* pServer) { deviceConnected = true; Serial.println("✅ Connected"); } void onDisconnect(BLEServer* pServer) { deviceConnected = false; Serial.println("❌ Disconnected"); pServer->getAdvertising()->start(); } };

void setup() { Serial.begin(115200); BLEDevice::init("GloveCom_Glove"); pServer = BLEDevice::createServer(); pServer->setCallbacks(new MyServerCallbacks()); BLEService* pService = pServer->createService(SERVICE_UUID); pCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID, BLECharacteristic::PROPERTY_NOTIFY | BLECharacteristic::PROPERTY_READ); pCharacteristic->addDescriptor(new BLE2902()); pService->start(); pServer->getAdvertising()->start();

pinMode(FLEX1_PIN, INPUT); pinMode(FLEX2_PIN, INPUT); pinMode(FLEX3_PIN, INPUT); pinMode(FLEX4_PIN, INPUT); pinMode(FLEX5_PIN, INPUT); }

void loop() { if (deviceConnected) { flex1 = analogRead(FLEX1_PIN); flex2 = analogRead(FLEX2_PIN); flex3 = analogRead(FLEX3_PIN); flex4 = analogRead(FLEX4_PIN); flex5 = analogRead(FLEX5_PIN);

String message = detectGesture(flex1, flex2, flex3, flex4, flex5);
if (message.length() > 0) {
  pCharacteristic->setValue(message.c_str());
  pCharacteristic->notify();
  Serial.println("📤 Sent: " + message);
}
delay(300);
} }

String detectGesture(int f1, int f2, int f3, int f4, int f5) { if (f1 > 2800 && f2 > 2800 && f3 > 2800 && f4 > 2800 && f5 > 2800) return "HELLO, HOW ARE YOU?"; else if (f1 < 1000 && f2 < 1000 && f3 < 1000 && f4 < 1000 && f5 < 1000) return "THANK YOU VERY MUCH"; else if (f1 > 2000 && f2 < 1200 && f3 < 1200 && f4 < 1200 && f5 < 1200) return "I AM HAPPY TODAY"; else if (f1 < 1200 && f2 > 2000 && f3 > 2000 && f4 < 1200 && f5 < 1200) return "PLEASE HELP ME"; else if (f1 > 2000 && f2 > 2000 && f3 < 1000 && f4 < 1000 && f5 < 1000) return "GOOD MORNING"; else return ""; }

📱 Flutter Setup

Clone this repository
git clone https://github.com/Dhanushkumarsekar/GloveCom.git cd GloveCom

Install dependencies
flutter pub get

Run on device
flutter run

To build release APK
flutter build apk --release

💡 Future Upgrades

🧠 AI-based dynamic gesture recognition using CNN

🌎 Multi-language translation (English, Hindi, Tamil, Telugu)

☁ Cloud sync of gesture history

🔊 Emotion-aware speech tone generation

🏆 Achievements

🥈 State 2nd – Atal Tinkering Lab

🥈 National 2nd – Amazon Best Project & Reel

🥇 1st Place – College Project Expo (CIET)

🏅 National Top 10 – Impairathon by KIIC

💡 Recognized by ThinkStartup for Business Innovation

👨‍💻 Developer

Dhanushkumar Sekar 🎓 B.E. Computer Science & Engineering @ CIET 💡 Startup Founder | Innovator | Tech for Society 🌐 Portfolio 🐙 GitHub 💼 LinkedIn

🧩 License

This project is licensed under the MIT License – free to use, modify, and share. Let’s make communication accessible for everyone ❤

Would you like me to:

Generate a README with badges and shields (e.g. “Made with Flutter”, “MIT License”, “Open Source”)

Or generate a visual GitHub cover/banner (GloveCom – Sign Language to Speech Translator) for your repo header?



# GloveCom
A minimal Flutter starter project for GloveCom — a glove-to-app sign language translator using ESP32 over BLE + Supabase backend.

## What is included
- Flutter project skeleton (lib/)
- Screens: BLE connection, Gesture Training, Voice Assistant, Speech History
- Services: bluetooth_service, supabase_service, tts_service
- Models and utils
- Supabase SQL schema file

## Setup
1. Install Flutter and required SDKs.
2. Copy the project into your Flutter workspace or open this folder in VS Code.
3. In `pubspec.yaml` run `flutter pub get`.
4. Add env variables in `.env` (create in project root):
```
SUPABASE_URL=https://<your_project>.supabase.co
SUPABASE_ANON_KEY=<your_anon_key>
```
5. Run on Android device: `flutter run`

## Notes
- This is a starter template with core logic and placeholders. You must:
  - Replace `<your_project>` values.
  - Implement exact gesture-matching thresholds as needed.
  - Test BLE device communication with your ESP32 data format.


# "ESP32 CODE": DA PUNDA 

/*
 *  GloveCom BLE Joystick Sender (Updated UUIDs)
 *  --------------------------------------------
 *  Sends joystick positions as formatted data to your Flutter GloveCom app:
 *  Format: "X1:512,Y1:300,X2:700,Y2:520,X3:400"
 *  
 *  ✅ Compatible with your Flutter GloveCom app’s BluetoothService
 *  ✅ Uses your new Service & Characteristic UUIDs
 *  ✅ Works with up to 5 analog joysticks (10 axes total)
 *  ✅ Sends data every 500ms
 */

#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>

// === BLE Configuration (UPDATED) ===
#define SERVICE_UUID        "847b6628-2150-4b77-b731-e557d04f8fec"
#define CHARACTERISTIC_UUID "8c245332-9eba-48ce-b4b8-4483dec8f06b"

// === Joystick Pins (modify these as per your wiring) ===
#define JOY1_X 34
#define JOY1_Y 35
#define JOY2_X 32
#define JOY2_Y 33
#define JOY3_X 36
#define JOY3_Y 39
#define JOY4_X 25
#define JOY4_Y 26
#define JOY5_X 27
#define JOY5_Y 14

BLEServer* pServer = nullptr;
BLECharacteristic* pCharacteristic = nullptr;
bool deviceConnected = false;

// -------------------- CALLBACKS --------------------
class ServerCallbacks : public BLEServerCallbacks {
  void onConnect(BLEServer* pServer) override {
    deviceConnected = true;
    Serial.println("✅ Flutter App Connected via Bluetooth");
  }

  void onDisconnect(BLEServer* pServer) override {
    deviceConnected = false;
    Serial.println("❌ Flutter App Disconnected");
    pServer->startAdvertising();
  }
};

// -------------------- SETUP --------------------
void setup() {
  Serial.begin(115200);
  Serial.println("🔹 GloveCom BLE Joystick Starting...");

  // === Setup BLE ===
  BLEDevice::init("GloveCom-ESP32");
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new ServerCallbacks());

  BLEService *pService = pServer->createService(SERVICE_UUID);

  pCharacteristic = pService->createCharacteristic(
    CHARACTERISTIC_UUID,
    BLECharacteristic::PROPERTY_NOTIFY | BLECharacteristic::PROPERTY_READ
  );

  pCharacteristic->addDescriptor(new BLE2902());
  pService->start();

  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  BLEDevice::startAdvertising();

  Serial.println("📡 BLE Advertising as 'GloveCom-ESP32'");
  Serial.print("🧩 Using Service UUID: "); Serial.println(SERVICE_UUID);
  Serial.print("🧩 Using Characteristic UUID: "); Serial.println(CHARACTERISTIC_UUID);
}

// -------------------- LOOP --------------------
void loop() {
  if (deviceConnected) {
    // Read analog joystick values (0-4095)
    int x1 = analogRead(JOY1_X);
    int y1 = analogRead(JOY1_Y);
    int x2 = analogRead(JOY2_X);
    int y2 = analogRead(JOY2_Y);
    int x3 = analogRead(JOY3_X);
    int y3 = analogRead(JOY3_Y);
    int x4 = analogRead(JOY4_X);
    int y4 = analogRead(JOY4_Y);
    int x5 = analogRead(JOY5_X);
    int y5 = analogRead(JOY5_Y);

    // Format into Flutter-readable string
    String data = "X1:" + String(x1) + ",Y1:" + String(y1) +
                  ",X2:" + String(x2) + ",Y2:" + String(y2) +
                  ",X3:" + String(x3) + ",Y3:" + String(y3) +
                  ",X4:" + String(x4) + ",Y4:" + String(y4) +
                  ",X5:" + String(x5) + ",Y5:" + String(y5);

    // Send over BLE
    pCharacteristic->setValue(data.c_str());
    pCharacteristic->notify();

    Serial.println("📤 Sent to App: " + data);

    delay(500);  // Send every 500 ms
  }

  delay(10);
}
#   G l o v e C o m - A p p 
 
 
