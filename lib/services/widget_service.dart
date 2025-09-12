import 'package:home_widget/home_widget.dart';

class WidgetService {
  static const String iOSGroupId = 'group.com.example.moodtracker';

  static Future<void> updateHomeWidget(String mood, String note) async {
    await HomeWidget.saveWidgetData<String>('mood', mood);
    await HomeWidget.saveWidgetData<String>('note', note);
    await HomeWidget.updateWidget(name: 'HomeWidgetProvider', iOSName: 'MoodWidget');
  }
}
