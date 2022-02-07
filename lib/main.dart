import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

void main() {
  Stripe.publishableKey =
      'pk_test_51JpJPXHOQj6xr8T2DzMs9m18d27qLuOaxtrvUK2yNGAm23IAW29zMyncx3wTmggHt5eceozZPBxx89OVwowM5lh900YJrfG42H';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Stripe Payment')),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: SizedBox(
                height: 60,
                // double.infinityはできるだけ横幅いっぱいにの意味
                width: double.infinity,
                child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          // transformは角度？みたいな感じ
                          transform: GradientRotation(20),
                          colors: <Color>[
                            Color(0xff439cfb),
                            Color(0xfff187fb),
                          ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        final url = Uri.parse(
                            'https://asia-northeast1-flutterstripewithfunctions.cloudfunctions.net/stripePaymentIntent');
                        final response = http.post(url);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(6.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      child: const Text('Stripe',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
              )),
        ));
  }
}
