String formatDuration(dynamic seconds) {
  if (seconds == null) return '00:00';

  int? sec;
  if (seconds is int) {
    sec = seconds;
  } else if (seconds is String) {
    sec = int.tryParse(seconds);
  } else {
    return '00:00';
  }

  if (sec == null) return '00:00';

  final minutes = sec ~/ 60;
  final remainingSeconds = sec % 60;
  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}
