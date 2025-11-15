![WhatsApp Image 2025-11-15 at 14 49 02_ba0ea4fe](https://github.com/user-attachments/assets/d29094b8-1c87-4f33-92c3-d81986d88846)

🧤 GloveCom – Sign Language to Speech Translator

> 🚀 Bridging the gap between sign language and speech through AI, IoT, and compassion.

GloveCom is a smart wearable + mobile system that detects hand gestures using flex sensors on an ESP32, sends them via Bluetooth (BLE) to a Flutter app, and translates them into real-time text and speech output.




---

🌟 Key Features

Feature	Description

🤖 Gesture Detection	Flex sensors detect finger movements and map them to predefined words/sentences.
🔊 Speech Output	Converts recognized gestures to speech using Text-to-Speech (TTS).
💬 Speech-to-Text Assistant	Converts user speech into text and forms intelligent sentences.
📱 Bluetooth Communication	Real-time BLE link between glove (ESP32) and Flutter app.
🖐 Gesture Training Mode	Users can train new gestures and link them to custom words.
🧠 AI-Inspired UI	Futuristic dark-gold theme with smooth animations.
📜 Speech History	Stores translated gestures and spoken words for review.



---

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



---

🔌 System Architecture

Flex Sensors → ESP32 → Bluetooth BLE → Flutter App → Text + Speech Output


---

📲 App Screenshots

Home Screen	Gesture Training	Voice Assistant

		



---

🧠 ESP32 Firmware (C++)

#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

#define SERVICE_UUID        "847b6628-2150-4b77-b731-e557d04f8fec"
#define CHARACTERISTIC_UUID "8c245332-9eba-48ce-b4b8-4483dec8f06b"

#define FLEX1_PIN 34
#define FLEX2_PIN 35
#define FLEX3_PIN 32
#define FLEX4_PIN 33
#define FLEX5_PIN 25

BLEServer* pServer = NULL;
BLECharacteristic* pCharacteristic = NULL;
bool deviceConnected = false;
int flex1, flex2, flex3, flex4, flex5;

class MyServerCallbacks : public BLEServerCallbacks {
  void onConnect(BLEServer* pServer) { deviceConnected = true; Serial.println("✅ Connected"); }
  void onDisconnect(BLEServer* pServer) { deviceConnected = false; Serial.println("❌ Disconnected"); pServer->getAdvertising()->start(); }
};

void setup() {
  Serial.begin(115200);
  BLEDevice::init("GloveCom_Glove");
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());
  BLEService* pService = pServer->createService(SERVICE_UUID);
  pCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID, BLECharacteristic::PROPERTY_NOTIFY | BLECharacteristic::PROPERTY_READ);
  pCharacteristic->addDescriptor(new BLE2902());
  pService->start();
  pServer->getAdvertising()->start();

  pinMode(FLEX1_PIN, INPUT); pinMode(FLEX2_PIN, INPUT); pinMode(FLEX3_PIN, INPUT); pinMode(FLEX4_PIN, INPUT); pinMode(FLEX5_PIN, INPUT);
}

void loop() {
  if (deviceConnected) {
    flex1 = analogRead(FLEX1_PIN);
    flex2 = analogRead(FLEX2_PIN);
    flex3 = analogRead(FLEX3_PIN);
    flex4 = analogRead(FLEX4_PIN);
    flex5 = analogRead(FLEX5_PIN);

    String message = detectGesture(flex1, flex2, flex3, flex4, flex5);
    if (message.length() > 0) {
      pCharacteristic->setValue(message.c_str());
      pCharacteristic->notify();
      Serial.println("📤 Sent: " + message);
    }
    delay(300);
  }
}

String detectGesture(int f1, int f2, int f3, int f4, int f5) {
  if (f1 > 2800 && f2 > 2800 && f3 > 2800 && f4 > 2800 && f5 > 2800) return "HELLO, HOW ARE YOU?";
  else if (f1 < 1000 && f2 < 1000 && f3 < 1000 && f4 < 1000 && f5 < 1000) return "THANK YOU VERY MUCH";
  else if (f1 > 2000 && f2 < 1200 && f3 < 1200 && f4 < 1200 && f5 < 1200) return "I AM HAPPY TODAY";
  else if (f1 < 1200 && f2 > 2000 && f3 > 2000 && f4 < 1200 && f5 < 1200) return "PLEASE HELP ME";
  else if (f1 > 2000 && f2 > 2000 && f3 < 1000 && f4 < 1000 && f5 < 1000) return "GOOD MORNING";
  else return "";
}


---

📱 Flutter Setup

1. Clone this repository

git clone https://github.com/Dhanushkumarsekar/GloveCom.git
cd GloveCom


2. Install dependencies

flutter pub get


3. Run on device

flutter run


4. To build release APK

flutter build apk --release




---

💡 Future Upgrades

🧠 AI-based dynamic gesture recognition using CNN

🌎 Multi-language translation (English, Hindi, Tamil, Telugu)

☁ Cloud sync of gesture history

🔊 Emotion-aware speech tone generation



---

🏆 Achievements

🥈 State 2nd – Atal Tinkering Lab

🥈 National 2nd – Amazon Best Project & Reel

🥇 1st Place – College Project Expo (CIET)

🏅 National Top 10 – Impairathon by KIIC

💡 Recognized by ThinkStartup for Business Innovation



---

👨‍💻 Developer

Dhanushkumar Sekar
🎓 B.E. Computer Science & Engineering @ CIET
💡 Startup Founder | Innovator | Tech for Society
🌐 Portfolio
🐙 GitHub
💼 LinkedIn


---

🧩 License

This project is licensed under the MIT License – free to use, modify, and share.
Let’s make communication accessible for everyone ❤


---

Would you like me to:

1. Generate a README with badges and shields (e.g. “Made with Flutter”, “MIT License”, “Open Source”)


2. Or generate a visual GitHub cover/banner (GloveCom – Sign Language to Speech Translator) for your repo header?
