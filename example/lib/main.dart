import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradients/gradients.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext
 context) {
    return MaterialApp(
      title: 'Gradients Package Examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Example of Flutter's Linear RGB gradient vs using different ColorSpaces available via "),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
 {
  final List<List<ColorModel>> boxGradients = [
    [ColorModel(Colors.black), ColorModel(Colors.white)],
    [ColorModel(Colors.green), ColorModel(Colors.white)],
    [ColorModel(Colors.green), ColorModel(Colors.black)],
    [ColorModel(Colors.blue),  ColorModel(Colors.red)],
    [ColorModel(Colors.yellow), ColorModel(Colors.purple)],
    [ColorModel(Colors.red),   ColorModel(Colors.green)],
    [ColorModel(Colors.lightGreen), ColorModel(Colors.orange)],
    [ColorModel(Colors.lightBlue),  ColorModel(Colors.lightGreen)],
    [ColorModel(Colors.amber),  ColorModel(Colors.lightBlue)],
    [ColorModel(Colors.pink),   ColorModel(Colors.amber)],
    [ColorModel(Colors.purple), ColorModel(Colors.red)],    
  ];

  //FULL LIST of available ColorSpace's //
  //final List<ColorSpace> colorSpaces = ColorSpace.values;
  // full list but re-ordered to have rgb next to dart
  final List<ColorSpace> colorSpaces = [
    ColorSpace.rgb,
    ColorSpace.lab,
    ColorSpace.oklab,
    ColorSpace.xyz,
    ColorSpace.cmyk,
    ColorSpace.hsb,
    ColorSpace.hsi,
    ColorSpace.hsl,
    ColorSpace.hsp,
  ];
  
  final String _link = 'https://pub.dev/packages/gradients';
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenWidth<800 ? 250 : 130,
        title: Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.title,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  TextSpan(
                    text: _link,
                    style: const TextStyle(
                      color: Colors.blue, fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final Uri uri = Uri.parse(_link);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {
                          // Handle the case where the link cannot be launched
                          print('Could not launch URL: $_link');
                        }
                      },
                  ),
                  const TextSpan(
                    text: ' package',
                    style: TextStyle(color: Colors.black, fontSize: 18),

                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Text( 'Dart code syntax for using built in gradients vs ColorSpace variants from Gradients package:',
              style:TextStyle(fontSize: 16, color: Colors.black),
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text:'Using Flutter gradient: ',
                    style: TextStyle(fontSize: 14, color: Colors.black)
                  ),
                  TextSpan(
                    text:' LinearGradient( colors: gradient, ... )',
                    style: GoogleFonts.courierPrime(textStyle: const TextStyle(fontSize: 14, color: Colors.green)),
                  )
                ]
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text:'Using gradients package: ',
                    style: TextStyle(fontSize: 14, color: Colors.black)
                  ),
                  TextSpan(
                    text:' LinearGradientPainter( colors: gradient, colorSpace: ColorSpace.xyz, ... )',
                    style: GoogleFonts.courierPrime(textStyle: const TextStyle(fontSize: 14, color: Colors.green)),
                  )
                ]
              ),
            ),
            const SizedBox(height:4),
          ],
        ),
      ),
    body: Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 4.0),
        ),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ... boxGradients.map((gradient) {
              // compute middle color's brightness so we can know what color to make the text
              // so it shows up.
              final rgbMidColors = gradient[0].lerpTo(gradient[1],1,colorSpace:ColorSpace.rgb,excludeOriginalColors:true);
              return Column(children: [
                Container(
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child:
                        Center(
                        child: Text(
                          'dart linear rgb',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: rgbMidColors[0].toHsbColor().b < 0.5 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ... colorSpaces.map((colorspace) {
                    // calculate middle color of this gradient so we can decide on visible text color
                    final midColors = gradient[0].lerpTo(gradient[1],1,colorSpace:colorspace,excludeOriginalColors:true);
                    return Container(
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradientPainter(
                          colors: gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colorSpace: colorspace,
                        ),
                      ),
                      child:
                        Center(
                        child: Text(
                          colorspace.toString().replaceAll('ColorSpace.',''),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: midColors[0].toHsbColor().b < 0.3 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }
                  ),
                  const Divider(color:Colors.grey,height: 4),
                ], 
              );
            }),
            ]
          ),
        ),
      ),
    );
  }
}