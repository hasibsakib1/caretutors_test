// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/controller.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiResponse = ref.watch(controllerProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            apiResponse.when(
              data: (responseModel) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Image.network(
                      responseModel.hdurl,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text('Error: $error'),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Enter Date",
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        String formattedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                        dateController.text = formattedDate;
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (dateController.text.isNotEmpty) {
                      ref.read(controllerProvider.notifier).fetchData(dateController.text);
                    }
                  },
                  child: const Text('Fetch Data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
