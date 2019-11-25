import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapido/rapido.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class BirthdayCountdownState extends State<BirthdayCountdown> {
	Birthday _birthday = new Birthday();
	final DocumentList documentList = DocumentList(
		"Birthdays",
		labels: {"Who": "who", "Birthday": "date"},
	);

	Widget _customBuilder(int index, Document doc, BuildContext context){
		TextTheme theme = Theme.of(context).textTheme;
		return Card(
			color: getCardColor(doc, _birthday.getRemainingDays(doc)),
			child: Row(
				children: <Widget>[
					Padding(
						padding: EdgeInsets.all(8.0),
						child: Text((_birthday.getNextAge(doc)-1).toString(),
							style: theme.display1,
						),
					),
					Expanded(
						child: Column(
							children: <Widget>[
								Text(doc["date"].toString(), style: theme.display1,),
								Text(doc["who"], style: theme.headline),
								Text(_birthday.getDescription(_birthday.getRemainingDays(doc), _birthday.getNextAge(doc)), style: theme.title,),
							],
						),
					),
					DocumentActionsButton(documentList, index: index,),
				],
			),
		);
	}

	Color getCardColor(Document doc, int remaining) {
		if (remaining == 0) return Colors.deepOrange;
		if (remaining < 7) return Colors.orange;
		if (remaining < 14) return Colors.orange[300];
		if (remaining < 30) return Colors.orange[100];
		return Colors.white;
	}

	@override
	Widget build(BuildContext context) {
		return DocumentListScaffold(
			documentList,
			emptyListWidget: Center(
				child: Text("Click the add button to add the birthday."),
			),
			customItemBuilder: _customBuilder,
		);
	}
}

class Birthday {
	int getNextAge(Document doc) {
		final format = DateFormat('MM/dd/yyyy', "ja_JP");
		DateTime date = format.parse(doc["date"]);
		final today = new DateTime.now();
		final nextBirthday = today.add(Duration(days: getRemainingDays(doc)));
		final age = nextBirthday.year - date.year;
		return age;
	}

	int getRemainingDays(Document doc) {
		final format = DateFormat('MM/dd/yyyy', "ja_JP");
		DateTime date = format.parse(doc["date"]);
		date = new DateTime(DateTime.now().year, date.month, date.day, date.hour, date.minute, date.second);
		final remaining = -1 * DateTime.now().difference(date).inDays;
		if (remaining < 0) {
			return remaining + 365;
		}
		return remaining;
	}

	String getDescription(int remainingDays, int age) {
		if (remainingDays == 0) {
			return "お誕生日おめでとうございます！";
		}
		return "あと$remainingDays日";
	}
}
