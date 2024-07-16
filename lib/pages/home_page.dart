import 'package:bue_rt/components/container/category_container.dart';
import 'package:bue_rt/components/container/image_container.dart';
import 'package:bue_rt/components/text/spanned_text.dart';
import 'package:bue_rt/functions/get_battery_percentage_color.dart';
import 'package:bue_rt/provider/database_provider.dart';
import 'package:bue_rt/provider/speed_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);
    final speed = ref.watch(speedProvider);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bckg.jpg"),
                  fit: BoxFit.contain),
            ),
            child: database.when(
              data: (data) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Row(
                              children: [
                                CategoryContainer(
                                  label: "Seat Belt",
                                  assetPath: "assets/icons/mdi_seatbelt.svg",
                                  condition: data["seatBelt"],
                                ),
                                CategoryContainer(
                                  label: "Door",
                                  assetPath:
                                      "assets/icons/mingcute_car-door-fill.svg",
                                  condition: data["door"],
                                ),
                                CategoryContainer(
                                  label: "High Beam",
                                  assetPath: "assets/icons/mdi_high-beam.svg",
                                  condition: data["highBeam"],
                                ),
                                CategoryContainer(
                                  label: "Temperature 1",
                                  assetPath:
                                      "assets/icons/carbon_temperature-max.svg",
                                  value: data["temperature1"],
                                  intOrBool: true,
                                ),
                                CategoryContainer(
                                  label: "Temperature 2",
                                  assetPath:
                                      "assets/icons/carbon_temperature-max.svg",
                                  value: data["temperature2"],
                                  intOrBool: true,
                                ),
                                CategoryContainer(
                                  label: "Smoke",
                                  assetPath:
                                      "assets/icons/streamline_smoke-detector-solid.svg",
                                  condition: data["smoke"],
                                ),
                                CategoryContainer(
                                  label: "Steering Wheel",
                                  assetPath:
                                      "assets/icons/streamline_steering-wheel-solid.svg",
                                  condition: data["steeringWheel"],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                speed.when(data: (data) {
                                  final double speedKmH =
                                      data * 3.6; // Convert m/s to km/h
                                  print("Speed: $speedKmH");
                                  return Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 90,
                                        right: 190,
                                        left: 30,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          height: 340,
                                          width: 340,
                                          child: SfRadialGauge(
                                            axes: <RadialAxis>[
                                              RadialAxis(
                                                minimum: 0,
                                                maximum: 100,
                                                ranges: <GaugeRange>[
                                                  GaugeRange(
                                                    startValue: 0,
                                                    endValue: speedKmH,
                                                    startWidth: 10,
                                                    endWidth: 10,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiaryContainer,
                                                    gradient:
                                                        const SweepGradient(
                                                      colors: [
                                                        Colors.red,
                                                        Colors.pinkAccent
                                                      ],
                                                      stops: [0.5, 1.0],
                                                    ),
                                                  ),
                                                ],
                                                pointers: const <GaugePointer>[],
                                                annotations: <GaugeAnnotation>[
                                                  GaugeAnnotation(
                                                    widget: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: speedKmH
                                                                        .toStringAsFixed(
                                                                            0) ==
                                                                    "0"
                                                                ? "00"
                                                                : speedKmH
                                                                    .toStringAsFixed(
                                                                        0),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Digi',
                                                              fontSize: 100,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .tertiaryContainer,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: "km/h",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Digi',
                                                              fontSize:
                                                                  30, // Change this to the desired size for "km"
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .tertiaryContainer,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    angle: 90,
                                                    positionFactor:
                                                        0.1, // Adjust to center the text correctly
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }, loading: () {
                                  return const CircularProgressIndicator();
                                }, error: (error, stackTrace) {
                                  return Text("Error: $error.toString()");
                                }),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 160, bottom: 90),
                                      child: CircularPercentIndicator(
                                        radius: 160,
                                        lineWidth: 13.0,
                                        animation: true,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        progressColor:
                                            getColor(data["batteryPercentage"]),
                                        percent:
                                            data["batteryPercentage"] / 100,
                                        center: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: data["batteryPercentage"]
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Digi',
                                                  fontSize: 100,
                                                  fontStyle: FontStyle.italic,
                                                  color: getColor(data[
                                                      "batteryPercentage"]),
                                                ),
                                              ),
                                              TextSpan(
                                                text: "%",
                                                style: TextStyle(
                                                  fontFamily: 'Digi',
                                                  fontSize:
                                                      30, // Change this to the desired size for "km"
                                                  fontStyle: FontStyle.italic,
                                                  color: getColor(data[
                                                      "batteryPercentage"]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 400,
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.arrow_left,
                                        size: 150,
                                        color: data["leftIndicator"]
                                            ? Theme.of(context)
                                                .colorScheme
                                                .tertiaryContainer
                                            : Colors.grey,
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        size: 150,
                                        color: data["rightIndicator"]
                                            ? Theme.of(context)
                                                .colorScheme
                                                .tertiaryContainer
                                            : Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 500, // Adjust the width as needed
                                    height: 300, // Adjust the height as needed
                                    child: ImageContainer(
                                      imagePath: "assets/images/middle.png",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 60, right: 60),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SpannedText(
                                        value: data["rangeLeft"].toString(),
                                        unit: "km",
                                        label: "Range",
                                        icon: Icons.directions_car,
                                      ),
                                      SpannedText(
                                        value: data["distanceTravelled"]
                                            .toString(),
                                        unit: "km",
                                        label: "Distance Travelled",
                                        icon: Icons.navigation,
                                      ),
                                      SpannedText(
                                        value: data["voltage"].toString(),
                                        unit: "V",
                                        label: "Voltage",
                                        icon: Icons.bolt,
                                      ),
                                      SpannedText(
                                        value: data["current"].toString(),
                                        unit: "A",
                                        label: "Current",
                                        icon: Icons.electric_bolt,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
