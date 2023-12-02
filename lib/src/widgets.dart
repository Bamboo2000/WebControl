import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//COLORS
const color_1 = Color(0xFF6A994E);
const color_2 = Color.fromARGB(255, 255, 21, 25);
const color_3 = Color(0xFF6A994E);
const color_4 = Color(0xFF32353e);
const color_5 = Color.fromARGB(111, 255, 255, 255);
const color_6 = Color(0xFF32353e);

class Block extends StatelessWidget {
  const Block(this.mainValue, this.unitofMeasure, this.descripton, this.width,
      this.height,
      {super.key});
  final String mainValue;
  final String unitofMeasure;
  final String descripton;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // +dinamikussá tenni
              width: width,
              height: height,
              child: Card(
                elevation: 5,
                shadowColor: color_6,
                color: color_2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mainValue.toString(),
                      style: GoogleFonts.monoton(
                        textStyle:
                            const TextStyle(fontSize: 75, color: Colors.black),
                      ),
                    ),
                    Text(
                      unitofMeasure,
                      style: GoogleFonts.playfairDisplay(
                        textStyle:
                            const TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              descripton,
              style: GoogleFonts.vinaSans(
                textStyle: const TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
          ],
        ),
      );
}

class Header extends StatelessWidget {
  const Header(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 28, color: color_6),
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, super.key});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: color_6),
            foregroundColor: color_6,
            fixedSize: Size(100, 50)),
        onPressed: onPressed,
        child: child,
      );
}

class PostButton extends StatelessWidget {
  const PostButton(
      {required this.mainText,
      required this.secondText,
      required this.onPressed,
      super.key});
  final String mainText;
  final String secondText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color_6,
        elevation: 10,
        fixedSize: Size(250, 90),
      ),
      onPressed: onPressed,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          mainText,
          style: const TextStyle(
            fontSize: 25,
            letterSpacing: 3,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          secondText,
          style: const TextStyle(
            fontSize: 18,
            color: color_3,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ]));
}
