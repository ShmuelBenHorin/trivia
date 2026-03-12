import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ═══════════════════════════════════════════════════════════════
//  ENTRY POINT
// ═══════════════════════════════════════════════════════════════
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const TriviaApp());
}

// ═══════════════════════════════════════════════════════════════
//  APP ROOT
// ═══════════════════════════════════════════════════════════════
class TriviaApp extends StatelessWidget {
  const TriviaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Master',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Palette.bg,
        colorScheme: const ColorScheme.dark(primary: Palette.gold),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  PALETTE
// ═══════════════════════════════════════════════════════════════
class Palette {
  static const bg = Color(0xFF0D0D1A);
  static const surface = Color(0xFF16162A);
  static const card = Color(0xFF1E1E36);
  static const gold = Color(0xFFFFD700);
  static const silver = Color(0xFFC0C0D0);
  static const accent = Color(0xFF7C6FE0);
  static const green = Color(0xFF2ECC71);
  static const red = Color(0xFFE74C3C);
  static const textPrimary = Color(0xFFF0F0FF);
  static const textSecondary = Color(0xFF8888AA);

  static const catColors = {
    'history':    Color(0xFFE67E22),
    'science':    Color(0xFF3498DB),
    'geography':  Color(0xFF2ECC71),
    'arts':       Color(0xFFE91E8C),
    'sports':     Color(0xFFE74C3C),
    'pop':        Color(0xFF9B59B6),
    'tech':       Color(0xFF1ABC9C),
    'literature': Color(0xFFF39C12),
  };

  static Color cat(String c) => catColors[c] ?? accent;

  static const catEmojis = {
    'history':    '🏛️',
    'science':    '🔬',
    'geography':  '🌍',
    'arts':       '🎭',
    'sports':     '⚽',
    'pop':        '🎬',
    'tech':       '💻',
    'literature': '📚',
  };

  static String emoji(String c) => catEmojis[c] ?? '❓';

  static const diffColors = {
    1: Color(0xFF2ECC71),
    2: Color(0xFFF39C12),
    3: Color(0xFFE74C3C),
  };
  static Color diff(int d) => diffColors[d] ?? green;

  static const diffLabels = {1: 'Easy', 2: 'Medium', 3: 'Hard'};
  static String diffLabel(int d) => diffLabels[d] ?? 'Medium';
}

// ═══════════════════════════════════════════════════════════════
//  DATA MODEL
// ═══════════════════════════════════════════════════════════════
class Question {
  final String id;
  final String category;
  final String questionText;
  final List<String> answers;
  final int correctIndex;
  final int difficulty; // 1=easy 2=medium 3=hard
  final String? fact;   // fun fact shown after answer

  const Question({
    required this.id,
    required this.category,
    required this.questionText,
    required this.answers,
    required this.correctIndex,
    this.difficulty = 1,
    this.fact,
  });

  factory Question.fromMap(Map<String, dynamic> m) => Question(
        id: m['id'] as String,
        category: m['category'] as String,
        questionText: m['q'] as String,
        answers: List<String>.from(m['a'] as List),
        correctIndex: m['c'] as int,
        difficulty: (m['d'] as int?) ?? 1,
        fact: m['f'] as String?,
      );

