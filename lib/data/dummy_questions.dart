import 'models/question.dart';

/// Data soal lokal (dummy) bertema game Arknights.
const List<Question> dummyQuestions = [
  Question(
    text: 'Sebutan untuk karakter yang dimainkan pemain sebagai komandan Rhodes Island adalah...',
    options: ['Doctor', 'Chief', 'Captain', 'Director'],
    correctIndex: 0,
  ),
  Question(
    text: 'Siapa pemimpin muda Rhodes Island yang selalu mendampingi Doctor?',
    options: ['Ptilopsis', 'Amiya', 'Silence', 'Rosmontis'],
    correctIndex: 1,
  ),
  Question(
    text: 'Apa nama penyakit mematikan yang diderita oleh para Infected di Terra?',
    options: [
      'Originium Infection',
      'Oripathy',
      'Arts Syndrome',
      'Terra Plague',
    ],
    correctIndex: 1,
  ),
  Question(
    text: 'Apa nama mineral yang menjadi sumber energi Arts sekaligus penyebab Oripathy?',
    options: ['Orirock', 'Sugar', 'Originium', 'Device'],
    correctIndex: 2,
  ),
  Question(
    text: 'Apa nama genre gameplay utama dari Arknights?',
    options: ['Tower Defense', 'Battle Royale', 'Gacha Card Battle', 'Racing'],
    correctIndex: 0,
  ),
  Question(
    text: 'Siapa developer yang membuat Arknights?',
    options: ['miHoYo', 'Hypergryph', 'Yostar', 'Lilith Games'],
    correctIndex: 1,
  ),
  Question(
    text: 'Apa nama kelas Operator yang bertugas menyembuhkan sekutu?',
    options: ['Caster', 'Guard', 'Medic', 'Specialist'],
    correctIndex: 2,
  ),
  Question(
    text: 'Resource apa yang dipakai untuk memulai sebuah stage?',
    options: ['Sanity', 'Stamina', 'Energy', 'Mana'],
    correctIndex: 0,
  ),
  Question(
    text: 'Apa nama perusahaan farmasi tempat Doctor dan Amiya bernaung?',
    options: ['Lungmen Guard', 'Rhodes Island', 'Penguin Logistics', 'Reunion'],
    correctIndex: 1,
  ),
  Question(
    text: 'Di kota manakah konflik utama dengan Reunion terjadi pada awal cerita?',
    options: ['Chernobog', 'Lungmen', 'Victoria', 'Kazimierz'],
    correctIndex: 1,
  ),
];
