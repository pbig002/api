//Homepage
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'state_management.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final statemanager = HomePageManager();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Wrap(
            spacing: 50,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: statemanager.makeGetRequest,
                child: Text('GET'),
              ),
              ElevatedButton(
                  onPressed: statemanager.makePostRequest,
                   child: Text('POST'))
            ],
          ),
        ),
        SizedBox(height: 20),
        ValueListenableBuilder(
          valueListenable: statemanager.resultNotifier,
          builder: (context, RequestState, child) {
            if (RequestState is RequestLoadInProgress) {
              return CircularProgressIndicator();
            } else if (RequestState is RequestLoadSuccess) {
              return Expanded(
                  child: SingleChildScrollView(
                child: Text(RequestState.body),
              ));
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
