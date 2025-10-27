// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../services/bluetooth_service.dart';

// class BLEConnectionScreen extends StatelessWidget {
//   const BLEConnectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bt = Provider.of<BluetoothService>(context);
//     return Scaffold(
//       appBar: AppBar(title: const Text('BLE Connection')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (bt.connectedDevice != null)
//               ListTile(
//                 leading: const Icon(Icons.bluetooth_connected),
//                 title: Text(bt.connectedDevice!.name),
//                 subtitle: const Text('Connected'),
//               )
//             else
//               const ListTile(
//                 leading: Icon(Icons.bluetooth_disabled),
//                 title: Text('No device connected'),
//               ),
//             const SizedBox(height: 12),
//             ElevatedButton(
//               onPressed: () => bt.startScan(),
//               child: const Text('Scan for devices'),
//             ),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () => bt.stopScan(),
//               child: const Text('Stop scan'),
//             ),
//             const SizedBox(height: 16),
//             const Text('Open device discovery in logs.'),
//             const SizedBox(height: 8),
//             const Text('Implement UI listing and connect to chosen device.'),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../services/bluetooth_service.dart';

// class BLEConnectionScreen extends StatelessWidget {
//   const BLEConnectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bt = Provider.of<BluetoothService>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text('BLE Connection')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // ✅ Connected device info
//             if (bt.connectedDevice != null)
//               ListTile(
//                 leading: const Icon(Icons.bluetooth_connected, color: Colors.blue),
//                 title: Text(bt.connectedDevice!.platformName), // ✅ updated
//                 subtitle: const Text('Connected to GloveCom-ESP32'),
//               )
//             else
//               const ListTile(
//                 leading: Icon(Icons.bluetooth_disabled, color: Colors.grey),
//                 title: Text('No device connected'),
//               ),

//             const SizedBox(height: 16),

//             // ✅ Scan buttons
//             ElevatedButton.icon(
//               onPressed: () async {
//                 await bt.startScan();
//                 if (!context.mounted) return; // ✅ safe async context
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('🔍 Scanning for devices...')),
//                 );
//               },
//               icon: const Icon(Icons.search),
//               label: const Text('Start Scan'),
//             ),

//             const SizedBox(height: 10),

//             ElevatedButton.icon(
//               onPressed: () async {
//                 await bt.stopScan();
//                 if (!context.mounted) return;
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('🛑 Scan stopped')),
//                 );
//               },
//               icon: const Icon(Icons.stop),
//               label: const Text('Stop Scan'),
//             ),

//             const SizedBox(height: 20),

//             // ✅ Scanning indicator
//             if (bt.isScanning)
//               const Text(
//                 '📡 Scanning in progress...',
//                 style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w600),
//               )
//             else
//               const Text(
//                 'Press “Start Scan” to find GloveCom-ESP32',
//                 style: TextStyle(color: Colors.black54),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp; // ✅ prefixed for clarity
// import 'package:provider/provider.dart';
// import '../services/bluetooth_service.dart' as app; // ✅ your own Bluetooth service

// class BLEConnectionScreen extends StatefulWidget {
//   const BLEConnectionScreen({super.key});

//   @override
//   State<BLEConnectionScreen> createState() => _BLEConnectionScreenState();
// }

// class _BLEConnectionScreenState extends State<BLEConnectionScreen> {
//   @override
//   void initState() {
//     super.initState();
//     final bluetoothService = Provider.of<app.BluetoothService>(context, listen: false);
//     bluetoothService.startScan();
//   }

//   @override
//   void dispose() {
//     final bluetoothService = Provider.of<app.BluetoothService>(context, listen: false);
//     bluetoothService.stopScan();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bluetoothService = Provider.of<app.BluetoothService>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("BLE Connection"),
//         backgroundColor: const Color(0xFF0A0A0A),
//       ),
//       backgroundColor: const Color(0xFF0A0A0A),
//       body: Column(
//         children: [
//           const SizedBox(height: 20),

//           Text(
//             bluetoothService.isConnected
//                 ? "✅ Connected to ${bluetoothService.connectedDevice?.platformName ?? 'Unknown'}"
//                 : bluetoothService.isScanning
//                     ? "🔍 Scanning for BLE devices..."
//                     : "No device connected.",
//             style: const TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//           const SizedBox(height: 10),

//           ElevatedButton.icon(
//             onPressed: bluetoothService.isScanning
//                 ? null
//                 : () async {
//                     await bluetoothService.startScan();
//                   },
//             icon: const Icon(Icons.search),
//             label: const Text("Start Scan"),
//           ),

