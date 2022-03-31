import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  String myText = 'Задайте параметры';
  num? x = 0;
  num? y = 0;

  void _changeText() {
    setState(() {
      myText =
          "S = ${(x!).toStringAsFixed(1)} * ${(y!).toStringAsFixed(1)} = ${(x! * y!).toStringAsFixed(1)} (мм2)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(children: [
                const Text(
                  'Ширина (мм):',
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) return 'Введите ширину';
                      if (num.tryParse(value) == null) {
                        return '"$value" не является правильным числом';
                      }
                      if (num.parse(value) < 0) {
                        return 'Введите положительное значение';
                      }
                      x = num.tryParse(value);
                      return null;
                    }),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow((RegExp("[.0-9]")))
                    ],
                  ),
                )
              ]),
              Row(children: [
                const Text(
                  'Высота (мм):',
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) return 'Введите ширину';
                      if (num.tryParse(value) == null) {
                        return '"$value" не является правильным числом';
                      }
                      if (num.parse(value) < 0) {
                        return 'Введите положительное значение';
                      }
                      y = num.tryParse(value);
                      return null;
                    }),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow((RegExp("[.0-9]")))
                    ],
                  ),
                )
              ]),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Форма успешно заполнена'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    _changeText();
                  }
                },
                child: const Text(
                  'Вычислить',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(myText, style: const TextStyle(fontSize: 30)),
            ],
          ),
        ));
  }
}

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Калькулятор площади')),
        body: const MyForm(),
      ),
    ));
