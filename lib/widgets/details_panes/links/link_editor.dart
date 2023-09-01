import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../models/project/link.dart';

class LinkEditor extends StatefulWidget {
  const LinkEditor({
    super.key,
    required this.link,
    required this.edit,
    required this.delete,
    required this.moveUp,
    required this.moveDown,
  });

  final Link link;
  final Function(Link) edit;
  final Function(int) delete;
  final Function()? moveUp;
  final Function()? moveDown;

  @override
  State<LinkEditor> createState() => _LinkEditorState();
}

class _LinkEditorState extends State<LinkEditor> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController labelController;
  late TextEditingController urlController;
  final urlFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController(text: widget.link.label);
    urlController = TextEditingController(text: widget.link.url);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Focus(
        onFocusChange: (bool hasFocus) {
          if (!hasFocus &&
              (labelController.text != widget.link.label || urlController.text != widget.link.url) &&
              _formKey.currentState!.validate()) {
            var label = labelController.text != widget.link.label ? labelController.text : widget.link.label;
            var url = urlController.text != widget.link.url ? urlController.text : widget.link.url;
            widget.edit(Link(
              id: widget.link.id,
              project: widget.link.project,
              index: widget.link.index,
              label: label,
              url: url,
            ));
          }
        },
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: labelController,
                decoration: InputDecoration.collapsed(hintText: 'attributes.label.upper'.tr()),
                maxLines: 1,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  urlFocusNode.requestFocus();
                },
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: urlController,
                decoration: InputDecoration.collapsed(hintText: 'attributes.url'.tr()),
                maxLines: 1,
                focusNode: urlFocusNode,
                validator: (value) {
                  if (value != null && value.isNotEmpty && !Uri.tryParse(value)!.isAbsolute) {
                    return 'Invalid URL';
                  }

                  return null;
                },
                onChanged: (value) {
                  _formKey.currentState!.validate();
                },
              ),
            ),
            PopupMenuButton(itemBuilder: (context) {
              return [
                if (urlController.text.isNotEmpty && _formKey.currentState!.validate())
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.launch),
                      title: Text('open.upper'.tr()),
                      onTap: () {
                        launchUrlString(urlController.text, mode: LaunchMode.externalApplication);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                if (widget.moveUp != null)
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.arrow_upward),
                      title: Text('moveUp.upper'.tr()),
                      onTap: () {
                        Navigator.of(context).pop();
                        widget.moveUp!();
                      },
                    ),
                  ),
                if (widget.moveDown != null)
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.arrow_downward),
                      title: Text('moveDown.upper'.tr()),
                      onTap: () {
                        Navigator.of(context).pop();
                        widget.moveDown!();
                      },
                    ),
                  ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.remove_circle),
                    title: Text('remove.upper'.tr()),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.delete(widget.link.id);
                    },
                  ),
                ),
              ];
            }),
          ],
        ),
      ),
    );
  }
}
