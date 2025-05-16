import 'package:intl/intl.dart';

class DateConstant{
static
  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return 'Just now';
    }/* else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    }*/ else if (isSameDay(dateTime, now)) {
      return DateFormat('hh:mm a').format(dateTime);
    } else if (diff.inDays < 7) {
      return DateFormat('EEEE').format(dateTime);
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
  }

static  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

}