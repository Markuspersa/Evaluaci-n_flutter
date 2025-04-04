import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/car_service.dart';

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
      body: ListView.builder(
        itemCount: _cars.length,
        itemBuilder: (context, index) {
          final car = _cars[index];
          return ListTile(
            leading: Icon(Icons.electric_car, size: 40, color: Colors.blue),
            title: Text("Placa: ${car['placa']}"),
            subtitle: Text("Conductor: ${car['conductor']}"),
          );
        },
      ),
    );
  }
}