  int get points => difficulty * 10;
}

// ═══════════════════════════════════════════════════════════════
//  QUESTION DATABASE  (130+ questions)
// ═══════════════════════════════════════════════════════════════
const String kJson = r'''
[
  {"id":"h01","category":"history","d":1,"q":"Who was the first President of the United States?","a":["George Washington","Thomas Jefferson","Abraham Lincoln","Benjamin Franklin"],"c":0,"f":"Washington served two terms from 1789 to 1797."},
  {"id":"h02","category":"history","d":1,"q":"In which year did World War II end?","a":["1943","1944","1945","1946"],"c":2,"f":"VE Day was May 8 and VJ Day was August 15, 1945."},
  {"id":"h03","category":"history","d":1,"q":"Which ancient wonder was located in Alexandria?","a":["Colossus of Rhodes","Temple of Artemis","Lighthouse of Alexandria","Hanging Gardens"],"c":2,"f":"It stood ~137 m tall — one of the tallest structures of the ancient world."},
  {"id":"h04","category":"history","d":2,"q":"The Berlin Wall fell in which year?","a":["1987","1989","1991","1993"],"c":1,"f":"November 9, 1989 marked the opening of the wall after 28 years."},
  {"id":"h05","category":"history","d":2,"q":"Which empire was ruled by Genghis Khan?","a":["Ottoman","Roman","Mongol","Persian"],"c":2,"f":"At its peak the Mongol Empire was the largest contiguous land empire in history."},
  {"id":"h06","category":"history","d":2,"q":"Napoleon Bonaparte was exiled to which island?","a":["Corsica","Elba","Saint Helena","Sardinia"],"c":2,"f":"He was exiled to Saint Helena in 1815 after Waterloo and died there in 1821."},
  {"id":"h07","category":"history","d":1,"q":"Who painted the Sistine Chapel ceiling?","a":["Leonardo da Vinci","Raphael","Michelangelo","Donatello"],"c":2,"f":"Michelangelo painted it between 1508 and 1512, lying on his back on scaffolding."},
  {"id":"h08","category":"history","d":2,"q":"The Magna Carta was signed in which year?","a":["1066","1215","1348","1492"],"c":1,"f":"King John signed it at Runnymede in 1215, limiting royal power."},
  {"id":"h09","category":"history","d":3,"q":"Which country was the first to grant women the right to vote?","a":["USA","UK","New Zealand","Australia"],"c":2,"f":"New Zealand granted women the vote in 1893."},
  {"id":"h10","category":"history","d":3,"q":"The 'War of Jenkin's Ear' was fought between Britain and which country?","a":["France","Spain","Portugal","Netherlands"],"c":1,"f":"It began in 1739 after Spanish coast guards cut off a British captain's ear."},
  {"id":"h11","category":"history","d":2,"q":"Julius Caesar was assassinated on the Ides of which month?","a":["February","March","April","June"],"c":1,"f":"He was stabbed 23 times on March 15, 44 BC."},
  {"id":"h12","category":"history","d":1,"q":"Which country did Germany invade to start World War II?","a":["France","Russia","Poland","Belgium"],"c":2,"f":"Germany invaded Poland on September 1, 1939."},
  {"id":"h13","category":"history","d":3,"q":"Which pharaoh built the Great Pyramid of Giza?","a":["Ramesses II","Tutankhamun","Khufu","Akhenaten"],"c":2,"f":"Khufu's pyramid was built around 2560 BC and stands 138.5 m today."},
  {"id":"h14","category":"history","d":2,"q":"The Cold War was primarily between the USA and which country?","a":["China","Germany","USSR","Cuba"],"c":2,"f":"The Cold War lasted from 1947 to 1991, ending with the dissolution of the USSR."},
  {"id":"h15","category":"history","d":1,"q":"Who was the first man to walk on the Moon?","a":["Buzz Aldrin","Yuri Gagarin","Neil Armstrong","John Glenn"],"c":2,"f":"Armstrong stepped onto the lunar surface on July 21, 1969."},

  {"id":"s01","category":"science","d":1,"q":"What is the chemical symbol for gold?","a":["Go","Gd","Au","Ag"],"c":2,"f":"Au comes from the Latin word 'aurum'."},
  {"id":"s02","category":"science","d":1,"q":"How many bones are in the adult human body?","a":["196","206","216","226"],"c":1,"f":"Babies have around 270 bones that fuse as they grow."},
  {"id":"s03","category":"science","d":1,"q":"What planet is known as the Red Planet?","a":["Venus","Jupiter","Mars","Saturn"],"c":2,"f":"Mars gets its reddish color from iron oxide (rust) on its surface."},
  {"id":"s04","category":"science","d":2,"q":"What is the speed of light in a vacuum (approx)?","a":["150,000 km/s","300,000 km/s","450,000 km/s","600,000 km/s"],"c":1,"f":"299,792,458 m/s — nothing in the universe can exceed this speed."},
  {"id":"s05","category":"science","d":2,"q":"DNA stands for what?","a":["Deoxyribonucleic Acid","Diribonucleic Acid","Deoxyribose Nucleic Agent","Dense Nuclear Acid"],"c":0,"f":"Watson and Crick described the double helix structure in 1953."},
  {"id":"s06","category":"science","d":2,"q":"Which element has atomic number 1?","a":["Helium","Oxygen","Hydrogen","Carbon"],"c":2,"f":"Hydrogen is the lightest and most abundant element in the universe."},
  {"id":"s07","category":"science","d":3,"q":"What is the powerhouse of the cell?","a":["Nucleus","Ribosome","Mitochondria","Golgi Apparatus"],"c":2,"f":"Mitochondria produce ATP through cellular respiration."},
  {"id":"s08","category":"science","d":3,"q":"Which scientist formulated the theory of general relativity?","a":["Isaac Newton","Niels Bohr","Albert Einstein","Max Planck"],"c":2,"f":"Einstein published general relativity in 1915."},
  {"id":"s09","category":"science","d":2,"q":"What is the most abundant gas in Earth's atmosphere?","a":["Oxygen","Carbon Dioxide","Nitrogen","Argon"],"c":2,"f":"Nitrogen makes up about 78% of Earth's atmosphere."},
  {"id":"s10","category":"science","d":1,"q":"How many planets are in our solar system?","a":["7","8","9","10"],"c":1,"f":"Pluto was reclassified as a dwarf planet in 2006, leaving 8 planets."},
  {"id":"s11","category":"science","d":3,"q":"What is the half-life of Carbon-14?","a":["1,730 years","5,730 years","10,000 years","57,300 years"],"c":1,"f":"This makes C-14 useful for dating organic material up to ~50,000 years old."},
  {"id":"s12","category":"science","d":2,"q":"Which organ produces insulin in the human body?","a":["Liver","Kidney","Pancreas","Spleen"],"c":2,"f":"The islets of Langerhans in the pancreas produce insulin and glucagon."},
  {"id":"s13","category":"science","d":1,"q":"What force keeps planets in orbit around the Sun?","a":["Magnetism","Nuclear force","Gravity","Friction"],"c":2,"f":"Gravity was described by Newton's law of universal gravitation in 1687."},
  {"id":"s14","category":"science","d":3,"q":"What is the Schrödinger's cat thought experiment about?","a":["Animal behaviour","Quantum superposition","Relativity","Black holes"],"c":1,"f":"It illustrates the problem of applying quantum superposition to macroscopic objects."},
  {"id":"s15","category":"science","d":2,"q":"Which vitamin is produced when skin is exposed to sunlight?","a":["Vitamin A","Vitamin C","Vitamin D","Vitamin K"],"c":2,"f":"UVB radiation triggers Vitamin D3 synthesis in the skin."},

  {"id":"g01","category":"geography","d":1,"q":"What is the capital of Australia?","a":["Sydney","Melbourne","Brisbane","Canberra"],"c":3,"f":"Canberra was purpose-built as the capital as a compromise between Sydney and Melbourne."},
  {"id":"g02","category":"geography","d":1,"q":"Which is the longest river in the world?","a":["Amazon","Congo","Nile","Yangtze"],"c":2,"f":"The Nile stretches approximately 6,650 km through northeastern Africa."},
  {"id":"g03","category":"geography","d":1,"q":"Which country has the largest land area?","a":["Canada","USA","China","Russia"],"c":3,"f":"Russia spans 17.1 million km² — about 11% of the world's land area."},
  {"id":"g04","category":"geography","d":2,"q":"The Amazon rainforest is primarily in which country?","a":["Colombia","Peru","Venezuela","Brazil"],"c":3,"f":"Brazil contains about 60% of the Amazon rainforest."},
  {"id":"g05","category":"geography","d":2,"q":"What is the smallest country in the world by area?","a":["Monaco","San Marino","Liechtenstein","Vatican City"],"c":3,"f":"Vatican City covers just 0.44 km² inside Rome."},
  {"id":"g06","category":"geography","d":2,"q":"Which mountain is the tallest in the world?","a":["K2","Kangchenjunga","Mount Everest","Lhotse"],"c":2,"f":"Everest stands 8,848.86 m above sea level."},
  {"id":"g07","category":"geography","d":1,"q":"What is the capital of Japan?","a":["Osaka","Kyoto","Hiroshima","Tokyo"],"c":3,"f":"Tokyo is the world's most populous metropolitan area with ~37 million people."},
  {"id":"g08","category":"geography","d":3,"q":"Lake Baikal in Russia holds what percentage of Earth's surface fresh water?","a":["10%","20%","30%","40%"],"c":1,"f":"Baikal holds 20% of all unfrozen surface fresh water and is the world's deepest lake."},
  {"id":"g09","category":"geography","d":2,"q":"Which desert is the largest in the world?","a":["Sahara","Arabian","Gobi","Antarctic"],"c":3,"f":"Antarctica is technically a polar desert at 14.2 million km²."},
  {"id":"g10","category":"geography","d":1,"q":"How many continents are there on Earth?","a":["5","6","7","8"],"c":2,"f":"The 7 continents are Africa, Antarctica, Asia, Australia, Europe, North & South America."},
  {"id":"g11","category":"geography","d":3,"q":"Which country has the most time zones?","a":["Russia","USA","China","France"],"c":3,"f":"France has 12 time zones due to its overseas territories."},
  {"id":"g12","category":"geography","d":2,"q":"The Great Barrier Reef is located off the coast of which country?","a":["New Zealand","Indonesia","Australia","Philippines"],"c":2,"f":"It is the world's largest coral reef system at over 2,300 km long."},

  {"id":"a01","category":"arts","d":1,"q":"Who painted the 'Starry Night'?","a":["Pablo Picasso","Claude Monet","Vincent van Gogh","Salvador Dali"],"c":2,"f":"Van Gogh painted it in June 1889 while at an asylum in Saint-Rémy-de-Provence."},
  {"id":"a02","category":"arts","d":1,"q":"Who composed the 'Fifth Symphony'?","a":["Mozart","Bach","Beethoven","Handel"],"c":2,"f":"Beethoven composed his 5th Symphony between 1804 and 1808."},
  {"id":"a03","category":"arts","d":2,"q":"Which art movement is Salvador Dalí associated with?","a":["Cubism","Surrealism","Impressionism","Dadaism"],"c":1,"f":"Dalí joined the Surrealist movement in the late 1920s."},
  {"id":"a04","category":"arts","d":2,"q":"'The Persistence of Memory' features melting what?","a":["Clocks","Candles","Ice cream","Phones"],"c":0,"f":"Dalí said the melting watches were inspired by melting Camembert cheese."},
  {"id":"a05","category":"arts","d":1,"q":"The Louvre museum is located in which city?","a":["Rome","London","Paris","Madrid"],"c":2,"f":"The Louvre is the world's most visited art museum with ~9 million visitors/year."},
  {"id":"a06","category":"arts","d":3,"q":"Who sculpted 'The Thinker'?","a":["Michelangelo","Bernini","Rodin","Brancusi"],"c":2,"f":"Auguste Rodin created The Thinker in 1880 as part of 'The Gates of Hell'."},
  {"id":"a07","category":"arts","d":2,"q":"Which opera features the aria 'Nessun Dorma'?","a":["La Traviata","Madama Butterfly","Turandot","Rigoletto"],"c":2,"f":"Turandot was Puccini's final, unfinished opera, completed by Alfano in 1926."},
  {"id":"a08","category":"arts","d":1,"q":"Who wrote the play 'Hamlet'?","a":["Charles Dickens","William Shakespeare","Oscar Wilde","George Bernard Shaw"],"c":1,"f":"Hamlet was written around 1600–1601 and is Shakespeare's longest play."},
  {"id":"a09","category":"arts","d":3,"q":"What style of art is characterised by geometric shapes and multiple perspectives?","a":["Fauvism","Cubism","Expressionism","Art Nouveau"],"c":1,"f":"Cubism was pioneered by Picasso and Georges Braque around 1907–1914."},
  {"id":"a10","category":"arts","d":2,"q":"The famous painting 'Girl with a Pearl Earring' was painted by?","a":["Rembrandt","Vermeer","Rubens","Hals"],"c":1,"f":"Johannes Vermeer painted it around 1665. The subject's identity remains unknown."},
  {"id":"a11","category":"arts","d":1,"q":"Which instrument has 88 keys?","a":["Organ","Harpsichord","Piano","Accordion"],"c":2,"f":"A standard piano has 52 white and 36 black keys spanning 7 octaves."},

  {"id":"sp01","category":"sports","d":1,"q":"How many players are on a standard football (soccer) team?","a":["9","10","11","12"],"c":2,"f":"Each team fields 11 players including the goalkeeper."},
  {"id":"sp02","category":"sports","d":1,"q":"In which country did the Olympic Games originate?","a":["Italy","Egypt","Greece","Turkey"],"c":2,"f":"The ancient Olympics were held at Olympia, Greece, from 776 BC."},
  {"id":"sp03","category":"sports","d":2,"q":"How often is the FIFA World Cup held?","a":["Every 2 years","Every 3 years","Every 4 years","Every 5 years"],"c":2,"f":"The World Cup has been held every 4 years since 1930 (except 1942 and 1946)."},
  {"id":"sp04","category":"sports","d":2,"q":"In tennis, what is the score after deuce if one player wins a point?","a":["Set point","Match point","Advantage","Game"],"c":2,"f":"The player must win two consecutive points after deuce to win the game."},
  {"id":"sp05","category":"sports","d":1,"q":"How many rings are on the Olympic flag?","a":["4","5","6","7"],"c":1,"f":"The 5 rings represent the 5 continents of the world united by the Olympic movement."},
  {"id":"sp06","category":"sports","d":3,"q":"In which year were women first allowed to compete in the modern Olympics?","a":["1896","1900","1912","1924"],"c":1,"f":"Women competed in 5 events at the 1900 Paris Games — tennis, sailing, croquet, equestrianism and golf."},
  {"id":"sp07","category":"sports","d":2,"q":"A 'hat trick' in football means scoring how many goals?","a":["2","3","4","5"],"c":1,"f":"The term originates from cricket, where a bowler who took 3 wickets received a new hat."},
  {"id":"sp08","category":"sports","d":1,"q":"Michael Jordan played for which NBA team for most of his career?","a":["LA Lakers","Boston Celtics","Chicago Bulls","Miami Heat"],"c":2,"f":"Jordan won 6 NBA championships with the Bulls in 1991–93 and 1996–98."},
  {"id":"sp09","category":"sports","d":3,"q":"Which country has won the most Rugby World Cups?","a":["England","South Africa","New Zealand","Australia"],"c":2,"f":"New Zealand (All Blacks) have won 3 times: 1987, 2011 and 2015."},
  {"id":"sp10","category":"sports","d":2,"q":"In which sport would you perform a 'slam dunk'?","a":["Volleyball","Basketball","Handball","Water Polo"],"c":1,"f":"The dunk was popularised by Wilt Chamberlain in the 1960s."},
  {"id":"sp11","category":"sports","d":2,"q":"How many Grand Slam tournaments are there in tennis?","a":["2","3","4","5"],"c":2,"f":"Australian Open, French Open, Wimbledon and US Open make up the four Grand Slams."},
  {"id":"sp12","category":"sports","d":1,"q":"Which country hosted the 2016 Summer Olympics?","a":["China","USA","Brazil","UK"],"c":2,"f":"The 2016 Olympics were held in Rio de Janeiro — the first in South America."},

  {"id":"p01","category":"pop","d":1,"q":"Which band performed 'Bohemian Rhapsody'?","a":["The Beatles","Led Zeppelin","Queen","The Rolling Stones"],"c":2,"f":"Bohemian Rhapsody was released in 1975 and lasted nearly 6 minutes — unusual for pop radio."},
  {"id":"p02","category":"pop","d":1,"q":"Who played Iron Man in the Marvel Cinematic Universe?","a":["Chris Evans","Robert Downey Jr.","Chris Hemsworth","Mark Ruffalo"],"c":1,"f":"RDJ debuted as Tony Stark in 'Iron Man' (2008) and appeared in 10 MCU films."},
  {"id":"p03","category":"pop","d":2,"q":"Which TV series features dragons, the Iron Throne, and Westeros?","a":["The Witcher","Vikings","Game of Thrones","House of Cards"],"c":2,"f":"Game of Thrones aired on HBO from 2011 to 2019, based on George R.R. Martin's novels."},
  {"id":"p04","category":"pop","d":1,"q":"'Friends' is set primarily in which US city?","a":["Los Angeles","Chicago","Boston","New York City"],"c":3,"f":"The gang hung out at Central Perk coffee shop and Monica's apartment in Greenwich Village."},
  {"id":"p05","category":"pop","d":2,"q":"Which singer is known as the 'Queen of Pop'?","a":["Beyoncé","Lady Gaga","Madonna","Britney Spears"],"c":2,"f":"Madonna has sold over 300 million records worldwide, the best-selling female artist of all time."},
  {"id":"p06","category":"pop","d":1,"q":"What is the highest-grossing film of all time (unadjusted)?","a":["Titanic","Avengers: Endgame","Avatar","The Lion King"],"c":2,"f":"James Cameron's Avatar (2009, re-releases) holds the record at ~$2.9 billion."},
  {"id":"p07","category":"pop","d":2,"q":"In 'Breaking Bad', what is Walter White's chemistry teacher alias?","a":["El Chapo","Heisenberg","Scarface","The Cook"],"c":1,"f":"The alias references Werner Heisenberg, a German physicist known for the uncertainty principle."},
  {"id":"p08","category":"pop","d":3,"q":"Which album is the best-selling of all time?","a":["Thriller","Back in Black","The Dark Side of the Moon","Hotel California"],"c":0,"f":"Michael Jackson's Thriller has sold an estimated 66–70 million copies worldwide."},
  {"id":"p09","category":"pop","d":2,"q":"Who wrote the Harry Potter series?","a":["Suzanne Collins","Stephanie Meyer","J.K. Rowling","Philip Pullman"],"c":2,"f":"Rowling wrote the first book in Edinburgh cafés while a single mother on welfare."},
  {"id":"p10","category":"pop","d":1,"q":"Which social media platform uses a blue bird as its logo (now changed)?","a":["Instagram","Facebook","Twitter","Snapchat"],"c":2,"f":"The Twitter bird logo, named 'Larry', was replaced by an 'X' in 2023 by Elon Musk."},
  {"id":"p11","category":"pop","d":3,"q":"The character 'Darth Vader' breathes with an iconic sound designed by?","a":["John Williams","George Lucas","Ben Burtt","Marcia Lucas"],"c":2,"f":"Ben Burtt created the sound by breathing through a modified Dacor scuba regulator."},
  {"id":"p12","category":"pop","d":2,"q":"Which TV show featured the fictional drug 'Blue Sky' methamphetamine?","a":["Narcos","Ozark","Breaking Bad","The Wire"],"c":2,"f":"Blue Sky had a fictional 99.1% purity — the blue colour was a plot device to distinguish it."},

  {"id":"t01","category":"tech","d":1,"q":"Who co-founded Apple Inc. with Steve Wozniak?","a":["Bill Gates","Steve Jobs","Jeff Bezos","Elon Musk"],"c":1,"f":"Jobs, Wozniak and Ronald Wayne founded Apple on April 1, 1976."},
  {"id":"t02","category":"tech","d":1,"q":"What does 'WWW' stand for in a web address?","a":["World Wide Web","World Wireless Web","Wide World Web","World Wide Wire"],"c":0,"f":"Tim Berners-Lee invented the World Wide Web in 1989 at CERN."},
  {"id":"t03","category":"tech","d":2,"q":"What programming language was created by Guido van Rossum?","a":["Java","Ruby","Python","Perl"],"c":2,"f":"Python was released in 1991, named after Monty Python, not the snake."},
  {"id":"t04","category":"tech","d":2,"q":"Which company developed the Android operating system?","a":["Apple","Microsoft","Google","Samsung"],"c":2,"f":"Google acquired Android Inc. in 2005 for $50 million."},
  {"id":"t05","category":"tech","d":1,"q":"What does 'CPU' stand for?","a":["Central Processing Unit","Computer Power Unit","Core Processing Utility","Central Program Unit"],"c":0,"f":"The CPU is often called the 'brain' of a computer."},
  {"id":"t06","category":"tech","d":3,"q":"In binary, what does '1010' equal in decimal?","a":["8","9","10","11"],"c":2,"f":"8+2=10. Binary: 1×8 + 0×4 + 1×2 + 0×1 = 10."},
  {"id":"t07","category":"tech","d":2,"q":"Which company created the first commercially successful smartphone?","a":["Nokia","BlackBerry","Apple","Motorola"],"c":2,"f":"The iPhone was unveiled by Steve Jobs on January 9, 2007."},
  {"id":"t08","category":"tech","d":3,"q":"What year was the first email sent?","a":["1965","1971","1978","1983"],"c":1,"f":"Ray Tomlinson sent the first networked email in 1971, also introducing the @ symbol."},
  {"id":"t09","category":"tech","d":2,"q":"What does 'AI' stand for?","a":["Automated Intelligence","Artificial Intelligence","Advanced Integration","Autonomous Internet"],"c":1,"f":"The term 'Artificial Intelligence' was coined by John McCarthy in 1956."},
  {"id":"t10","category":"tech","d":1,"q":"How many bits are in a byte?","a":["4","8","16","32"],"c":1,"f":"A byte is 8 bits. A kilobyte is 1,024 bytes."},
  {"id":"t11","category":"tech","d":3,"q":"What does 'HTTP' stand for?","a":["HyperText Transfer Protocol","High Traffic Transfer Protocol","HyperText Transmission Program","Host Transfer Text Protocol"],"c":0,"f":"HTTPS adds encryption (SSL/TLS) to the standard HTTP protocol."},
  {"id":"t12","category":"tech","d":2,"q":"Which company owns YouTube?","a":["Meta","Amazon","Microsoft","Google"],"c":3,"f":"Google acquired YouTube in October 2006 for $1.65 billion in stock."},

  {"id":"l01","category":"literature","d":1,"q":"Who wrote '1984'?","a":["Aldous Huxley","George Orwell","Ray Bradbury","Kurt Vonnegut"],"c":1,"f":"Orwell wrote 1984 in 1948 — reversing the year. It was published in 1949."},
  {"id":"l02","category":"literature","d":1,"q":"Who wrote 'Pride and Prejudice'?","a":["Charlotte Brontë","Mary Shelley","Jane Austen","Virginia Woolf"],"c":2,"f":"Jane Austen published Pride and Prejudice in 1813."},
  {"id":"l03","category":"literature","d":2,"q":"In which Dickens novel does the character Ebenezer Scrooge appear?","a":["Oliver Twist","Great Expectations","David Copperfield","A Christmas Carol"],"c":3,"f":"A Christmas Carol was written in just 6 weeks and published in December 1843."},
  {"id":"l04","category":"literature","d":2,"q":"What is the first book of the Bible?","a":["Exodus","Psalms","Genesis","Leviticus"],"c":2,"f":"Genesis describes the creation of the world and the early history of humanity."},
  {"id":"l05","category":"literature","d":2,"q":"Who wrote 'The Great Gatsby'?","a":["Ernest Hemingway","F. Scott Fitzgerald","John Steinbeck","William Faulkner"],"c":1,"f":"Fitzgerald published The Great Gatsby in 1925. It sold poorly during his lifetime."},
  {"id":"l06","category":"literature","d":3,"q":"The epic poem 'The Odyssey' is attributed to which ancient author?","a":["Virgil","Sophocles","Homer","Plato"],"c":2,"f":"Homer's Odyssey describes the 10-year journey of Odysseus home after the Trojan War."},
  {"id":"l07","category":"literature","d":1,"q":"Who wrote 'Don Quixote'?","a":["Lope de Vega","Miguel de Cervantes","Pablo Neruda","Gabriel García Márquez"],"c":1,"f":"Published in 1605, Don Quixote is often cited as the first modern novel."},
  {"id":"l08","category":"literature","d":2,"q":"'To be or not to be' is a line from which Shakespeare play?","a":["Macbeth","Othello","King Lear","Hamlet"],"c":3,"f":"The soliloquy is spoken by Hamlet in Act 3, Scene 1 as he contemplates existence."},
  {"id":"l09","category":"literature","d":3,"q":"Which novel begins with 'Call me Ishmael'?","a":["Robinson Crusoe","Treasure Island","Moby-Dick","Lord Jim"],"c":2,"f":"Melville's Moby-Dick was published in 1851 and was a commercial failure in his lifetime."},
  {"id":"l10","category":"literature","d":2,"q":"Who wrote 'Crime and Punishment'?","a":["Leo Tolstoy","Ivan Turgenev","Fyodor Dostoevsky","Anton Chekhov"],"c":2,"f":"Dostoevsky wrote it in 1866 while deeply in debt, publishing it in serial form."},
  {"id":"l11","category":"literature","d":1,"q":"The character Sherlock Holmes was created by which author?","a":["Agatha Christie","Edgar Allan Poe","Arthur Conan Doyle","Raymond Chandler"],"c":2,"f":"Holmes first appeared in 'A Study in Scarlet' in 1887."},
  {"id":"l12","category":"literature","d":3,"q":"Which American poet wrote 'The Road Not Taken'?","a":["Walt Whitman","Emily Dickinson","Robert Frost","Langston Hughes"],"c":2,"f":"Frost wrote the poem in 1916 as a gentle joke for his friend Edward Thomas."}
]
''';

// ═══════════════════════════════════════════════════════════════
//  REPOSITORY
// ═══════════════════════════════════════════════════════════════
class QRepo {
  static List<Question>? _all;

