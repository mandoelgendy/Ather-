import 'package:flutter/material.dart';
void main() => runApp(AtharApp());
class AtharApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AtharHome(),
    );
  }
}
class Dhikr {
  final String id, category, title, arabic, count, source, number, grade;
  Dhikr({required this.id, required this.category, required this.title, required this.arabic, required this.count, required this.source, required this.number, required this.grade});
}
final List<Dhikr> db = [
  Dhikr(id:'m1', category:'morning', title:'آية الكرسي', arabic:'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ', count:'مرة واحدة', source:'صحيح البخاري', number:'2311', grade:'صحيح'),
  Dhikr(id:'m2', category:'morning', title:'الإخلاص والمعوذتين', arabic:'قُلْ هُوَ اللَّهُ أَحَدٌ - قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ - قُلْ أَعُوذُ بِرَبِّ النَّاسِ', count:'3 مرات', source:'أبو داود', number:'5082', grade:'حسن صحيح'),
  Dhikr(id:'m3', category:'morning', title:'سيد الاستغفار', arabic:'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ خَلَقْتَنِي وَأَنَا عَبْدُكَ', count:'مرة واحدة', source:'البخاري', number:'6306', grade:'صحيح'),
  Dhikr(id:'s1', category:'sleep', title:'باسمك أموت وأحيا', arabic:'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا', count:'مرة واحدة', source:'البخاري', number:'6324', grade:'صحيح'),
  Dhikr(id:'t1', category:'travel', title:'دعاء السفر', arabic:'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا', count:'مرة واحدة', source:'مسلم', number:'1342', grade:'صحيح'),
  Dhikr(id:'r1', category:'ruqyah', title:'الرقية', arabic:'أَذْهِبِ الْبَاسَ رَبَّ النَّاسِ اشْفِ وَأَنْتَ الشَّافِي', count:'لم يثبت عدد', source:'البخاري', number:'5743', grade:'صحيح'),
];
class AtharHome extends StatefulWidget { @override _AtharHomeState createState() => _AtharHomeState(); }
class _AtharHomeState extends State<AtharHome> {
  String cat = 'morning';
  Map<String,int> counts = {};
  @override
  Widget build(BuildContext context) {
    var list = db.where((d) => d.category==cat).toList();
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      backgroundColor: Color(0xFF0F0E0B),
      appBar: AppBar(title: Text('أَثَر', style: TextStyle(color: Color(0xFFD4AF37))), backgroundColor: Colors.black, centerTitle: true),
      body: Column(children: [
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          _chip('morning','الصباح'), _chip('sleep','النوم'), _chip('travel','السفر'), _chip('ruqyah','الرقية'),
        ])),
        Expanded(child: ListView.builder(itemCount: list.length, itemBuilder: (c,i){
          var d = list[i];
          int cur = counts[d.id]??0;
          int tot = d.count.contains('3')?3:1;
          return Card(color: Color(0xFF1E1C18), margin: EdgeInsets.all(10), child: Padding(padding: EdgeInsets.all(18), child: Column(children: [
            Text(d.title, style: TextStyle(color: Color(0xFFD4AF37))),
            SizedBox(height:10),
            Text(d.arabic, style: TextStyle(fontSize:20, color: Colors.white), textAlign: TextAlign.center),
            Text('${d.source} ${d.number} - ${d.grade}', style: TextStyle(fontSize:11, color: Colors.grey)),
            LinearProgressIndicator(value: cur/tot, color: Color(0xFFD4AF37)),
            Text('$cur / $tot', style: TextStyle(color: Colors.white)),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37)), onPressed: ()=>setState(()=>counts[d.id]= cur<tot? cur+1 : 0), child: Text(cur>=tot? 'تم': 'تسبيح', style: TextStyle(color: Colors.black))),
          ])));
        })),
      ]),
    ));
  }
  Widget _chip(String v, String label){ return Padding(padding: EdgeInsets.all(4), child: ChoiceChip(label: Text(label), selected: cat==v, onSelected: (_)=>setState(()=>cat=v))); }
}
