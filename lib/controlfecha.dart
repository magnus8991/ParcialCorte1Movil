import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// ignore: must_be_immutable
class BasicDateField extends StatelessWidget {
  DateTime fechaActual;
  BasicDateField(this.fechaActual);
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      decoration: InputDecoration(labelText: 'Fecha de nacimiento'),
      format: format,
      onChanged: (dateTime) {
        fechaActual = dateTime;
      },
      initialValue: fechaActual,
      onShowPicker: (context, fechaActual) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900, 1, 1),
            initialDate: fechaActual,
            lastDate: DateTime.now());
      },
    );
  }

  DateTime getFechaActual() {
    return this.fechaActual;
  }
}
