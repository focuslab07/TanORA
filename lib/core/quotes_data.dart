import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Quote {
  final String text;
  final String category;
  bool isFavorite;
  final bool isUserCreated;

  Quote({
    required this.text,
    required this.category,
    this.isFavorite = false,
    this.isUserCreated = false,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'category': category,
        'isFavorite': isFavorite,
        'isUserCreated': isUserCreated,
      };

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        text: json['text'],
        category: json['category'],
        isFavorite: json['isFavorite'] ?? false,
        isUserCreated: json['isUserCreated'] ?? false,
      );
}

class AppEvent {
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final bool reminder;

  AppEvent({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.reminder,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
        'time': time,
        'reminder': reminder,
      };

  factory AppEvent.fromJson(Map<String, dynamic> json) => AppEvent(
        title: json['title'],
        description: json['description'],
        date: DateTime.parse(json['date']),
        time: json['time'],
        reminder: json['reminder'] ?? false,
      );
}

class QuotesData {
  static List<Quote> userQuotes = [];
  static Map<DateTime, List<AppEvent>> events = {};

  static List<Quote> allQuotes = [
    // --- FALIFALY ---
    Quote(text: "Ny fahasambarana dia safidy.", category: "Falifaly"),
    Quote(text: "Ankafizo ny fiainanao.", category: "Falifaly"),
    Quote(text: "Ataovy manatrika ny masoandro ny tavanao.", category: "Falifaly"),
    Quote(text: "Ny tanjon’ny fiainana dia ny ho sambatra.", category: "Falifaly"),
    Quote(text: "Mifalia amin’izao fotoana izao.", category: "Falifaly"),
    Quote(text: "Aparitaho ny fitiavana.", category: "Falifaly"),
    Quote(text: "Mijanòna amin’izay mampifaly anao.", category: "Falifaly"),
    Quote(text: "Isan’andro dia fanombohana vaovao.", category: "Falifaly"),
    Quote(text: "Misafidiana ho be fanantenana.", category: "Falifaly"),
    Quote(text: "Mitsikia foana.", category: "Falifaly"),
    Quote(text: "Tsara kokoa ny fiainana rehefa mihomehy.", category: "Falifaly"),
    Quote(text: "Aza manahy, mifalia!", category: "Falifaly"),
    Quote(text: "Tiavo ny tenanao.", category: "Falifaly"),
    Quote(text: "Angony ny fotoana.", category: "Falifaly"),
    Quote(text: "Ataovy mahafinaritra ity andro ity.", category: "Falifaly"),

    // --- MALAHELO ---
    Quote(text: "Ny fotoan-tsarotra dia mitondra zavatra tsara.", category: "Malahelo"),
    Quote(text: "Ny hazo lehibe dia avy amin’ny voa kely.", category: "Malahelo"),
    Quote(text: "Mirotsaka ny orana satria mavesatra ny rahona.", category: "Malahelo"),
    Quote(text: "Tsy maninona raha tsy mety foana.", category: "Malahelo"),
    Quote(text: "Tsy mamirapiratra ny kintana raha tsy misy haizina.", category: "Malahelo"),
    Quote(text: "Handalo ihany izany.", category: "Malahelo"),
    Quote(text: "Mitaky fotoana ny fanasitranana.", category: "Malahelo"),
    Quote(text: "Ny fanaintainana dia mampatanjaka anao.", category: "Malahelo"),
    Quote(text: "Ny ranomaso dia teny tsy voateny.", category: "Malahelo"),
    Quote(text: "Mahery noho izay eritreretinao ianao.", category: "Malahelo"),
    Quote(text: "Andro iray isaky ny mandeha.", category: "Malahelo"),
    Quote(text: "Aorian’ny orana dia misy avana.", category: "Malahelo"),
    Quote(text: "Aza kivy.", category: "Malahelo"),
    Quote(text: "Ampy ianao.", category: "Malahelo"),
    Quote(text: "Hiposaka indray ny masoandro.", category: "Malahelo"),

    // --- MIFANTOKA ---
    Quote(text: "Mifantoha amin’ny tanjona.", category: "Mifantoka"),
    Quote(text: "Ny fanavaozana no mampiavaka ny mpitarika.", category: "Mifantoka"),
    Quote(text: "Aza mijanona raha tsy mirehareha.", category: "Mifantoka"),
    Quote(text: "Ny fifehezana dia fanaovana izay tokony hatao.", category: "Mifantoka"),
    Quote(text: "Mifantoha amin’ny vokatra.", category: "Mifantoka"),
    Quote(text: "Mamora ny ho avy amin’ny asanao.", category: "Mifantoka"),
    Quote(text: "Miasà mangina, avelao ny fahombiazana hiteny.", category: "Mifantoka"),
    Quote(text: "Ny fahombiazana dia ezaka mitohy.", category: "Mifantoka"),
    Quote(text: "Ny fitohizana no lakile.", category: "Mifantoka"),
    Quote(text: "Minoa fa afaka ianao.", category: "Mifantoka"),
    Quote(text: "Atombohy amin’izay misy anao.", category: "Mifantoka"),
    Quote(text: "Ny asa no fototry ny fahombiazana.", category: "Mifantoka"),
    Quote(text: "Ny kalitao dia fahazarana.", category: "Mifantoka"),
    Quote(text: "Hifehy ny fahaizanao.", category: "Mifantoka"),
    Quote(text: "Ny sainao ihany no fetra.", category: "Mifantoka"),
  ];

  static Future<void> savePersistentData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
        'user_quotes',
        jsonEncode(userQuotes.map((q) => q.toJson()).toList()));

    List<String> favList =
        allQuotes.where((q) => q.isFavorite).map((q) => q.text).toList();

    await prefs.setStringList('fav_quotes', favList);

    Map<String, dynamic> eventsJson = {};
    events.forEach((key, value) {
      eventsJson[key.toIso8601String()] =
          value.map((e) => e.toJson()).toList();
    });

    await prefs.setString('app_events', jsonEncode(eventsJson));
  }

  static Future<void> loadPersistentData() async {
    final prefs = await SharedPreferences.getInstance();

    String? userJson = prefs.getString('user_quotes');
    if (userJson != null) {
      Iterable l = jsonDecode(userJson);
      userQuotes =
          List<Quote>.from(l.map((model) => Quote.fromJson(model)));
    }

    List<String>? favTexts = prefs.getStringList('fav_quotes');
    if (favTexts != null) {
      for (var quote in allQuotes) {
        if (favTexts.contains(quote.text)) {
          quote.isFavorite = true;
        }
      }
    }

    String? eventsJsonStr = prefs.getString('app_events');
    if (eventsJsonStr != null) {
      Map<String, dynamic> decoded = jsonDecode(eventsJsonStr);
      events = decoded.map((key, value) {
        return MapEntry(
          DateTime.parse(key),
          (value as List)
              .map((e) => AppEvent.fromJson(e))
              .toList(),
        );
      });
    }
  }

  static Quote getQuoteOfTheDay() {
    int dayOfYear = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;

    return allQuotes[dayOfYear % allQuotes.length];
  }
}