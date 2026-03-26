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
    required this.reminder
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
    // --- HAPPY (40) ---
    Quote(text: "Happiness is not by chance, but by choice.", category: "Happy"),
    Quote(text: "The most important thing is to enjoy your life.", category: "Happy"),
    Quote(text: "Keep your face to the sunshine and you cannot see a shadow.", category: "Happy"),
    Quote(text: "The purpose of our lives is to be happy.", category: "Happy"),
    Quote(text: "Be happy for this moment. This moment is your life.", category: "Happy"),
    Quote(text: "Spread love everywhere you go.", category: "Happy"),
    Quote(text: "Stay close to anything that makes you glad you are alive.", category: "Happy"),
    Quote(text: "Happiness is a warm puppy.", category: "Happy"),
    Quote(text: "Every day is a new beginning.", category: "Happy"),
    Quote(text: "Choose to be optimistic, it feels better.", category: "Happy"),
    Quote(text: "Smile, it’s free therapy.", category: "Happy"),
    Quote(text: "Life is better when you’re laughing.", category: "Happy"),
    Quote(text: "Don't worry, be happy!", category: "Happy"),
    Quote(text: "Happiness is an inside job.", category: "Happy"),
    Quote(text: "The only thing that will make you happy is being happy with who you are.", category: "Happy"),
    Quote(text: "Think of all the beauty still left around you and be happy.", category: "Happy"),
    Quote(text: "Gratitude turns what we have into enough.", category: "Happy"),
    Quote(text: "A joyful heart is good medicine.", category: "Happy"),
    Quote(text: "Happiness is when what you think and do are in harmony.", category: "Happy"),
    Quote(text: "Find joy in the ordinary.", category: "Happy"),
    Quote(text: "Do more of what makes you happy.", category: "Happy"),
    Quote(text: "The secret of happiness is freedom.", category: "Happy"),
    Quote(text: "Love yourself first.", category: "Happy"),
    Quote(text: "Collect moments, not things.", category: "Happy"),
    Quote(text: "Life is a journey, enjoy the ride.", category: "Happy"),
    Quote(text: "Radiate positive vibes.", category: "Happy"),
    Quote(text: "Good things are coming.", category: "Happy"),
    Quote(text: "Your vibe attracts your tribe.", category: "Happy"),
    Quote(text: "Live, laugh, love.", category: "Happy"),
    Quote(text: "Make today amazing.", category: "Happy"),
    Quote(text: "Dream big, pray more.", category: "Happy"),
    Quote(text: "Focus on the good.", category: "Happy"),
    Quote(text: "Sparkle every day.", category: "Happy"),
    Quote(text: "Kindness is magic.", category: "Happy"),
    Quote(text: "Today is a gift.", category: "Happy"),
    Quote(text: "Believe in magic.", category: "Happy"),
    Quote(text: "Stay humble, work hard.", category: "Happy"),
    Quote(text: "Peace begins with a smile.", category: "Happy"),
    Quote(text: "Be the reason someone smiles today.", category: "Happy"),
    Quote(text: "Keep going, keep growing.", category: "Happy"),

    // --- SAD / ENCOURAGEMENT (30) ---
    Quote(text: "Hard times always lead to something great.", category: "Sad"),
    Quote(text: "Every tall tree was once a small seed.", category: "Sad"),
    Quote(text: "Rain falls because the clouds can no longer handle the weight.", category: "Sad"),
    Quote(text: "It's okay not to be okay.", category: "Sad"),
    Quote(text: "Stars can't shine without darkness.", category: "Sad"),
    Quote(text: "This too shall pass.", category: "Sad"),
    Quote(text: "Healing takes time.", category: "Sad"),
    Quote(text: "Pain makes you stronger.", category: "Sad"),
    Quote(text: "Tears are words the heart can't express.", category: "Sad"),
    Quote(text: "Don't be ashamed of your scars.", category: "Sad"),
    Quote(text: "Even the darkest night will end.", category: "Sad"),
    Quote(text: "Growth is painful. Change is painful.", category: "Sad"),
    Quote(text: "Broken crayons still color.", category: "Sad"),
    Quote(text: "You are stronger than you think.", category: "Sad"),
    Quote(text: "One day at a time.", category: "Sad"),
    Quote(text: "Deep breaths are love notes to your body.", category: "Sad"),
    Quote(text: "Your feelings are valid.", category: "Sad"),
    Quote(text: "Storms don't last forever.", category: "Sad"),
    Quote(text: "After the rain, comes the rainbow.", category: "Sad"),
    Quote(text: "Let it hurt, then let it go.", category: "Sad"),
    Quote(text: "Small steps are still progress.", category: "Sad"),
    Quote(text: "It's just a bad day, not a bad life.", category: "Sad"),
    Quote(text: "Quiet the mind and the soul will speak.", category: "Sad"),
    Quote(text: "The sun will rise again.", category: "Sad"),
    Quote(text: "You are enough.", category: "Sad"),
    Quote(text: "Be gentle with yourself.", category: "Sad"),
    Quote(text: "Courage doesn't always roar.", category: "Sad"),
    Quote(text: "Sometimes you win, sometimes you learn.", category: "Sad"),
    Quote(text: "Light will find you.", category: "Sad"),
    Quote(text: "Hope is a waking dream.", category: "Sad"),

    // --- FOCUS / INNOVATION (30) ---
    Quote(text: "Stay focused on the goal.", category: "Focus"),
    Quote(text: "Innovation distinguishes between a leader and a follower.", category: "Focus"),
    Quote(text: "Code is like humor. If you explain it, it's bad.", category: "Focus"),
    Quote(text: "Fix the cause, not the symptom.", category: "Focus"),
    Quote(text: "Don't stop until you're proud.", category: "Focus"),
    Quote(text: "Discipline is doing what needs to be done.", category: "Focus"),
    Quote(text: "Focus on being productive instead of busy.", category: "Focus"),
    Quote(text: "The best way to predict the future is to create it.", category: "Focus"),
    Quote(text: "Work hard in silence, let success be your noise.", category: "Focus"),
    Quote(text: "Success is the sum of small efforts.", category: "Focus"),
    Quote(text: "Stay hungry, stay foolish.", category: "Focus"),
    Quote(text: "Execution is everything.", category: "Focus"),
    Quote(text: "Simplicity is the soul of efficiency.", category: "Focus"),
    Quote(text: "Done is better than perfect.", category: "Focus"),
    Quote(text: "First, solve the problem. Then, write the code.", category: "Focus"),
    Quote(text: "Consistency is key.", category: "Focus"),
    Quote(text: "Great things take time.", category: "Focus"),
    Quote(text: "Keep your eyes on the prize.", category: "Focus"),
    Quote(text: "Believe you can and you're halfway there.", category: "Focus"),
    Quote(text: "Make it work, make it right, make it fast.", category: "Focus"),
    Quote(text: "Start where you are. Use what you have.", category: "Focus"),
    Quote(text: "Don't watch the clock; do what it does.", category: "Focus"),
    Quote(text: "Action is the foundational key to success.", category: "Focus"),
    Quote(text: "Quality is not an act, it is a habit.", category: "Focus"),
    Quote(text: "Focus 100% on the task at hand.", category: "Focus"),
    Quote(text: "The expert in anything was once a beginner.", category: "Focus"),
    Quote(text: "Logic will get you from A to B.", category: "Focus"),
    Quote(text: "Your mind is a weapon. Keep it loaded.", category: "Focus"),
    Quote(text: "Master your craft.", category: "Focus"),
    Quote(text: "The only limit is your mind.", category: "Focus"),
  ];

  static Future<void> savePersistentData() async {
    final prefs = await SharedPreferences.getInstance();
    // Save Quotes
    await prefs.setString('user_quotes', jsonEncode(userQuotes.map((q) => q.toJson()).toList()));
    List<String> favList = allQuotes.where((q) => q.isFavorite).map((q) => q.text).toList();
    await prefs.setStringList('fav_quotes', favList);

    // Save Agenda Events
    Map<String, dynamic> eventsJson = {};
    events.forEach((key, value) {
      eventsJson[key.toIso8601String()] = value.map((e) => e.toJson()).toList();
    });
    await prefs.setString('app_events', jsonEncode(eventsJson));
  }

  static Future<void> loadPersistentData() async {
    final prefs = await SharedPreferences.getInstance();
    // Load User Quotes
    String? userJson = prefs.getString('user_quotes');
    if (userJson != null) {
      Iterable l = jsonDecode(userJson);
      userQuotes = List<Quote>.from(l.map((model) => Quote.fromJson(model)));
    }
    // Load Favorites
    List<String>? favTexts = prefs.getStringList('fav_quotes');
    if (favTexts != null) {
      for (var quote in allQuotes) {
        if (favTexts.contains(quote.text)) quote.isFavorite = true;
      }
    }
    // Load Agenda Events
    String? eventsJsonStr = prefs.getString('app_events');
    if (eventsJsonStr != null) {
      Map<String, dynamic> decoded = jsonDecode(eventsJsonStr);
      events = decoded.map((key, value) {
        return MapEntry(
          DateTime.parse(key),
          (value as List).map((e) => AppEvent.fromJson(e)).toList(),
        );
      });
    }
  }

  static Quote getQuoteOfTheDay() {
    int dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    return allQuotes[dayOfYear % allQuotes.length];
  }
}