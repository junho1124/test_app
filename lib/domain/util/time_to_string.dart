String toDateString(int time) {
  if (0 <= time && time < 60) {
    return "방금 전";
  } else if (time < 3600) {
    return "${time ~/ 60} 분 전";
  } else if (time < 86400) {
    return "${time ~/ 3600} 시간 전";
  } else if (time < 604800) {
    return "${time ~/ 86400} 일 전";
  } else if (time < 2630000) {
    return "${time ~/ 604800} 주 전";
  } else if (time < 31536000) {
    return "${time ~/ 2592000} 달 전";
  } else {
    return "${time ~/ 31536000} 년 전";
  }
}
