import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:wifi_iot/wifi_iot.dart';

class WiFiControl extends StatefulWidget {
  @override
  _WiFiControlState createState() => _WiFiControlState();
}

class _WiFiControlState extends State<WiFiControl> {
  List<WifiNetwork> _wifiNetworks = [];
  bool _loading = true;
  String? _connectedSSID;

  @override
  void initState() {
    super.initState();
    _loadWifiList();
  }

  Future<void> _loadWifiList() async {
    try {
      var wifiNetworks = await WiFiForIoTPlugin.loadWifiList();
      var connectedSSID = await WiFiForIoTPlugin.getSSID();
      setState(() {
        _wifiNetworks = wifiNetworks;
        _connectedSSID = connectedSSID;
        _loading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.15),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
          Center(
            child: Material(
              color: Colors.transparent,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF101010).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              iconSize: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Change WiFi Network",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        _loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : _wifiNetworks.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: _wifiNetworks.length,
                                      itemBuilder: (context, index) {
                                        return WiFiNetworkTile(
                                          ssid: _wifiNetworks[index].ssid ??
                                              "Unknown",
                                          isConnected:
                                              _wifiNetworks[index].ssid ==
                                                  _connectedSSID,
                                          signalStrength:
                                              _wifiNetworks[index].level ?? 0,
                                          onConnect: () {
                                            _connectToNetwork(
                                                _wifiNetworks[index].ssid ??
                                                    "");
                                          },
                                          onDisconnect: () {
                                            _disconnectFromNetwork();
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      "No WiFi networks found",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _connectToNetwork(String ssid) async {
    await WiFiForIoTPlugin.connect(ssid,
        password: "", // Password should be provided if needed
        joinOnce: true,
        security: NetworkSecurity.WPA);
    // Optionally, refresh the list after connection
    _loadWifiList();
  }

  Future<void> _disconnectFromNetwork() async {
    await WiFiForIoTPlugin.disconnect();
    // Optionally, refresh the list after disconnection
    _loadWifiList();
  }
}

class WiFiNetworkTile extends StatelessWidget {
  final String ssid;
  final bool isConnected;
  final int signalStrength; // 0-4 for signal strength
  final VoidCallback onConnect;
  final VoidCallback onDisconnect;

  WiFiNetworkTile({
    required this.ssid,
    required this.isConnected,
    required this.signalStrength,
    required this.onConnect,
    required this.onDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.wifi,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ssid,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isConnected ? 'Connected' : 'Saved',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          isConnected
              ? ElevatedButton(
                  onPressed: onDisconnect,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: Text(
                    'Disconnect',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ElevatedButton(
                  onPressed: onConnect,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: Text(
                    'Connect',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ],
      ),
    );
  }
}
