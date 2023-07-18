// import 'package:flutter/material.dart';

// String emojiText(String inputString) {
//   List<String> emojiNames = inputString
//       .replaceAll('<i class="twa-lg twa twa-', '')
//       .replaceAll('"></i>', '')
//       .trim()
//       .split(' ');

//   print(emojiNames);

//   // Create a list of emojis as Text widgets
//   // List<Widget> emojis = emojiNames.map((emojiName) {
//   //   return Text(
//   //     String.fromCharCode(int.parse('0x1F$emojiName', radix: 16)),
//   //     style: GoogleFonts.reemKufi(fontSize: 24), // Set the desired font size for emojis
//   //   );
//   // }).toList();

//   // Extract the remaining text
//   String remainingText = inputString.replaceAll(RegExp('<.*?>'), '').trim();
//   List<String> wordsToRemove = remainingText.split(" ");
//   wordsArray.removeWhere((word) => wordsToRemove.contains(word));

  
//   print(remainingText);

//   return "emoji";
// }
