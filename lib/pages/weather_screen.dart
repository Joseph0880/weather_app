import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather App',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //main
              SizedBox(
                width: double.infinity,
                child: Card(
                    child: Column(
                  children: [
                    Text('300* F',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        )),
                    Icon(Icons.cloud, size: 64),
                    Text('Rain'),
                  ],
                )),
              ),
              SizedBox(height: 20),

              //forecast
              Placeholder(
                fallbackHeight: 150,
              ),
              SizedBox(height: 20),

              // Additional info
              Placeholder(
                fallbackHeight: 150,
              )
            ],
          ),
        ));
  }
}