  static List<Question> get all {
    _all ??= (jsonDecode(kJson) as List)
        .map((e) => Question.fromMap(e as Map<String, dynamic>))
        .toList();
    return _all!;
  }

  static List<String> get categories =>
      all.map((q) => q.category).toSet().toList()..sort();

  static List<Question> forCategoryAndDiff(String cat, int maxDiff) {
    final filtered = all
        .where((q) => (cat == 'all' || q.category == cat) && q.difficulty <= maxDiff)
        .toList()
      ..shuffle(Random());
    return filtered.take(min(15, filtered.length)).toList();
  }
}

// ═══════════════════════════════════════════════════════════════
//  GAME STATE
// ═══════════════════════════════════════════════════════════════
enum AnswerState { waiting, correct, wrong }

class GameState extends ChangeNotifier {
  String category = 'all';
  int maxDifficulty = 2;
  int score = 0;
  int streak = 0;
  int bestStreak = 0;
  int questionIndex = 0;
  List<Question> questions = [];
  AnswerState answerState = AnswerState.waiting;
  int? selectedAnswer;
  List<bool> results = [];

  void start({String cat = 'all', int diff = 2}) {
    category = cat;
    maxDifficulty = diff;
    score = 0;
    streak = 0;
    bestStreak = 0;
    questionIndex = 0;
    questions = QRepo.forCategoryAndDiff(cat, diff);
    answerState = AnswerState.waiting;
    selectedAnswer = null;
    results = [];
    notifyListeners();
  }

