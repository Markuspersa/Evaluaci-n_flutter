import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/car_list_screen.dart';
import 'package:flutter_application_1/services/car_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarConfirmationScreen extends StatefulWidget {
  final String codigoQR;

  CarConfirmationScreen({required this.codigoQR});

  @override
  _CarConfirmationScreenState createState() => _CarConfirmationScreenState();
}

class _CarConfirmationScreenState extends State<CarConfirmationScreen> {
  Map<String, dynamic>? carData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCar();
  }

  Future<void> fetchCar() async {
    final response = await http.get(Uri.parse(
      'https://67f7d1812466325443eadd17.mockapi.io/carros/${widget.codigoQR}',
    ));

    if (response.statusCode == 200) {
      setState(() {
        carData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        carData = null;
        isLoading = false;
      });
    }
  }

  Future<void> save() async {
    await CarService.saveCar(carData!);
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => CarListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carro Detectado')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : carData != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Imagen del conductor
                          if (carData!['imagen'] != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                carData!['imagen'],
                                height: 120,
                              ),
                            ),
                          const SizedBox(height: 16),
                          Text("Conductor: ${carData!['conductor']}",
                              style: TextStyle(fontSize: 18)),
                          Text("Placa: ${carData!['placa']}",
                              style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: save,
                            child: const Text('Agregar'),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    "No se encontró información del carro.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
    );
  }
}



