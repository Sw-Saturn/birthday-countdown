import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Birthday Countdown',
			home: BirthdayCountdown(),
			localizationsDelegates: [
				GlobalMaterialLocalizations.delegate,
				GlobalWidgetsLocalizations.delegate,
			],
			supportedLocales: [
				const Locale("ja", "JP")
			],
			theme: ThemeData(
					primarySwatch: Colors.amber,
			),
		);
	}
}

class BirthdayCountdown extends StatefulWidget {
	BirthdayCountdown({Key key}) : super(key: key);

	@override
	BirthdayCountdownState createState() => BirthdayCountdownState();
}
