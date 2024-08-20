import 'package:flutter/material.dart';
import 'package:for_raflippi/my_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '알비온 농사',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            '알비온 농사 계산기 with raflippi, 1cupofsea',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Row(
          children: [
            Expanded(child: InputPanel(formKey: formKey)),
            Expanded(child: OutputPanel()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            context.read<MyModel>().resetValues();
            formKey.currentState?.reset();
          },
        ),
      ),
    );
  }
}

class InputPanel extends StatelessWidget {
  final formKey;

  InputPanel({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '경작지(9개가 하나)',
                suffixText: '개',
              ),
              onChanged: (String value) {
                context.read<MyModel>().farmland =
                    value.isEmpty ? 0 : double.parse(value);
                context.read<MyModel>().setValues();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '단일 씨앗 수확율(비 관수)',
                hintText: '0.1',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (String value) {
                context.read<MyModel>().seedProfitRateNoWater =
                    value.isEmpty ? 0 : double.parse(value);
                context.read<MyModel>().setValues();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '단일 씨앗 수확율(관수)',
                hintText: '0.1',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (String value) {
                context.read<MyModel>().seedProfitRateWater =
                    value.isEmpty ? 0 : double.parse(value);
                context.read<MyModel>().setValues();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '단일 작물 수확량평균',
                suffixText: '개',
              ),
              onChanged: (String value) {
                context.read<MyModel>().singleCropYieldAverage =
                    value.isEmpty ? 0 : double.parse(value);
                context.read<MyModel>().setValues();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '관수 사용량',
                suffixText: '개',
                suffixStyle: TextStyle(color: Colors.black),
                hintText: '2.3',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (String value) {
                context.read<MyModel>().waterAmount =
                    value.isEmpty ? 0 : double.parse(value);
                context.read<MyModel>().setValues();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '작물 판매가',
                suffixText: 'silver',
              ),
              onChanged: (String value) {
                context.read<MyModel>().cropsSellingPrice =
                    value.isEmpty ? 0 : double.parse(value);
                context.read<MyModel>().setValues();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '씨앗 구매가',
                suffixText: 'silver',
              ),
              onChanged: (String value) {
                context.read<MyModel>().seedBuyingPrice =
                    value.isEmpty ? 0 : double.parse(value);
                context.read<MyModel>().setValues();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '세금시 수익',
                hintText: '0.9',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (String value) {
                context.read<MyModel>().taxRevenue =
                    value.isEmpty ? 0 : double.parse(value);
                context.read<MyModel>().setValues();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OutputPanel extends StatelessWidget {
  OutputPanel({super.key});

  @override
  Widget build(BuildContext context) {
    var threeDotFormat = NumberFormat('###,###,###,###');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '씨앗 수확량: ${threeDotFormat.format(context.watch<MyModel>().seedYield.floor())} 개',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '작물 수확량: ${threeDotFormat.format(context.watch<MyModel>().corpYield.floor())} 개',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '세금 일당 순수익: ${threeDotFormat.format(context.watch<MyModel>().dailyPureEarnings.floor())} silver',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '추가 필요 씨앗 개수: ${threeDotFormat.format(context.watch<MyModel>().numOfNeededSeedMore)} 개',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
