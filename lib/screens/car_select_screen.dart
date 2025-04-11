import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/car_service.dart';

class CarSelectScreen extends StatefulWidget {
  @override
  _CarSelectScreenState createState() => _CarSelectScreenState();
}

class _CarSelectScreenState extends State<CarSelectScreen> {
  List<dynamic> _cars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCars();
  }

  Future<void> _fetchCars() async {
    try {
      List<dynamic> cars = await CarService.getAllCarsFromMockAPI();
      setState(() {
        _cars = cars;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _selectCar(dynamic car) {
    // Aquí puedes manejar lo que pasa cuando se selecciona un carro
    // Por ejemplo: navegar o almacenar datos
    Navigator.pop(context, car);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seleccionar Conductor')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cars.length,
              itemBuilder: (context, index) {
                final car = _cars[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(car['imagen']),
                  ),
                  title: Text(car['conductor']),
                  subtitle: Text('Placa: ${car['placa']}'),
                  onTap: () => _selectCar(car),
                );
              },
            ),
    );
  }
}
