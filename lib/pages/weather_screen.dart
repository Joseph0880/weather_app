import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/pages/HourlyForecasteItemCard.dart';
import 'package:weather_app/pages/additional_info_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/pages/keys.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherApiKey'),
      );

      final data = jsonDecode(result.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

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
        body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final data = snapshot.data!;

            final currentWeatherData = data['list'] [0];

            final currentTemp = currentWeatherData['main'] ['temp'];
            final currentSky = currentWeatherData ['weather'] [0] ['main'];
            final currentPressure = currentWeatherData ['main'] ['pressure'];
            final currentWindspeed = currentWeatherData ['wind'] ['speed'];
            final currentHumidity = currentWeatherData ['main'] ['humidity'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //main
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child:  Padding(
                          padding:const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text('$currentTemp K',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                currentSky == 'Clouds' || currentSky =='Rain'
                                  ?Icons.cloud: Icons.sunny,
                                size: 64),
                            const  SizedBox(height: 16),
                              Text(
                                '$currentSky',
                                style:const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Weather Forecast',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HourlyCard(
                            time: '00.00',
                            icon: Icons.cloud,
                            temperature: '301.22'),
                        HourlyCard(
                            time: '03.00',
                            icon: Icons.cloud,
                            temperature: '275.10'),
                        HourlyCard(
                            time: '09.45',
                            icon: Icons.sunny,
                            temperature: '301.08'),
                        HourlyCard(
                            time: '08.10',
                            icon: Icons.cloud,
                            temperature: '300.58'),
                        HourlyCard(
                            time: '12.30',
                            icon: Icons.cloud,
                            temperature: '308.64'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: currentHumidity.toString(),
                      ),
                      AdditionalInfoItem(
                          icon: Icons.air,
                           label: 'Wind Speed', 
                           value: currentWindspeed.toString()
                      ),
                      AdditionalInfoItem(
                          icon: Icons.beach_access,
                          label: 'Pressure',
                          value: currentPressure.toString()
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
