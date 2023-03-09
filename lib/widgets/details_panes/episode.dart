import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/episode.dart';

class DetailsPaneEpisode extends StatefulWidget {
  const DetailsPaneEpisode({super.key, required this.episode});

  final Episode episode;

  @override
  State<DetailsPaneEpisode> createState() => _DetailsPaneEpisodeState();
}

class _DetailsPaneEpisodeState extends State<DetailsPaneEpisode>
    with AutomaticKeepAliveClientMixin<DetailsPaneEpisode> {
  late String title;
  late String description;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    title = widget.episode.title;
    description = widget.episode.description;

    titleController.text = title;
    descriptionController.text = description;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration.collapsed(hintText: 'attributes.title.upper'.tr()),
              controller: titleController,
              onChanged: setTitle,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration.collapsed(hintText: 'attributes.description.upper'.tr()),
              controller: descriptionController,
              onChanged: setDescription,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;

  void setTitle(String value) {
    setState(() {
      title = value;
    });
  }

  void setDescription(String value) {
    setState(() {
      description = value;
    });
  }
}
