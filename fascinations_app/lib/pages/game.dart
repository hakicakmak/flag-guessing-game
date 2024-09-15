import 'package:fascinations_app/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../contants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/flag_widget.dart';
import '../classes/game_class.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Game(),
    ),
  );
}

class Game extends StatefulWidget {
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int score = 0;
  CountryGuessingGame game = CountryGuessingGame();
  Flag randomCountry = Flag(flagCodeName: '', countryName: '');
  List<String> options = [];
  int bestScore = 0;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    initPrefs();
    startGame();
  }

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();

    // Kayıtlı bestScore değerini kontrol edin
    if (!_prefs!.containsKey('bestScore')) {
      // Eğer kayıtlı bestScore yoksa, yeni bir kayıt oluşturun ve değeri 0 olarak atayın
      _prefs!.setInt('bestScore', 0);
      bestScore = 0;
    } else {
      // Eğer kayıtlı bestScore varsa, onu okuyun
      bestScore = _prefs!.getInt('bestScore') ?? 0;
    }

    setState(() {});
  }

  void startGame() {
    if (game.askedCountries.length == game.countries.length) {
      Alert("Tebrikler", "Oyunu Tamamladınız!", "Tamam");
    } else {
      randomCountry = game.QuestionCountry();
      options = game.options();
    }
  }

  void handleOptionTap(String selectedFlagCode) {
    setState(() {
      if (selectedFlagCode == randomCountry.flagCodeName) {
        if (score > bestScore) {
          bestScore = score;
          _prefs?.setInt('bestScore', bestScore);
        }
        score = score + 1;
        startGame();
      } else {
        if (score > bestScore) {
          bestScore = score;
          _prefs?.setInt('bestScore', bestScore);

          Alert(
              "Yanlış Tahmin",
              "Üzgününüm..Yanlış tahmin ettiniz. BestScore:$score",
              "Tekrar Başla");
        } else {
          Alert("Yanlış Tahmin",
              "Üzgününüm..Yanlış tahmin ettiniz. Score:$score", "Tekrar Başla");
        }
      }
    });
  }

  Future<dynamic> Alert(String title, String text, String buttonText) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C9281),
              ),
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // screen size
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: const Color.fromARGB(255, 240, 240, 239),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 203, 202, 202)
                          .withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight / 15,
                      bottom: screenHeight / 80,
                      right: screenWidth / 20,
                      left: screenWidth / 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: screenWidth / 2.8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE4E4E4),
                            borderRadius: BorderRadius.circular(75),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.trophy,
                                size: screenHeight * .019,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "BestScore:",
                                style: GoogleFonts.asap(
                                    textStyle: kBestscoreStyle,
                                    fontSize: screenHeight * .018),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                bestScore.toString(),
                                style: GoogleFonts.asap(
                                    textStyle: kBestscoreStyle,
                                    fontSize: screenHeight * .018),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Guess the Flag of ",
                                      style: GoogleFonts.anekTelugu(
                                        textStyle: kquestionStyle,
                                        fontSize: screenWidth * .06,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        left: 10,
                                      ),
                                      child: Text(
                                        randomCountry.countryName,
                                        softWrap: true,
                                        style: GoogleFonts.anekTelugu(
                                          textStyle: kquestionStyle.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                          fontSize: screenWidth * .06,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: ShapeDecoration(
                            color: const Color(0xFFE4E4E4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(75),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Score:",
                                style: GoogleFonts.asap(
                                    textStyle: kscoreStyle,
                                    fontSize: screenHeight * .02),
                              ),
                              Text(
                                score.toString(),
                                style: GoogleFonts.asap(
                                    textStyle: kscoreStyle,
                                    fontSize: screenHeight * .02),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(
                    top: screenHeight / 30,
                    bottom: screenHeight / 30,
                    right: screenWidth / 20,
                    left: screenWidth / 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    expanded(screenWidth, 0),
                    const SizedBox(
                      height: 10,
                    ),
                    expanded(screenWidth, 1),
                    const SizedBox(
                      height: 10,
                    ),
                    expanded(screenWidth, 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded expanded(double screenWidth, int index) {
    return Expanded(
      child: Padding(
        padding:
            EdgeInsets.only(right: screenWidth / 6.6, left: screenWidth / 6.6),
        child: Container(
          child: InkWell(
            onTap: () {
              handleOptionTap(options[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 157, 152, 152)
                        .withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 9,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: FlagWidget(
                  countryCode: options[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
