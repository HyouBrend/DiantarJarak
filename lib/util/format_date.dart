import 'package:intl/intl.dart';

String? formatDisplayDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) {
    return null;
  }

  try {
    DateFormat inputFormat =
        DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz', 'en_US');
    DateTime dateTime = inputFormat.parse(dateStr);
    // Tambahkan 7 jam pada DateTime jika belum diubah ke GMT+7
    dateTime = dateTime.add(Duration(hours: 7));

    DateFormat outputFormat = DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID');
    return outputFormat.format(dateTime) + ' WIB';
  } catch (e) {
    return null;
  }
}

String? formatTimeBakAndSend(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) {
    return null;
  }

  try {
    DateFormat inputFormat =
        DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz', 'en_US');
    DateTime dateTime = inputFormat.parse(dateStr);

    DateFormat outputFormat = DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID');
    return outputFormat.format(dateTime) + ' WIB';
  } catch (e) {
    return null;
  }
}