//           const SizedBox(height: 10),
//           ElevatedButton.icon(
//             onPressed: bluetoothService.isScanning
//                 ? () async {
//                     await bluetoothService.stopScan();
//                   }
//                 : null,
//             icon: const Icon(Icons.stop),
//             label: const Text("Stop Scan"),
//           ),

//           const SizedBox(height: 20),

//           Expanded(
//             child: StreamBuilder<List<fbp.ScanResult>>(
//               stream: bluetoothService.scanResults,
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(color: Colors.amber),
//                   );
//                 }

//                 final results = snapshot.data!;
//                 if (results.isEmpty) {
//                   return const Center(
//                     child: Text(
//                       "No devices found.",
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: results.length,
//                   itemBuilder: (context, index) {
//                     final result = results[index];
//                     final name = result.device.platformName.isNotEmpty
//                         ? result.device.platformName
//                         : "Unknown Device";
//                     final id = result.device.remoteId.str;

//                     return Card(
//                       color: const Color(0xFF1A1A1A),
//                       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       child: ListTile(
//                         leading: const Icon(Icons.bluetooth, color: Colors.amberAccent),
//                         title: Text(
//                           name,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: Text(
//                           id,
//                           style: const TextStyle(color: Colors.white54),
//                         ),
//                         trailing: ElevatedButton(
//                           onPressed: () async {
//                             await bluetoothService.connectToDevice(result.device);
//                             if (!context.mounted) return; // ✅ proper mounted check
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text("✅ Connected to $name successfully!"),
//                                 backgroundColor: Colors.green,
//                                 behavior: SnackBarBehavior.floating,
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.amberAccent,
//                             foregroundColor: Colors.black,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: const Text("Connect"),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//      ),
//     );
// }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import '../services/bluetooth_service.dart';

class BLEConnectionScreen extends StatefulWidget {
  const BLEConnectionScreen({super.key});

  @override
  State<BLEConnectionScreen> createState() => _BLEConnectionScreenState();
}

class _BLEConnectionScreenState extends State<BLEConnectionScreen> {
  bool isScanning = false;

  @override
  Widget build(BuildContext context) {
    final ble = Provider.of<BluetoothService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("BLE Connection"),
      ),
      backgroundColor: const Color(0xFF0D0D0D),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // 🔹 Connection status
          Text(
            ble.isConnected
                ? "✅ Connected to ${ble.connectedDevice?.platformName ?? 'Device'}"
                : "🔴 No device connected",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 Scanning buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: isScanning
                    ? null
                    : () async {
                        setState(() => isScanning = true);
                        await ble.startScan();
                        await Future.delayed(const Duration(seconds: 5));
                        await ble.stopScan();
                        setState(() => isScanning = false);
                      },
                icon: const Icon(Icons.search),
                label: const Text("Start Scan"),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: isScanning
                    ? () async {
                        await ble.stopScan();
                        setState(() => isScanning = false);
                      }
                    : null,
                icon: const Icon(Icons.stop),
                label: const Text("Stop Scan"),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 🔹 Scanning status
          Text(
            isScanning
                ? "📡 Scanning for devices..."
                : ble.isConnected
                    ? "✅ Device connected!"
                    : "Tap Start Scan to find devices.",
            style: const TextStyle(color: Colors.amberAccent),
          ),

          const SizedBox(height: 20),

          // 🔹 Live detected gesture (from glove)
          if (ble.receivedText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "🖐 Detected Gesture: ${ble.receivedText}",
                style: const TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          const Divider(color: Colors.white24),

          // 🔹 List of available BLE devices
          Expanded(
            child: StreamBuilder<List<fbp.ScanResult>>(
              stream: ble.scanResults,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  );
                }

                final results = snapshot.data!;
                if (results.isEmpty) {
                  return const Center(
                    child: Text(
                      "No BLE devices found.",
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final r = results[index];
                    final deviceName =
                        r.device.platformName.isNotEmpty ? r.device.platformName : "Unknown Device";

                    return Card(
                      color: const Color(0xFF1E1E1E),
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.bluetooth, color: Colors.amber),
                        title: Text(
                          deviceName,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          r.device.remoteId.str,
                          style: const TextStyle(color: Colors.white54),
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amberAccent,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            await ble.connectToDevice(r.device);
                          },
                          child: const Text("Connect"),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}