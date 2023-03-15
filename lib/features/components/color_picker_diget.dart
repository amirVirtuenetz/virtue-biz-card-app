import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  final List<Color> colors;
  final Function(Color) onPressed;
  final void Function() onEditPressed;
  const ColorPickerWidget(
      {super.key,
      required this.colors,
      required this.onPressed,
      required this.onEditPressed});

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  int selectedColorIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 40.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.colors.isNotEmpty ? widget.colors.length + 1 : 1,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 2),
          itemBuilder: (BuildContext context, int index) {
            if (index == widget.colors.length) {
              return Container(
                width: 40,
                height: 40,
                // padding: EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white
                    // borderRadius: BorderRadius.circular(15),
                    ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: widget.onEditPressed,
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 20,
                    ),
                  ),
                ),
              );
            } else {
              return Material(
                color: Colors.transparent,
                // borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  // borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {});
                    widget.onPressed(widget.colors[index]);
                    selectedColorIndex = index;
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        // padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(15),
                          color: widget.colors[index],
                        ),
                      ),
                      selectedColorIndex == index
                          ? Positioned(
                              child: Icon(
                                Icons.check,
                                size: 20,
                                color: (selectedColorIndex == index &&
                                        widget.colors[index] == Colors.white)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
            }
            // return CircleButton(
            //   onPressed: () {},
            //   fillColor: colors[index],
            //   child: const SizedBox(
            //   ),
            // );
          }),
    );
  }
}
