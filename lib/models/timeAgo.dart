import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeAgo{
  static String timeAgoSinceDate(Timestamp timestamp){
    DateTime date = timestamp.toDate(); // Convert Timestamp to DateTime
    var now = DateTime.now();
    var diff = now.difference(date);

    if(diff.inDays > 8)
      return DateFormat('dd-MM-yyyy HH:mm').format(date);
    else if((diff.inDays / 7 ).floor() >= 1)
      return 'Last week';
    else if(diff.inDays >= 2)
      return '${diff.inDays} days ago';
    else if (diff.inDays >= 1)
      return '1 day ago';
    else if(diff.inHours >= 2)
      return '${diff.inHours}h';
    else if(diff.inHours >= 1)
      return '1h';
    else if(diff.inMinutes >= 2)
      return '${diff.inMinutes}m';
    else if(diff.inMinutes >= 1)
      return '1m';
    else if(diff.inSeconds >= 3)
      return '${diff.inSeconds}s';
    else
      return 'now';
  }
}