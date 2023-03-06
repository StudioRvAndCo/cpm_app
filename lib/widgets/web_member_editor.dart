import 'package:flutter/material.dart';

class WebMemberEditor extends StatelessWidget {
  const WebMemberEditor(
      {super.key,
      this.isEdit = false,
      required this.onEdit,
      required this.onSave,
      required this.onCancel,
      this.picture,
      this.name,
      this.phone});

  final void Function() onEdit;
  final void Function() onSave;
  final void Function() onCancel;
  final bool isEdit;
  final Image? picture;
  final String? name;
  final String? phone;

  Widget _getPicture() {
    if (picture == null) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Icon(Icons.camera_alt_outlined),
      ));
    } else {
      return picture!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 150),
      child: SizedBox(
        width: 200,
        child: Column(
          children: <Widget>[
            Text(
              isEdit ? 'Edit member' : 'Add member',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 32,
            ),
            Card(
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                child: SizedBox(
                    width: 170,
                    height: 170,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: FittedBox(fit: BoxFit.cover, clipBehavior: Clip.hardEdge, child: _getPicture()),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onEdit,
                            overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
                                Theme.of(context).colorScheme.tertiary.withOpacity(0.08)),
                          ),
                        )
                      ],
                    ))),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              initialValue: name,
              decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder(), isDense: true),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              initialValue: phone,
              decoration: const InputDecoration(labelText: 'Phone number', border: OutlineInputBorder(), isDense: true),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  onPressed: onEdit,
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      side: BorderSide(color: Theme.of(context).colorScheme.error)),
                  child: Text(isEdit ? 'Delete' : 'Cancel'),
                ),
                const SizedBox(
                  width: 8,
                ),
                FilledButton(onPressed: onSave, child: const Text('Save')),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
