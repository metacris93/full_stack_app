import 'package:flutter/material.dart';
import 'package:full_stack_app/helpers/constant.dart';
import 'package:full_stack_app/views/widgets/dog/create_dog_view.dart';

class CreateDogViewApp extends StatelessWidget {
  const CreateDogViewApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          CreateDogFormConstants.create,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const CreateDogView(),
    );
  }
}
