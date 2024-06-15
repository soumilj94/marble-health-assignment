import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'colors.dart';
import 'dynamic_component.dart';
import 'main.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final components = useState([0]);
    final formService = GetIt.I<FormService>();
    final formKeys = useState(Map<int, GlobalKey<DynamicComponentState>>());

    void addComponent() {
      components.value = [...components.value, components.value.length];
      formKeys.value[components.value.length - 1] = GlobalKey<DynamicComponentState>();
    }

    void removeComponent(int index) {
      final updatedComponents = List<int>.from(components.value);
      updatedComponents.removeAt(index);
      components.value = updatedComponents;
      formKeys.value.remove(index);
    }

    List<Map<String, dynamic>> getFormDataFromComponents() {
      List<Map<String, dynamic>> formData = [];
      for (var i = 0; i < components.value.length; i++) {
        final key = formKeys.value[i];
        if (key != null && key.currentState != null) {
          formData.add(key.currentState!.getData());
        }
      }
      return formData;
    }

    void handleSubmit() {
      List<Map<String, dynamic>> formData = getFormDataFromComponents();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Form Data'),
          content: Text(formData.toString()),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 50.0),
          child: Text('Watermeter Quarterly Check'),
        ),
        backgroundColor: bgColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: TextButton(
              onPressed: handleSubmit,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
      backgroundColor: bgColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: components.value.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: DynamicComponent(
                    key: formKeys.value[index] ??= GlobalKey<DynamicComponentState>(),
                    index: index,
                    onRemove: () => removeComponent(index),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: addComponent,
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }
}
