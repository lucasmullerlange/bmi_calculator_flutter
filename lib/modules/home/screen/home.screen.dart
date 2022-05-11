import 'package:ap1/config/theme/theme.dart';
import 'package:ap1/modules/home/widgets/info_button.widget.dart';
import 'package:ap1/modules/home/widgets/sex_radio.widget.dart';
import 'package:flutter/material.dart';
import "dart:math" as math;

import 'package:flutter_bloc/flutter_bloc.dart';

enum YourState { underweight, normal, overweight, obesity }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Sex _sex = Sex.male;
  double? _result;
  YourState? _yourState;
  final TextEditingController _weightController =
      TextEditingController(text: "80");
  final TextEditingController _heightController =
      TextEditingController(text: "175");

  _HomeScreenState();

  void onCalculateAgain() {
    setState(() {
      _result = null;
      _yourState = null;

      _weightController.text = "80";
      _heightController.text = "175";
    });
  }

  void onCalculateBmi() {
    setState(() {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text);

      _result = weight / math.pow(height / 100, 2);

      if (_result! < 18.5) {
        _yourState = YourState.underweight;
      } else if (_result! < 25) {
        _yourState = YourState.normal;
      } else if (_result! < 30) {
        _yourState = YourState.overweight;
      } else {
        _yourState = YourState.obesity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "BMI Calculator",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      BlocBuilder<ThemeCubit, ThemeData>(
                          builder: (context, state) {
                        ThemeCubit themeCubit = context.read<ThemeCubit>();

                        return IconButton(
                          onPressed: () {
                            if (state.brightness == Brightness.dark) {
                              themeCubit.changeLight();
                            } else {
                              themeCubit.changeDark();
                            }
                          },
                          icon: Icon(
                            state.brightness == Brightness.dark
                                ? Icons.dark_mode
                                : Icons.light_mode,
                          ),
                        );
                      }),
                      const InfoButtonWidget(),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              SexRadioWidget(
                sex: _sex,
                onChange: (sex) => setState(() => _sex = sex),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Your weight "),
                            Text(
                              "(kg)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 30),
                          controller: _weightController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Your height "),
                            Text(
                              "(cm)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 30),
                          controller: _heightController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Builder(builder: (context) {
                if (_result != null) {
                  return Column(
                    children: [
                      const Text(
                        "Your BMI",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _result!.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _yourState!.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: onCalculateAgain,
                        child: const Text("Calculate BMI again"),
                      )
                    ],
                  );
                }
                return Column(
                  children: const [
                    Text(
                      "Your BMI",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "-",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onCalculateBmi,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Text("Calculate your BMI"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
