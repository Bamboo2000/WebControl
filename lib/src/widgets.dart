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
                            const TextStyle(fontSize: 80, color: Colors.black),
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

// class Paragraph extends StatelessWidget {
//   const Paragraph(this.content, {super.key});
//   final String content;
//   @override
//   Widget build(BuildContext context) => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         child: Text(
//           content,
//           style: const TextStyle(fontSize: 18, color: color_6),
//         ),
//       );
// }

// class DisplayStyle extends StatelessWidget {
//   const DisplayStyle(this.content, {super.key});
//   final String content;
//   @override
//   Widget build(BuildContext context) => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         child: Text(
//           content,
//           style: const TextStyle(fontSize: 24, color: color_6),
//         ),
//       );
// }

// class IconAndDetail extends StatelessWidget {
//   const IconAndDetail(this.icon, this.detail, {super.key});
//   final IconData icon;
//   final String detail;

//   @override
//   Widget build(BuildContext context) => Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Icon(icon),
//             const SizedBox(width: 8),
//             Text(
//               detail,
//               style: const TextStyle(fontSize: 18),
//             )
//           ],
//         ),
//       );
// }

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

// class TempControlButton extends StatelessWidget {
//   const TempControlButton(
//       {required this.child, required this.onPressed, super.key});
//   final Widget child;
//   final void Function() onPressed;

//   @override
//   Widget build(BuildContext context) => ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           fixedSize: Size(150, 150),
//           elevation: 2,
//           side: const BorderSide(width: 1, color: color_5),
//           foregroundColor: color_5,
//           backgroundColor: color_5,
//         ),
//         onPressed: onPressed,
//         child: child,
//       );
// }
