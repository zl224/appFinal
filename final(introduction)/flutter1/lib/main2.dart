import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '我的自傳',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: AutobiographyContent(),
      ),
    );
  }
}

class AutobiographyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[200], // 背景色
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              title: Text(
                '個人簡介',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              children: [
                SizedBox(height: 8.0),
                Text(
                  '姓名: 林哲立',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '先前就讀高中：竹北高中',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '目前就讀：高雄科技大學-資工系',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '生日：2023年2月24日',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                '簡介',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              children: [
                SizedBox(height: 16.0),
                Text(
                  '嗨，大家好！我是林哲立，目前就讀於國立高雄科技大學。我的生日是2023年2月24日，這個日子對我來說充滿了特別的意義。',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '在學習的歷程中，我努力學習各種科目，並參與學校的各種活動。透過這些經驗，我學到了許多與同學共處、合作和成長的價值。',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '我對科技和程式設計充滿熱情，不僅參與學校的相關活動，還自學了一些程式語言。這讓我獲得了解決問題和創造新事物的能力，同時也激發了我的創造力。',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '除了學業和科技，我還喜歡參與各種社會服務活動，努力為社區和學校做出一點貢獻。我相信通過互助和合作，我們可以共同創造更美好的未來。',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '謝謝您花時間了解我，期待未來有更多的機會與您分享我的故事和成就。',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                '連結',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              children: [
                SizedBox(height: 8.0),
                Text(
                  'Facebook: https://www.facebook.com/?locale=zh_TW',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Instagram: https://www.instagram.com/___zhe__li_/',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  'GitHub: https://github.com/zl224',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
