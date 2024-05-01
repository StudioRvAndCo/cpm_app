import 'package:cpm/common/sheets/project/link/project_link_action.dart';
import 'package:cpm/models/project/link/link.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/extensions/validators/string_validators.dart';
import 'package:cpm/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectLinkEditor extends StatefulWidget {
  const ProjectLinkEditor({
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
  State<ProjectLinkEditor> createState() => _ProjectLinkEditorState();
}

class _ProjectLinkEditorState extends State<ProjectLinkEditor> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController labelController;
  late TextEditingController urlController;

  @override
  void initState() {
    super.initState();

    labelController = TextEditingController(text: widget.link.label);
    urlController = TextEditingController(text: widget.link.url);
  }

  void _onMenuSelected(ProjectLinkAction action) {
    switch (action) {
      case ProjectLinkAction.open:
        launchUrlString(urlController.text, mode: LaunchMode.externalApplication);
      case ProjectLinkAction.moveUp:
        widget.moveUp!();
      case ProjectLinkAction.moveDown:
        widget.moveDown!();
      case ProjectLinkAction.delete:
        widget.delete(widget.link.id);
    }
  }

  void _onSubmitted() {
    if (labelController.text == widget.link.label && urlController.text == widget.link.url ||
        !formKey.currentState!.validate()) {
      return;
    }

    widget.edit(
      Link(
        id: widget.link.id,
        project: widget.link.project,
        index: widget.link.index,
        label: labelController.text,
        url: urlController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Focus(
        onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted() : null,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: labelController,
                decoration: InputDecoration.collapsed(hintText: localizations.dialog_field_label),
                textInputAction: TextInputAction.next,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: urlController,
                decoration: InputDecoration.collapsed(hintText: localizations.dialog_field_url),
                validator: validateUrl,
              ),
            ),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  if (urlController.text.validUrl)
                    PopupMenuItem(
                      value: ProjectLinkAction.open,
                      child: ListTile(
                        leading: const Icon(Icons.launch),
                        title: Text(localizations.menu_open),
                      ),
                    ),
                  if (widget.moveUp != null)
                    PopupMenuItem(
                      value: ProjectLinkAction.moveUp,
                      child: ListTile(
                        leading: const Icon(Icons.arrow_upward),
                        title: Text(localizations.menu_move_up),
                      ),
                    ),
                  if (widget.moveDown != null)
                    PopupMenuItem(
                      value: ProjectLinkAction.moveDown,
                      child: ListTile(
                        leading: const Icon(Icons.arrow_downward),
                        title: Text(localizations.menu_move_down),
                      ),
                    ),
                  PopupMenuItem(
                    value: ProjectLinkAction.delete,
                    child: ListTile(
                      leading: const Icon(Icons.remove_circle),
                      title: Text(localizations.menu_delete),
                    ),
                  ),
                ];
              },
              onSelected: _onMenuSelected,
            ),
          ],
        ),
      ),
    );
  }
}
