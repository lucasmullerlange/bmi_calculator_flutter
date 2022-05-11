import 'package:flutter/material.dart';

enum Sex { male, famale }

class SexRadioWidget extends StatelessWidget {
  Sex sex;
  void Function(Sex sex) onChange;

  SexRadioWidget({
    Key? key,
    required this.sex,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () => onChange(Sex.male),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Opacity(
              opacity: sex == Sex.male ? 1 : 0.3,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: Image.asset(
                      "assets/images/male.jpg",
                      fit: BoxFit.cover,
                    ).image,
                  ),
                  const SizedBox(height: 10),
                  const Text("Male")
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => onChange(Sex.famale),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Opacity(
              opacity: sex == Sex.famale ? 1 : 0.3,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: Image.asset(
                      "assets/images/female.jpg",
                      fit: BoxFit.cover,
                    ).image,
                  ),
                  const SizedBox(height: 10),
                  const Text("Famale")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
