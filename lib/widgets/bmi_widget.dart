import 'package:bmicalculator/models/bmi_model/bmi_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildContent(List<Bmimodel> _bmi) {
  if (_bmi.isEmpty) {
    return const Center(
      child: Text(
        'No Bmi Test yet!',
        style: TextStyle(fontSize: 24),
      ),
    );
  } else {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _bmi.length,
            itemBuilder: (BuildContext context, int index) {
              final transaction = _bmi[index];

              return buildBmi(context, transaction);
            },
          ),
        ),
      ],
    );
  }
}

Widget buildBmi(
  BuildContext context,
  Bmimodel _bmi,
) {
  final date = DateFormat.yMMMd().format(_bmi.createdDate);

  return Card(
    color: Colors.white,
    child: ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      title: Text(
        _bmi.bmi,
        maxLines: 2,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(date),
    ),
  );
}
