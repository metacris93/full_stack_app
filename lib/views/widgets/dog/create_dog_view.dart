import 'package:flutter/material.dart';
import 'package:full_stack_app/helpers/constant.dart';
import 'package:full_stack_app/helpers/general.dart';
import 'package:full_stack_app/models/dog.dart';
import 'package:full_stack_app/views/widgets/dog/dog_view_list.dart';
import 'package:full_stack_app/views/widgets/snackbar.dart';

class CreateDogView extends StatefulWidget {
  const CreateDogView({Key? key}) : super(key: key);

  @override
  State<CreateDogView> createState() => _CreateDogViewState();
}

class _CreateDogViewState extends State<CreateDogView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _newDog();
                      fetchDogsAndNavigate(context);
                    } else {
                      showError(SingInFormConstants.loginErrors);
                    }
                  },
                  child: const Text(GeneralConstants.save),
                ),
              ),
            )
          ])),
    );
  }

  Future<void> _newDog() async {
    await Dog.insert(Dog(name: _name.text, age: int.parse(_age.text)));
  }

  void fetchDogsAndNavigate(BuildContext context) async {
    final dogs = await Dog.fetchAll();
    Route<dynamic> route = MaterialPageRoute<dynamic>(
        builder: (context) => DogViewList(dogs: dogs));
    Navigator.pop(context);
    await Navigator.push(context, route);
  }
}
