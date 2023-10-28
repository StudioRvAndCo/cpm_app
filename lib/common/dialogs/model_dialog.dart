import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/sizes.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:flutter/material.dart';

class ModelDialog<T> extends StatelessWidget {
  ModelDialog({
    super.key,
    required this.cancel,
    required this.submit,
    required this.title,
    required this.action,
    required this.fields,
  });

  final Function() cancel;
  final Function() submit;

  final String title;
  final String action;
  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    return PlatformManager().isMobile
        ? Dialog.fullscreen(
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: cancel,
                  ),
                  title: Text(title),
                  actions: [
                    TextButton(
                      onPressed: submit,
                      child: Text(action),
                    ),
                    Padding(padding: Paddings.padding4.horizontal),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: Paddings.padding16.all,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...fields,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Dialog(
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: Sizes.custom.dialog,
              child: Padding(
                padding: Paddings.padding16.all,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Padding(padding: Paddings.padding16.vertical),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: fields,
                        ),
                      ),
                    ),
                    Padding(padding: Paddings.padding8.vertical),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: cancel,
                          child: Text(localizations.button_cancel),
                        ),
                        TextButton(
                          onPressed: submit,
                          child: Text(action),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
