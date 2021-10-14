import 'package:flutter/material.dart';

class OptionProps {
  final String title;
  final dynamic value;

  OptionProps({required this.title, required this.value});
}

class RadioGroup extends StatefulWidget {
  final List<OptionProps> options;
  final String? title;
  final Function? onChange;
  final int? selected;
  const RadioGroup({
    Key? key,
    required this.options,
    this.title,
    this.onChange,
    this.selected = 0,
  }) : super(key: key);

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  int selectIndex = 0;

  @override
  void initState() {
    setState(() {
      selectIndex = widget.selected!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Column(
                children: [
                  Text(widget.title!,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 10,
                  )
                ],
              )
            : SizedBox(),
        GridView.count(
          shrinkWrap: true,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 4,
          crossAxisCount: 3,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            for (var i = 0; i < widget.options.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectIndex = i;
                    widget.onChange?.call(widget.options[i]);
                  });
                },
                child: Row(
                  children: [
                    selectIndex == i
                        ? Icon(Icons.check_circle, color: Colors.pink)
                        : Icon(Icons.circle_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(widget.options[i].title)
                  ],
                ),
              )
          ],
        ),
      ],
    );
  }
}
