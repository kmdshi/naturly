import 'package:flutter/material.dart';

class OptionWidget extends StatefulWidget {
  final String title;
  final List<String>? answers;
  final bool? isTextQuestion;

  const OptionWidget({
    super.key,
    required this.title,
    this.isTextQuestion,
    this.answers,
  });

  @override
  _OptionWidgetState createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 5),
          widget.isTextQuestion != null
              ? TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: "Введите ответ",
                  ),
                )
              : widget.answers == null || widget.answers!.isEmpty
                  ? Text(
                      "Нет доступных вариантов",
                      style: TextStyle(color: Colors.white54),
                    )
                  : DropdownButton<String>(
                      value: selectedAnswer,
                      hint: Text(
                        "Выберите ответ",
                        style: TextStyle(color: Colors.white),
                      ),
                      dropdownColor: Colors.black,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedAnswer = newValue;
                        });
                      },
                      items: widget.answers!.map((String answer) {
                        return DropdownMenuItem<String>(
                          value: answer,
                          child: Text(answer,
                              style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                    ),
        ],
      ),
    );
  }
}
