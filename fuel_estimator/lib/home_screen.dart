import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController distanceController = TextEditingController();
  TextEditingController carFuelEffController = TextEditingController();

  double estimatedCost = 0.0;
  String? fuelType; //so that it can start as null
  double displayPrice = 0.0;
  String errorMessage = ''; // For validation

  Map<String, double> fuelPrices = {
    'BUDI95': 1.99,
    'RON95': 2.60,
    'RON97': 3.14,
    'DIESEL': 2.89,
  };

  void calculateFuelCost() {
    double distance = double.tryParse(distanceController.text) ?? 0.0;
    double efficiency = double.tryParse(carFuelEffController.text) ?? 0.0;

    if (distance <= 0 || efficiency <= 0 || fuelType == null) {
      errorMessage = 'Please fill all fields with valid numbers.';
      estimatedCost = 0.0;
      setState(() {});
      return;
    } else {
      double cost = (distance / efficiency) * displayPrice;
      estimatedCost = cost;
      errorMessage = '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel estimator", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 150, child: Text('Fuel Type')),
                Expanded(
                  child: DropdownButton<String>(
                    hint: const Text('Select fuel type'),
                    value: fuelType,
                    isExpanded: true, // move the drop down arrow the the back
                    items: fuelPrices.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      fuelType = newValue;
                      displayPrice = fuelPrices[fuelType] ?? 0.00;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    displayPrice == 0.0
                        ? ''
                        : 'RM ${displayPrice.toStringAsFixed(2)} /L',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 150, child: Text('Distance(km)')),
                Expanded(
                  child: TextField(
                    controller: distanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Distance',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 150, child: Text('Car Fuel Efficiency(km/L)')),
                Expanded(
                  child: TextField(
                    controller: carFuelEffController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Car Fuel Efficiency',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: calculateFuelCost,
                  child: Text('Calculate Fuel Cost'),
                ),
                ElevatedButton(
                  onPressed: () {
                    carFuelEffController.clear();
                    distanceController.clear();
                    fuelType = null;
                    displayPrice = 0.0;
                    estimatedCost = 0.0;
                    setState(() {});
                  },
                  child: Text('Reset'),
                ),
              ],
            ),

            SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: Text(
                'Estimated Cost: RM ${estimatedCost.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            // This Text will show validation errors
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
