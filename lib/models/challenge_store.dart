import 'package:flutter/material.dart';

//챌린지 윗부분 내용
List<Widget> challengeStart(int day) {
  const TextStyle customStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  switch (day) {
    case 1:
      return [
        const Text('친구나 가족과의 만남', style: customStyle),
      ];
    case 2:
      return [
        const Text('물 마시기', style: customStyle),
      ];
    case 3:
      return [
        const Text('명상 및 호흡 운동', style: customStyle),
      ];
    case 4:
      return [
        const Text('음악 감상', style: customStyle),
      ];
    case 5:
      return [
        const Text('자기 사랑 연습', style: customStyle),
      ];
    case 6:
      return [
        const Text('긍정적인 인용구 모으기', style: customStyle),
      ];
    case 7:
      return [
        const Text('자기 선물', style: customStyle),
      ];
    case 8:
      return [
        const Text('봉사 활동', style: customStyle),
      ];
    case 9:
      return [
        const Text('웃음 요법', style: customStyle),
      ];
    case 10:
      return [
        const Text('사진 도전', style: customStyle),
      ];
    case 11:
      return [
        const Text('자연 치유', style: customStyle),
      ];
    case 12:
      return [
        const Text('일기 쓰기', style: customStyle),
      ];
    case 13:
      return [
        const Text('책 읽기', style: customStyle),
      ];
    case 14:
      return [
        const Text('새로운 취미 시작', style: customStyle),
      ];
    default:
      return [
        const Text('그 외 내용'),
      ];
  }
}

//챌린지 아랫부분 내용
String challengeEnd(int day) {
  switch (day) {
    case 1:
      return '사랑하는 사람들과 함께 시간을 보내면\n 우울감을 완화시킬 수 있습니다.\n 커피를 마시거나 산책을 함께 하며\n 대화하는 것도 좋은 방법입니다.';
    case 2:
      return '시원한 물을 마시면 우울감을\n 완화시키고 긴장을 풀 수 있습니다.';
    case 3:
      return '명상이나 깊은 호흡 운동은 스트레스를 해소하고\n 정신을 집중시키는 데 도움을 줄 수 있습니다.\n 조용한 장소에서 몇 분 동안 집중하여\n 명상을 실천해보세요.';
    case 4:
      return '좋아하는 음악을 듣고 감상해보세요.\n 음악은 감정을 표현하고 치유하는 데\n 큰 도움이 될 수 있습니다.';
    case 5:
      return '거울을 보면서 자신에게 "나를 사랑합니다."하고 말해보세요.\n 자기 자신을 받아들이고 사랑하는 것은\n 펫로스 증후군 극복에 중요한 부분입니다.';
    case 6:
      return '긍정적인 인용구를 찾아 모아보세요.\n 이를 읽으면서 긍정적인 생각과 에너지를 얻을 수 있습니다.';
    case 7:
      return '자신을 위한 작은 선물을 준비하세요.\n 좋아하는 디저트, 영화 감상, 스파 트리트먼트 등을\n 선택할 수 있습니다.\n 자기 자신에 대한 관심과 사랑을 나타내는 작은 행위입니다.';
    case 8:
      return '다른 사람들을 도우며 자신의 기분을 개선하세요.\n 자원봉사 활동이나 가까운 이웃을 돕는 일 등의 방법을\n 고려해보세요.';
    case 9:
      return '웃음 요법을 실천해보세요.\n 코미디 영화나 유머 쇼를 시청하거나 웃긴 이야기를 읽어보세요.\n 웃음은 스트레스를 완화하고\n 긍정적인 기분을 불러일으킬 수 있습니다.';
    case 10:
      return '주제를 정하고 그에 맞는 사진을 찍어보세요.\n 사진은 순간을 기록하고 창의성을 자극하는데 도움이 됩니다.';
    case 11:
      return '자연 속에서 힐링을 경험해보세요.\n 숲 산책, 해변산책, 정원 가꾸기 등 자연에서 접근하면서\n 치유와 평온을 찾아보세요.';
    case 12:
      return '일기를 쓰면서 감정을 표현하고 내면의 갈등을 기록해보세요.\n 일기 쓰기는 정신적인 부담을 줄이고,\n 자신을 이해하는 데 도움을 줄 수 있습니다.';
    case 13:
      return '자기계발서나 긍정적인 영향을 주는 소설을 읽어보세요.\n 독서는 마음을 안정시키고\n 새로운 아이디어를 제공할 수 있습니다.';
    case 14:
      return '새로운 취미를 찾아보고 도전해보세요.\n 그림그리기, 음악 연주, 요리, 정원 가꾸기 등\n 다양한 옵션이 있을 수 있습니다.\n 자기계발을 위해 도전해보는 것도 좋습니다.';
    default:
      return '오늘의 명언';
  }
}

//챌린지 감정
List<String> buttonTexts = [
  '기분전환',
  '희망찬',
  '보람찬',
  '우울한',
  '드라이브 가고 싶은',
  '미련',
  '아직 잘 모르겠어요',
  '울고 싶은',
  '어제보다 나은',
  '무력한',
  '떠나고 싶은',
  '후회스러운',
  '두려운',
  '불면증',
];
