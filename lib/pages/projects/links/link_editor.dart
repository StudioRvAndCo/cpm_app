import 'package:cpm/models/project/link.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
            final label = labelController.text != widget.link.label ? labelController.text : widget.link.label;
            final url = urlController.text != widget.link.url ? urlController.text : widget.link.url;
            widget.edit(
              Link(
                id: widget.link.id,
                project: widget.link.project,
                index: widget.link.index,
                label: label,
                url: url,
              ),
            );
          }
        },
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: labelController,
                decoration: InputDecoration.collapsed(hintText: localizations.dialog_field_label),
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
                decoration: InputDecoration.collapsed(hintText: localizations.dialog_field_url),
                focusNode: urlFocusNode,
                validator: (value) {
                  if (value != null && value.isNotEmpty && !Uri.tryParse(value)!.isAbsolute) {
                    return localizations.error_invalid_url;
                  }

                  return null;
                },
                onChanged: (value) {
                  _formKey.currentState!.validate();
                },
              ),
            ),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  if (urlController.text.isNotEmpty && _formKey.currentState!.validate())
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.launch),
                        title: Text(localizations.menu_open),
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
                        title: Text(localizations.menu_move_up),
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
                        title: Text(localizations.menu_move_down),
                        onTap: () {
                          Navigator.of(context).pop();
                          widget.moveDown!();
                        },
                      ),
                    ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.remove_circle),
                      title: Text(localizations.menu_delete),
                      onTap: () {
                        Navigator.of(context).pop();
                        widget.delete(widget.link.id);
                      },
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
