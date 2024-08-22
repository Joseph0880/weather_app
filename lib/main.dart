// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Bar Chart')),
//         body: Center(
//           child: Card(
//             elevation: 4.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: CustomPaint(
//                 size: Size(320, 200),
//                 painter: BarChartPainter(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BarChartPainter extends CustomPainter {
//   final List<double> data = [80, 150, 100, 200, 120];
//   final List<String> labels = ['A', 'B', 'C', 'D', 'E'];
//   final double barWidth = 40;

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint axisPaint = Paint()
//       ..color = Colors.grey
//       ..strokeWidth = 2;

//     Paint barPaint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;

//     TextPainter textPainter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     // Draw x and y axis
//     canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), axisPaint);
//     canvas.drawLine(Offset(0, 0), Offset(0, size.height), axisPaint);

//     // Draw x-axis name
//     textPainter.text = TextSpan(
//       text: 'Categories',
//       style: TextStyle(color: Colors.black, fontSize: 14),
//     );
//     textPainter.layout();
//     textPainter.paint(canvas, Offset(size.width / 2 - textPainter.width / 2, size.height + 10));

//     // Draw y-axis name
//     canvas.save();
//     canvas.translate(-30, size.height / 2);
//     canvas.rotate(-3.14 / 2);
//     textPainter.text = TextSpan(
//       text: 'Values',
//       style: TextStyle(color: Colors.black, fontSize: 14),
//     );
//     textPainter.layout();
//     textPainter.paint(canvas, Offset(-textPainter.width / 2, 0));
//     canvas.restore();

//     // Draw bars and labels
//     for (int i = 0; i < data.length; i++) {
//       double barHeight = data[i];
//       double x = i * (barWidth + 20); // Space between bars
//       double y = size.height - barHeight;

//       Rect barRect = Rect.fromLTWH(x, y, barWidth, barHeight);
//       canvas.drawRect(barRect, barPaint);

//       // Draw bar labels
//       textPainter.text = TextSpan(
//         text: labels[i],
//         style: TextStyle(color: Colors.black, fontSize: 12),
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(x + barWidth / 2 - textPainter.width / 2, size.height + 5),
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

import 'package:flutter/material.dart';
import 'package:weather_app/pages/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const WeatherScreen(),
    );
  }
}

