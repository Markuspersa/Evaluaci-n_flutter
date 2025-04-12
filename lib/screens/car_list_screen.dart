import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/car_service.dart';
import 'package:flutter_application_1/screens/qr_scanner_screen.dart';



class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  
  List<dynamic> _cars = [];
  

  @override
  void initState() {
    super.initState();
    _fetchCars();
  }

  Future<void> _fetchCars() async {
    List<dynamic> cars = await CarService.getCars();
    setState(() {
      _cars = cars;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Mis Carros")),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _cars.length,
            itemBuilder: (context, index) {
              final car = _cars[index];
              return ListTile(
                leading: Image.network(
                  car["imagen"],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text("Placa: ${car['placa']}"),
                subtitle: Text("Conductor: ${car['conductor']}"),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => QRScannerScreen()),
                  );
                },
                icon: Icon(Icons.qr_code_scanner),
                label: Text('Escanear QR'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}