import 'package:flutter/material.dart';
import 'package:full_stack_app/helpers/constant.dart';
import 'package:full_stack_app/models/dog.dart';

class EditDogView extends StatefulWidget {
  final Dog dog;
  const EditDogView({Key? key, required this.dog}) : super(key: key);

  @override
  State<EditDogView> createState() => _EditDogViewState();
}

class _EditDogViewState extends State<EditDogView> {
  late Dog dog;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dog = widget.dog;
    _name.text = dog.name;
    _age.text = dog.age.toString();
  }

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(dog.name, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue[900],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                child: TextFormField(
                  controller: _name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return CreateDogFormConstants.nameRequired;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: CreateDogFormConstants.name,
                      hintText: CreateDogFormConstants.name),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _age,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return CreateDogFormConstants.ageRequired;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: CreateDogFormConstants.age,
                        hintText: CreateDogFormConstants.age),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle:
                          const TextStyle(fontSize: 21, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await Dog.update(Dog(
                            id: dog.id,
                            name: _name.text,
                            age: int.parse(_age.text)));
                        setState(() {
                          dog.name = _name.text;
                          dog.age = int.parse(_age.text);
                        });
                        if (context.mounted) {
                          Navigator.of(context).pop(context);
                        }
                      }
                    },
                    child: const Text(GeneralConstants.update),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
