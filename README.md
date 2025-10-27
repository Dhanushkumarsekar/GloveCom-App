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
