import 'package:flutter/material.dart';

class OptionWidget extends StatefulWidget {
  final String title;
  final ValueNotifier<String> value;
  final List<String>? answers;
  final bool? isTextQuestion;
  final bool? isRestrictions;

  const OptionWidget({
    super.key,
    required this.title,
    required this.value,
    this.isRestrictions,
    this.isTextQuestion,
    this.answers,
  });

  @override
  _OptionWidgetState createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  final Map<String, bool> restrictions = {
    'Без сахара': false,
    'Без глютена': false,
    'Без лактозы': false,
    'Без орехов': false,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 5),
          widget.isTextQuestion == true
              ? TextField(
                onChanged: (value) {
                  widget.value.value = value;
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: "Введите ответ",
                ),
              )
              : widget.isRestrictions == true
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    restrictions.keys.map((restriction) {
                      return CheckboxListTile(
                        title: Text(
                          restriction,
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: restrictions[restriction],
                        onChanged: (bool? value) {
                          setState(() {
                            restrictions[restriction] = value ?? false;
                            widget.value.value = restrictions.entries
                                .where((entry) => entry.value)
                                .map((entry) => entry.key)
                                .join(', ');
                          });
                        },
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),
              )
              : widget.answers == null || widget.answers!.isEmpty
              ? const Text(
                "Нет доступных вариантов",
                style: TextStyle(color: Colors.white54),
              )
              : ValueListenableBuilder<String>(
                valueListenable: widget.value,
                builder: (context, selectedAnswer, child) {
                  return DropdownButton<String>(
                    value: selectedAnswer.isNotEmpty ? selectedAnswer : null,
                    hint: const Text(
                      "Выберите ответ",
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.black,
                    onChanged: (String? newValue) {
                      widget.value.value = newValue ?? '';
                    },
                    items:
                        widget.answers!.map((String answer) {
                          return DropdownMenuItem<String>(
                            value: answer,
                            child: Text(
                              answer,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                  );
                },
              ),
        ],
      ),
    );
  }
}
