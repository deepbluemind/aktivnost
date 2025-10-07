
import 'package:flutter/material.dart';
import 'city_picker_screen.dart';
import 'api_call_helper.dart';


class AktivnostDetaljiScreen extends StatefulWidget {
  static const String routeName = '/aktivnost-detalji';
  const AktivnostDetaljiScreen({super.key});

  @override
  State<AktivnostDetaljiScreen> createState() => _AktivnostDetaljiScreenState();
}

class _AktivnostDetaljiScreenState extends State<AktivnostDetaljiScreen> {
  
  bool _isLoading = false;

  final List<String> aktivnosti = [
    'Kupovina',
    'Šetnja',
    'Trening',
    'Učenje',
    'Odmor',
  ];
  String? selectedAktivnost;

  final List<String> trajanja = [
    '15 minuta',
    '30 minuta',
    '45 minuta',
    '60 minuta',
  ];
  String? selectedTrajanje;

  TextEditingController lokacijaController = TextEditingController();
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedAktivnost = aktivnosti[0];
    selectedTrajanje = trajanja[0];
    selectedDateTime = DateTime.now();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime!,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime!),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.grey[350],
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Aktivnost',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const Text('Aktivnost'),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedAktivnost,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedAktivnost = newValue;
                              });
                            },
                            items: aktivnosti.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Lokacija'),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: lokacijaController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.location_on_outlined),
                            onPressed: () async {
                              final city = await Navigator.of(context).push<String>(
                                MaterialPageRoute(
                                  builder: (context) => CityPickerScreen(),
                                ),
                              );
                              if (city != null) {
                                setState(() {
                                  lokacijaController.text = city;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Datum i vreme'),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _selectDateTime(context),
                      child: AbsorbPointer(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: TextField(
                            controller: TextEditingController(
                              text: selectedDateTime != null
                                  ? '${selectedDateTime!.day.toString().padLeft(2, '0')}.${selectedDateTime!.month.toString().padLeft(2, '0')}.${selectedDateTime!.year} ${selectedDateTime!.hour.toString().padLeft(2, '0')}:${selectedDateTime!.minute.toString().padLeft(2, '0')}'
                                  : '',
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Trajanje'),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedTrajanje,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedTrajanje = newValue;
                              });
                            },
                            items: trajanja.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[100],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Colors.black54),
                  ),
                  elevation: 0,
                ),
                onPressed: _isLoading
                    ? null
                    : () {
                        ApiCallHelper.simulateApiCall(
                          context: context,
                          apiCallStep: 0,
                          setLoading: (isLoading) {
                            setState(() {
                              _isLoading = isLoading;
                            });
                          },
                          incrementStep: () {},
                        );
                      },
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Sačuvaj'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
