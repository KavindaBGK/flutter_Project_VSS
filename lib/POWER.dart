import 'package:flutter/material.dart';

class CustomPowerButton extends StatefulWidget {
  final bool isPowerOn;
  final VoidCallback onPressed;
  final double buttonSize;
  final List<Color> gradientColors;
  final String iconImage;
  const CustomPowerButton({
    required this.isPowerOn,
    required this.onPressed,
    required this.buttonSize,
    required this.gradientColors,
    required this.iconImage,
  });
  @override
  _CustomPowerButtonState createState() => _CustomPowerButtonState();
}

class _CustomPowerButtonState extends State<CustomPowerButton> {
  late bool _isPressed;
  @override
  void initState() {
    super.initState();
    _isPressed = widget.isPowerOn;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPressed = !_isPressed;
        });
        widget.onPressed();
      },
      child: Container(
        width: widget.buttonSize,
        height: widget.buttonSize,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: _isPressed
                  ? [
                      Color.fromARGB(106, 0, 0, 0),
                      const Color.fromARGB(255, 54, 52, 52)
                    ]
                  : widget.gradientColors,
              stops: _isPressed
                  ? [0.05, 0.45]
                  : [0.1, 0.6], // Adjust the stops here
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ]),
        child: Center(
          child: Image.asset(
            widget
                .iconImage, // Replace 'assets/image_path.png' with your image path
            width: widget.buttonSize * 0.6, // Adjust size as needed
            height: widget.buttonSize * 0.6, // Adjust size as needed
            color: Colors
                .white, // Optional: You can set the color of the image if needed
          ),
        ),
      ),
    );
  }
}
