import 'package:flutter/material.dart';

class CityPickerScreen extends StatelessWidget {
  static const String routeName = '/city-picker';
  final List<String> cities = const [
    'Beograd',
    'Novi Sad',
    'Niš',
    'Kragujevac',
    'Subotica',
    'Zrenjanin',
    'Pančevo',
    'Čačak',
    'Novi Pazar',
    'Sombor',
  ];

  const CityPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Izaberite grad'),
        backgroundColor: Colors.grey[350],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: cities.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index]),
            onTap: () {
              Navigator.of(context).pop(cities[index]);
            },
          );
        },
      ),
    );
  }
}
