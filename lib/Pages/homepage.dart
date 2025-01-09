import 'package:flutter/material.dart';
import 'package:weather_app/Pages/current_weather_page.dart';
import 'package:weather_app/Pages/division_weather_page.dart';
import 'package:weather_app/Pages/search_weather_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                const Color.fromARGB(255, 46, 6, 114),
                const Color.fromARGB(255, 55, 19, 116),
                Colors.deepPurple,
                const Color.fromARGB(255, 131, 78, 224),
                Colors.purpleAccent,
              ])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.network(
                //   "https://cdn-icons-png.flaticon.com/512/3845/3845731.png",
                //   width: 200,
                //   height: 200,
                // ),
                Image.asset(
                  "assets/ic_launcher.png",
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.orange,
                      Colors.orange,
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'MoodyWeather',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CurrentWeatherPage()),
                  ),
                  child: const Text('Current Weather', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DivisionWeatherPage()),
                  ),
                  child: const Text('Division Weather',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchWeatherPage()),
                  ),
                  child: const Text('Search Weather', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
