import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/quotes_data.dart';
import '../widgets/glass_container.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  late Quote dailyQuote;

  @override
  void initState() {
    super.initState();
    dailyQuote = QuotesData.getQuoteOfTheDay();
    QuotesData.loadPersistentData().then((_) => setState(() {}));
  }

  void _addNewQuote(String text, String category) {
    setState(() {
      QuotesData.userQuotes.add(Quote(text: text, category: category, isUserCreated: true));
    });
    QuotesData.savePersistentData();
  }

  @override
  Widget build(BuildContext context) {
    List<Quote> favorites = QuotesData.allQuotes.where((q) => q.isFavorite).toList();
    List<Quote> happyQuotes = QuotesData.allQuotes.where((q) => q.category == "Happy").toList();
    List<Quote> sadQuotes = QuotesData.allQuotes.where((q) => q.category == "Sad").toList();
    List<Quote> focusQuotes = QuotesData.allQuotes.where((q) => q.category == "Focus").toList();

    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        // LOGO ADDED HERE
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/ispm_logo.png', fit: BoxFit.contain),
        ),
        title: const Text("Daily Inspiration", style: AppStyles.heading),
        actions: [
          IconButton(
            onPressed: () => _showCreateQuoteSheet(context),
            icon: const Icon(Icons.add_circle_outline, color: AppColors.accentPurple),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            _sectionHeader("Quote of the Day", onMore: null),
            Center(child: _buildDailyQuoteCard(dailyQuote)),
            const SizedBox(height: 30),

            _sectionHeader("Favorite Quotes", onMore: null),
            _horizontalQuoteList(favorites),
            const SizedBox(height: 25),

            _sectionHeader("Your Creations", onMore: null),
            _horizontalQuoteList(QuotesData.userQuotes),
            const SizedBox(height: 25),

            _sectionHeader("Situations", onMore: null),
            _situationCategory("Happy 😊", happyQuotes),
            _situationCategory("Sad 😞", sadQuotes),
            _situationCategory("Focus 🎯", focusQuotes),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, {VoidCallback? onMore}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyles.cardTitle),
          if (onMore != null)
            GestureDetector(
              onTap: onMore,
              child: const Text("See all", style: TextStyle(color: AppColors.accentPurple, fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget _buildDailyQuoteCard(Quote quote) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 350), 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/motivation_bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: GlassContainer(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Icon(Icons.format_quote_rounded, color: Colors.white70, size: 30),
            const SizedBox(height: 10),
            Text(
              "\"${quote.text}\"",
              textAlign: TextAlign.center,
              style: AppStyles.subHeading.copyWith(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic, 
                color: Colors.white,
                shadows: [const Shadow(offset: Offset(1, 1), blurRadius: 4, color: Colors.black)],
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  quote.isFavorite ? Icons.favorite : Icons.favorite_border, 
                  color: quote.isFavorite ? Colors.redAccent : Colors.white,
                ),
                onPressed: () {
                  setState(() => quote.isFavorite = !quote.isFavorite);
                  QuotesData.savePersistentData();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _horizontalQuoteList(List<Quote> quotes) {
    if (quotes.isEmpty) return const Text("Nothing here yet.", style: TextStyle(color: Colors.white24, fontSize: 12));
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return Container(
            width: 220,
            margin: const EdgeInsets.only(right: 15),
            child: GlassContainer(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Text(
                  quotes[index].text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, color: Colors.white70, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _situationCategory(String label, List<Quote> categoryQuotes) {
    return ExpansionTile(
      iconColor: AppColors.accentPurple,
      collapsedIconColor: Colors.white38,
      title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      children: categoryQuotes.map((q) => ListTile(
        title: Text(q.text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        trailing: IconButton(
          icon: Icon(q.isFavorite ? Icons.favorite : Icons.favorite_border, size: 16, color: q.isFavorite ? Colors.redAccent : Colors.white24),
          onPressed: () {
            setState(() => q.isFavorite = !q.isFavorite);
            QuotesData.savePersistentData();
          },
        ),
      )).toList(),
    );
  }

  void _showCreateQuoteSheet(BuildContext context) {
    String text = "";
    String selectedCategory = "Happy";
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161922),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 20, right: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("New Creation", style: AppStyles.cardTitle),
              const SizedBox(height: 15),
              TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Write your inspiration...",
                  hintStyle: const TextStyle(color: Colors.white24),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                ),
                onChanged: (v) => text = v,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["Happy", "Sad", "Focus"].map((cat) => ChoiceChip(
                  label: Text(cat),
                  selected: selectedCategory == cat,
                  onSelected: (val) => setSheetState(() => selectedCategory = cat),
                  selectedColor: AppColors.accentPurple,
                )).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    if (text.isNotEmpty) _addNewQuote(text, selectedCategory);
                    Navigator.pop(context);
                  },
                  child: const Text("Save Quote", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}