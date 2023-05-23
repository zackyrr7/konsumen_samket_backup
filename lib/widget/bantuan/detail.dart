import 'package:flutter/material.dart';

import '../../model/pertanyaan_model.dart';

class Detail extends StatelessWidget {
  final Pertanyaan pertanyaaan;

  const Detail({required this.pertanyaaan});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(pertanyaaan.judul),
      content: Column(
        children: [Text(pertanyaaan.jawaban)],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Mengerti"))
      ],
    );
  }
}
