import 'dart:convert';

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
  calculateAmount(String amount) {
    // int.parseで文字列を数字にする。
    final price = int.parse(amount) * 100;
    return price.toString();
  }

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
                      onPressed: () async {
                        try {
                          final url = Uri.parse(
                              'https://asia-northeast1-flutterstripewithfunctions.cloudfunctions.net/stripePaymentIntent');
                          Map<String, dynamic> body = {
                            "amount": calculateAmount('1'),
                            "currency": "JPY",
                          };
                          final response = await http.post(url, body: body);
                          var jsonResponse = jsonDecode(response.body);
                          Map<String, dynamic> paymentIntentData = jsonResponse;
                          if (paymentIntentData['paymentIntent'] != "" &&
                              paymentIntentData['paymentIntent'] != null) {
                            String _intent = paymentIntentData['paymentIntent'];
                            await Stripe.instance.initPaymentSheet(
                              paymentSheetParameters:
                                  SetupPaymentSheetParameters(
                                paymentIntentClientSecret: _intent,
                                applePay: false,
                                googlePay: false,
                                testEnv: true,
                                style: ThemeMode.light,
                                merchantCountryCode: 'JP',
                                merchantDisplayName: 'My name',
                                customerId: paymentIntentData['customer'],
                                customerEphemeralKeySecret:
                                    paymentIntentData['ephemeralKey'],
                              ),
                            );
                            await Stripe.instance.presentPaymentSheet();
                          }
                        } catch (e) {
                          print('バツボタンを押したときの処理');
                          print(e.toString());
                        }
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
