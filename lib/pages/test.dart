import 'package:flutter/material.dart';
import '../widgets/details_pane.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cinema Project Manager'),
          centerTitle: true,
        ),
        body: Center(
          child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return DefaultTabController(
                          length: 3,
                          child: Column(
                            children: const <Widget>[
                              TabBar(tabs: <Tab>[
                                Tab(
                                  text: 'Details',
                                ),
                                Tab(
                                  text: 'Members',
                                ),
                                Tab(
                                  text: 'Locations',
                                ),
                              ]),
                              Expanded(
                                  child: TabBarView(children: <Widget>[
                                  DetailsPane(),
                                  Text('Members'),
                                  Text('Locations')
                                ]),
                              )
                            ],
                          ));
                    });
              },
              child: const Text('Bottom sheet')),
        ));
  }
}
