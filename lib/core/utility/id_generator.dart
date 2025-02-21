import 'dart:math';

class IdGenerator {
  static String genId(int length) {
    Random random = Random();
    String character =
        'QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890';
    StringBuffer id = StringBuffer();
    for (int i = 0; i < length; i++) {
      id.write(character[random.nextInt(character.length)]);
    }
    print(id);
    return id.toString();
  }
}
