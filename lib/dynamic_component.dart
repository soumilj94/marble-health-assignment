import 'package:flutter/material.dart';

class DynamicComponent extends StatefulWidget {
  final int index;
  final Function onRemove;

  const DynamicComponent({Key? key, required this.index, required this.onRemove}) : super(key: key);

  @override
  DynamicComponentState createState() => DynamicComponentState();
}

class DynamicComponentState extends State<DynamicComponent> {
  final TextEditingController labelController = TextEditingController();
  final TextEditingController infoTextController = TextEditingController();
  bool requiredCheckbox = false;
  bool readonlyCheckbox = false;
  bool hiddenFieldCheckbox = false;

  @override
  void dispose() {
    labelController.dispose();
    infoTextController.dispose();
    super.dispose();
  }

  Map<String, dynamic> getData() {
    return {
      'label': labelController.text,
      'infoText': infoTextController.text,
      'required': requiredCheckbox,
      'readonly': readonlyCheckbox,
      'hiddenField': hiddenFieldCheckbox,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.check_box_outlined, color: Colors.green),
                    SizedBox(width: 10),
                    Text("Checkbox"),
                  ],
                ),
                Row(
                  children: [
                    if (widget.index > 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: OutlinedButton(
                          onPressed: () => widget.onRemove(),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            side: const BorderSide(color: Colors.grey),
                          ),
                          child: const Text("Remove", style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          side: const BorderSide(color: Colors.blue),
                        ),
                        child: const Text("Done", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Text("Label*"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: labelController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Add a label here",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a label';
                  }
                  return null;
                },
              ),
            ),
            const Text("Info-text"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: infoTextController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Add additional information",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Row(
              children: [
                Checkbox(
                  value: requiredCheckbox,
                  onChanged: (value) => setState(() => requiredCheckbox = value!),
                ),
                const Text('Required'),
                Checkbox(
                  value: readonlyCheckbox,
                  onChanged: (value) => setState(() => readonlyCheckbox = value!),
                ),
                const Text('Readonly'),
                Checkbox(
                  value: hiddenFieldCheckbox,
                  onChanged: (value) => setState(() => hiddenFieldCheckbox = value!),
                ),
                const Text('Hidden Field'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