  Question get current => questions[questionIndex];
  bool get isFinished => questionIndex >= questions.length;
  double get progress =>
      questions.isEmpty ? 0 : questionIndex / questions.length;
  int get correct => results.where((r) => r).length;
  int get total => results.length;

  void answer(int idx) {
    if (answerState != AnswerState.waiting) return;
    selectedAnswer = idx;
    final isCorrect = idx == current.correctIndex;
    results.add(isCorrect);
    if (isCorrect) {
      score += current.points + (streak * 2);
      streak++;
      if (streak > bestStreak) bestStreak = streak;
      answerState = AnswerState.correct;
    } else {
      streak = 0;
      answerState = AnswerState.wrong;
    }
    notifyListeners();
  }

  void next() {
    questionIndex++;
    answerState = AnswerState.waiting;
    selectedAnswer = null;
    notifyListeners();
  }
}

// ═══════════════════════════════════════════════════════════════
//  HOME SCREEN
// ═══════════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _glowCtrl;
  String _selectedCat = 'all';
  int _selectedDiff = 2;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }

  void _startGame() {
    final gs = GameState()..start(cat: _selectedCat, diff: _selectedDiff);
    Navigator.push(context, _SlideRoute(QuizScreen(gameState: gs)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1.2,
            colors: [Color(0xFF1A1A3E), Color(0xFF0D0D1A)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildSectionLabel('CATEGORY'),
                const SizedBox(height: 12),
                _buildCategoryGrid(),
                const SizedBox(height: 28),
                _buildSectionLabel('DIFFICULTY'),
                const SizedBox(height: 12),
                _buildDifficultyRow(),
                const SizedBox(height: 40),
                _buildStartButton(),
                const SizedBox(height: 20),
                _buildStats(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _glowCtrl,
      builder: (_, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Palette.gold,
                Color.lerp(Palette.gold, Palette.accent, _glowCtrl.value)!,
                Palette.gold,
              ],
            ).createShader(bounds),
            child: const Text(
              'TRIVIA\nMASTER',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.0,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${QRepo.all.length} questions across ${QRepo.categories.length} categories',
            style: const TextStyle(color: Palette.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) => Text(
        text,
        style: const TextStyle(
          color: Palette.gold,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 3,
        ),
      );

  Widget _buildCategoryGrid() {
    final cats = ['all', ...QRepo.categories];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: cats.map((cat) {
        final selected = cat == _selectedCat;
        final color = cat == 'all' ? Palette.gold : Palette.cat(cat);
        return GestureDetector(
          onTap: () => setState(() => _selectedCat = cat),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? color : Palette.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: selected ? color : color.withOpacity(0.3), width: 1.5),
              boxShadow: selected
                  ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 12, spreadRadius: 1)]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(cat == 'all' ? '🌐' : Palette.emoji(cat),
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  cat == 'all' ? 'All' : cat[0].toUpperCase() + cat.substring(1),
                  style: TextStyle(
                    color: selected ? Colors.white : Palette.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDifficultyRow() {
    return Row(
      children: [1, 2, 3].map((d) {
        final selected = d == _selectedDiff;
        final color = Palette.diff(d);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: d < 3 ? 10 : 0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedDiff = d),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: selected ? color : Palette.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: selected ? color : color.withOpacity(0.3), width: 1.5),
                  boxShadow: selected
                      ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 12)]
                      : [],
                ),
                child: Column(
                  children: [
                    Text(['', '🟢', '🟡', '🔴'][d], style: const TextStyle(fontSize: 22)),
                    const SizedBox(height: 4),
                    Text(
                      Palette.diffLabel(d),
                      style: TextStyle(
                        color: selected ? Colors.white : Palette.textSecondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStartButton() {
    return GestureDetector(
      onTap: _startGame,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7C6FE0), Color(0xFF4D96FF)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Palette.accent.withOpacity(0.5), blurRadius: 20, offset: const Offset(0, 6))
          ],
        ),
        child: const Text(
          '▶  START QUIZ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Palette.gold.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('📚', '${QRepo.all.length}', 'Questions'),
          _divider(),
          _statItem('🏷️', '${QRepo.categories.length}', 'Categories'),
          _divider(),
          _statItem('🎯', '3', 'Levels'),
        ],
      ),
    );
  }

  Widget _statItem(String emoji, String value, String label) => Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  color: Palette.gold, fontSize: 20, fontWeight: FontWeight.w900)),
          Text(label,
              style:
                  const TextStyle(color: Palette.textSecondary, fontSize: 11)),
        ],
      );

  Widget _divider() => Container(
      width: 1, height: 50, color: Palette.textSecondary.withOpacity(0.2));
}

// ═══════════════════════════════════════════════════════════════
//  QUIZ SCREEN
// ═══════════════════════════════════════════════════════════════
class QuizScreen extends StatefulWidget {
  final GameState gameState;
  const QuizScreen({super.key, required this.gameState});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late final AnimationController _correctCtrl;
  late final AnimationController _wrongCtrl;
  late final AnimationController _slideCtrl;
  late final Animation<double> _correctPulse;
  late final Animation<double> _wrongShake;
  late final Animation<Offset> _slideAnim;
  bool _showFact = false;

  GameState get gs => widget.gameState;

  @override
  void initState() {
    super.initState();
    gs.addListener(_onState);

    _correctCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _wrongCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _slideCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));

    _correctPulse = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.04), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.04, end: 1.0), weight: 60),
    ]).animate(CurvedAnimation(parent: _correctCtrl, curve: Curves.easeInOut));

    _wrongShake = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 25),
    ]).animate(CurvedAnimation(parent: _wrongCtrl, curve: Curves.easeInOut));

    _slideAnim = Tween(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
    _slideCtrl.forward();
  }

  void _onState() {
    if (!mounted) return;
    setState(() => _showFact = false);
    if (gs.answerState == AnswerState.correct) {
      _correctCtrl.forward(from: 0);
      Future.delayed(const Duration(milliseconds: 300),
          () => mounted ? setState(() => _showFact = true) : null);
      Future.delayed(const Duration(milliseconds: 2000), _goNext);
    } else if (gs.answerState == AnswerState.wrong) {
      _wrongCtrl.forward(from: 0);
      Future.delayed(const Duration(milliseconds: 300),
          () => mounted ? setState(() => _showFact = true) : null);
      Future.delayed(const Duration(milliseconds: 2200), _goNext);
    }
  }

  void _goNext() {
    if (!mounted) return;
    _slideCtrl.reverse().then((_) {
      gs.next();
      if (!gs.isFinished) {
        _slideCtrl.forward();
      } else {
        if (mounted) Navigator.pushReplacement(context, _SlideRoute(ResultScreen(gameState: gs)));
      }
    });
  }

  @override
  void dispose() {
    gs.removeListener(_onState);
    _correctCtrl.dispose();
    _wrongCtrl.dispose();
    _slideCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (gs.isFinished) return const SizedBox.shrink();
    final q = gs.current;
    final catColor = Palette.cat(q.category);

    return Scaffold(
      backgroundColor: Palette.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(q, catColor),
            Expanded(
              child: SlideTransition(
                position: _slideAnim,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: Column(
                    children: [
                      _buildQuestionCard(q, catColor),
                      const SizedBox(height: 16),
                      if (_showFact && q.fact != null) _buildFactBanner(q.fact!, q),
                      const SizedBox(height: 8),
                      ...List.generate(
                        q.answers.length,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _AnswerButton(index: i, question: q, gs: gs),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(Question q, Color catColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Palette.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Palette.textSecondary.withOpacity(0.2)),
                  ),
                  child: const Icon(Icons.close, color: Palette.textSecondary, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${gs.questionIndex + 1} / ${gs.questions.length}',
                      style: const TextStyle(
                          color: Palette.textSecondary, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: gs.progress,
                        minHeight: 6,
                        backgroundColor: Palette.card,
                        valueColor: AlwaysStoppedAnimation(catColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Palette.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Palette.gold.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 4),
                    Text(
                      '${gs.score}',
                      style: const TextStyle(
                          color: Palette.gold, fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                  ],
                ),
              ),
              if (gs.streak >= 2) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B00).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFF6B00).withOpacity(0.5)),
                  ),
                  child: Text(
                    '🔥 ${gs.streak}',
                    style: const TextStyle(
                        color: Color(0xFFFF6B00), fontWeight: FontWeight.w900, fontSize: 14),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Question q, Color catColor) {
    return AnimatedBuilder(
      animation: Listenable.merge([_correctPulse, _wrongShake]),
      builder: (_, __) {
        final scale = gs.answerState == AnswerState.correct ? _correctPulse.value : 1.0;
        final tx = gs.answerState == AnswerState.wrong ? _wrongShake.value : 0.0;

        Color borderColor = catColor.withOpacity(0.3);
        if (gs.answerState == AnswerState.correct) borderColor = Palette.green;
        if (gs.answerState == AnswerState.wrong) borderColor = Palette.red;

        return Transform.translate(
          offset: Offset(tx, 0),
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Palette.card,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: borderColor, width: 1.5),
                boxShadow: [
                  BoxShadow(color: catColor.withOpacity(0.1), blurRadius: 20, spreadRadius: 1),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: catColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: catColor.withOpacity(0.4)),
                        ),
                        child: Text(
                          '${Palette.emoji(q.category)}  ${q.category[0].toUpperCase()}${q.category.substring(1)}',
                          style: TextStyle(
                              color: catColor, fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Palette.diff(q.difficulty).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          Palette.diffLabel(q.difficulty),
                          style: TextStyle(
                              color: Palette.diff(q.difficulty),
                              fontSize: 11,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    q.questionText,
                    style: const TextStyle(
                      color: Palette.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.toll_rounded, size: 14, color: Palette.gold.withOpacity(0.7)),
                      const SizedBox(width: 4),
                      Text(
                        '+${q.points} pts${gs.streak >= 2 ? "  🔥+${gs.streak * 2}" : ""}',
                        style: TextStyle(
                            color: Palette.gold.withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFactBanner(String fact, Question q) {
    final isCorrect = gs.answerState == AnswerState.correct;
    final color = isCorrect ? Palette.green : Palette.red;
    return AnimatedOpacity(
      opacity: _showFact ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isCorrect ? '✅' : '❌', style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCorrect ? 'Correct!' : 'The answer was: ${q.answers[q.correctIndex]}',
                    style: TextStyle(
                        color: color, fontWeight: FontWeight.w800, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(fact,
                      style: const TextStyle(
                          color: Palette.textSecondary, fontSize: 12, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  ANSWER BUTTON
// ═══════════════════════════════════════════════════════════════
class _AnswerButton extends StatefulWidget {
  final int index;
  final Question question;
  final GameState gs;

  const _AnswerButton({required this.index, required this.question, required this.gs});

  @override
  State<_AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<_AnswerButton> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween(begin: 1.0, end: 0.97)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color get _bg {
    final gs = widget.gs;
    if (gs.answerState == AnswerState.waiting) return Palette.card;
    if (widget.index == widget.question.correctIndex) return Palette.green.withOpacity(0.2);
    if (widget.index == gs.selectedAnswer) return Palette.red.withOpacity(0.2);
    return Palette.card.withOpacity(0.5);
  }

  Color get _border {
    final gs = widget.gs;
    if (gs.answerState == AnswerState.waiting) return Palette.textSecondary.withOpacity(0.2);
    if (widget.index == widget.question.correctIndex) return Palette.green;
    if (widget.index == gs.selectedAnswer) return Palette.red;
    return Palette.textSecondary.withOpacity(0.1);
  }

  @override
  Widget build(BuildContext context) {
    final letters = ['A', 'B', 'C', 'D'];
    final letterColors = [Palette.accent, const Color(0xFF4D96FF), const Color(0xFFFF6B9D), const Color(0xFF2ECC71)];
    final lColor = letterColors[widget.index % letterColors.length];

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) => Transform.scale(scale: _scale.value, child: child),
      child: GestureDetector(
        onTapDown: (_) {
          if (widget.gs.answerState != AnswerState.waiting) return;
          _ctrl.forward();
        },
        onTapUp: (_) {
          _ctrl.reverse();
          widget.gs.answer(widget.index);
        },
        onTapCancel: () => _ctrl.reverse(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: _bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _border, width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: lColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: lColor.withOpacity(0.5)),
                ),
                child: Center(
                  child: Text(
                    letters[widget.index],
                    style: TextStyle(
                        color: lColor, fontWeight: FontWeight.w900, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  widget.question.answers[widget.index],
                  style: TextStyle(
                    color: widget.gs.answerState != AnswerState.waiting &&
                            widget.index != widget.question.correctIndex &&
                            widget.index != widget.gs.selectedAnswer
                        ? Palette.textSecondary
                        : Palette.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (widget.gs.answerState != AnswerState.waiting)
                Text(
                  widget.index == widget.question.correctIndex
                      ? '✅'
                      : widget.index == widget.gs.selectedAnswer
                          ? '❌'
                          : '',
                  style: const TextStyle(fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  RESULT SCREEN
// ═══════════════════════════════════════════════════════════════
class ResultScreen extends StatefulWidget {
  final GameState gameState;
  const ResultScreen({super.key, required this.gameState});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with TickerProviderStateMixin {
  late final AnimationController _enterCtrl;
  late final AnimationController _scoreCtrl;
  late final Animation<double> _enterAnim;
  late final Animation<int> _scoreAnim;

  @override
  void initState() {
    super.initState();
    _enterCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _scoreCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _enterAnim = CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOutBack);
    _scoreAnim = IntTween(begin: 0, end: widget.gameState.score)
        .animate(CurvedAnimation(parent: _scoreCtrl, curve: Curves.easeOut));
    _enterCtrl.forward();
    Future.delayed(const Duration(milliseconds: 200), () => _scoreCtrl.forward());
  }

  @override
  void dispose() {
    _enterCtrl.dispose();
    _scoreCtrl.dispose();
    super.dispose();
  }

  String get _grade {
    final pct = widget.gameState.correct / max(1, widget.gameState.total);
    if (pct >= 0.9) return 'S';
    if (pct >= 0.75) return 'A';
    if (pct >= 0.55) return 'B';
    if (pct >= 0.35) return 'C';
    return 'D';
  }

  Color get _gradeColor {
    switch (_grade) {
      case 'S': return Palette.gold;
      case 'A': return Palette.green;
      case 'B': return const Color(0xFF4D96FF);
      case 'C': return const Color(0xFFF39C12);
      default: return Palette.red;
    }
  }

  String get _message {
    switch (_grade) {
      case 'S': return 'Absolutely brilliant! 🏆';
      case 'A': return 'Excellent performance! 🎯';
      case 'B': return 'Good job! Keep it up! 💪';
      case 'C': return 'Not bad! Room to grow! 📖';
      default: return 'Keep practising! 💡';
    }
  }

  @override
  Widget build(BuildContext context) {
    final gs = widget.gameState;
    return Scaffold(
      backgroundColor: Palette.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ScaleTransition(
                scale: _enterAnim,
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _gradeColor.withOpacity(0.15),
                        border: Border.all(color: _gradeColor, width: 3),
                        boxShadow: [
                          BoxShadow(color: _gradeColor.withOpacity(0.4), blurRadius: 30, spreadRadius: 2)
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _grade,
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.w900,
                            color: _gradeColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _message,
                      style: const TextStyle(
                          color: Palette.textPrimary, fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              AnimatedBuilder(
                animation: _scoreCtrl,
                builder: (_, __) => Text(
                  '${_scoreAnim.value}',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Palette.gold,
                    shadows: [Shadow(color: Palette.gold.withOpacity(0.4), blurRadius: 20)],
                  ),
                ),
              ),
              const Text('POINTS', style: TextStyle(color: Palette.textSecondary, letterSpacing: 4, fontSize: 12)),
              const SizedBox(height: 28),
              _buildStatsGrid(gs),
              const SizedBox(height: 28),
              _buildCategoryBreakdown(gs),
              const SizedBox(height: 36),
              _buildActionButtons(gs),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGrid(GameState gs) {
    return Row(
      children: [
        _statBox('✅ Correct', '${gs.correct}/${gs.total}', Palette.green),
        const SizedBox(width: 12),
        _statBox('🔥 Best Streak', '${gs.bestStreak}x', const Color(0xFFFF6B00)),
        const SizedBox(width: 12),
        _statBox('🎯 Accuracy', '${gs.total == 0 ? 0 : ((gs.correct / gs.total) * 100).round()}%', Palette.accent),
      ],
    );
  }

  Widget _statBox(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Palette.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text(label,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Palette.textSecondary, fontSize: 11, height: 1.3)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBreakdown(GameState gs) {
    final catMap = <String, List<bool>>{};
    for (int i = 0; i < gs.questions.length && i < gs.results.length; i++) {
      final cat = gs.questions[i].category;
      catMap.putIfAbsent(cat, () => []);
      catMap[cat]!.add(gs.results[i]);
    }
    if (catMap.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Palette.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Palette.textSecondary.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('BY CATEGORY',
              style: TextStyle(
                  color: Palette.gold, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 3)),
          const SizedBox(height: 14),
          ...catMap.entries.map((e) {
            final correct = e.value.where((v) => v).length;
            final total = e.value.length;
            final pct = correct / max(1, total);
            final color = Palette.cat(e.key);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(Palette.emoji(e.key), style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        e.key[0].toUpperCase() + e.key.substring(1),
                        style: const TextStyle(
                            color: Palette.textPrimary, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text('$correct/$total',
                          style: TextStyle(
                              color: color, fontSize: 12, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct,
                      minHeight: 6,
                      backgroundColor: Palette.bg,
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons(GameState gs) {
    return Column(
      children: [
        _actionBtn(
          label: '🔄  Play Again',
          gradient: const LinearGradient(colors: [Color(0xFF7C6FE0), Color(0xFF4D96FF)]),
          onTap: () {
            Navigator.pushReplacement(
                context,
                _SlideRoute(QuizScreen(
                    gameState: GameState()
                      ..start(cat: gs.category, diff: gs.maxDifficulty))));
          },
        ),
        const SizedBox(height: 12),
        _actionBtn(
          label: '🏠  Home',
          gradient: LinearGradient(
              colors: [Palette.card, Palette.card],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          onTap: () => Navigator.popUntil(context, (r) => r.isFirst),
          border: Border.all(color: Palette.textSecondary.withOpacity(0.3)),
        ),
      ],
    );
  }

  Widget _actionBtn({
    required String label,
    required Gradient gradient,
    required VoidCallback onTap,
    Border? border,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          border: border,
          boxShadow: border == null
              ? [BoxShadow(color: Palette.accent.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 6))]
              : [],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 1),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  NAVIGATION
// ═══════════════════════════════════════════════════════════════
class _SlideRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  _SlideRoute(this.page)
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, anim, __, child) => SlideTransition(
            position: Tween(begin: const Offset(1, 0), end: Offset.zero)
                .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 350),
        );
}