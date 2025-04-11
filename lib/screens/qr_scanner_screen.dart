import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'confirmation_screen.dart'; 

class QRScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear Código QR')),
      body: MobileScanner(
        onDetect: (barcodeCapture) {
          final List<Barcode> barcodes = barcodeCapture.barcodes;
          final String? code = barcodes.first.rawValue;

          if (code != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => CarConfirmationScreen(codigoQR: code),
              ),
            );
          }
        },
      ),
    );
  }
}
