import 'package:flutter/material.dart';
import 'dart:math';

// this code was written by Neil Sayers for confidant, re-using it here
// thank you Neil <3

const double DEFAULT_EMOTIONAL_INTENSITY = 1;

abstract class Emotion {
  Color colour;
  String name;
  String emoji;
  double intensity;

  Emotion(this.colour, this.name, this.intensity, this.emoji);

  Color getTranslucentColour() {
    int alpha = (colour.alpha * intensity / 1.4).floor();
    print('alpha: $alpha');
    return Color.fromARGB(alpha, colour.red, colour.green, colour.blue);
  }

  Widget toLegendWidget() {
    return Padding(
        padding: EdgeInsets.only(right: 70),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Text(name, style: TextStyle(fontSize: 18, color: Colors.black)),
          Text(' ●', style: TextStyle(fontSize: 18, color: colour)),
        ]));
  }
}

class Emotionless extends Emotion {
  Emotionless() : super(Colors.white, "none", 0, '😶');
}

class Anger extends Emotion {
  Anger(double intensity) : super(Colors.redAccent, "anger", intensity, '😠');
}

class Fear extends Emotion {
  Fear(double intensity) : super(Colors.lightGreen, "fear", intensity, '😨');
}

class Joy extends Emotion {
  Joy(double intensity) : super(Colors.yellow, "joy!", intensity, '😃');
}

class Sadness extends Emotion {
  Sadness(double intensity)
      : super(Colors.blueAccent, "sadness", intensity, '😥');
}

class Analytical extends Emotion {
  Analytical(double intensity)
      : super(Colors.brown[300], "analytical", intensity, '🤔');
}

class Confident extends Emotion {
  Confident(double intensity)
      : super(Colors.amber[600], "confident", intensity, '😎');
}

class Tentative extends Emotion {
  Tentative(double intensity)
      : super(Colors.grey[350], "tentative", intensity, '😏');
}

class EmotionSet {
  Anger anger;
  Fear fear;
  Joy joy;
  Tentative tentative;
  Confident confident;
  Analytical analytical;
  Sadness sadness;

  final List<Emotion> list = new List<Emotion>();

  EmotionSet(
      {double angerIntensity = DEFAULT_EMOTIONAL_INTENSITY,
        double fearIntensity = DEFAULT_EMOTIONAL_INTENSITY,
        double joyIntensity = DEFAULT_EMOTIONAL_INTENSITY,
        double sadnessIntensity = DEFAULT_EMOTIONAL_INTENSITY,
        double tentativeIntensity = DEFAULT_EMOTIONAL_INTENSITY,
        double confidentIntensity = DEFAULT_EMOTIONAL_INTENSITY,
        double analyticalIntensity = DEFAULT_EMOTIONAL_INTENSITY}) {
    this.anger = Anger(angerIntensity);
    this.fear = Fear(fearIntensity);
    this.joy = Joy(joyIntensity);
    this.tentative = Tentative(tentativeIntensity);
    this.confident = Confident(confidentIntensity);
    this.analytical = Analytical(analyticalIntensity);
    this.sadness = Sadness(sadnessIntensity);
    list
      ..add(anger)
      ..add(fear)
      ..add(joy)
      ..add(tentative)
      ..add(confident)
      ..add(analytical)
      ..add(sadness);
  }

  factory EmotionSet.fromAnalysis(EmotionalAnalysis ea) {
    if (ea == null) {
      return EmotionSet();
    }

    double angerAccumulator = DEFAULT_EMOTIONAL_INTENSITY;
    double fearAccumulator = DEFAULT_EMOTIONAL_INTENSITY;
    double sadnessAccumulator = DEFAULT_EMOTIONAL_INTENSITY;
    double joyAccumulator = DEFAULT_EMOTIONAL_INTENSITY;
    double tentativeAccumulator = DEFAULT_EMOTIONAL_INTENSITY;
    double confidentAccumulator = DEFAULT_EMOTIONAL_INTENSITY;
    double analyticalAccumulator = DEFAULT_EMOTIONAL_INTENSITY;

    if (ea.sentences != null) {
      print(
          'got not null sentences: ${ea.sentences.length} of them to be exact');
      List<SentenceTone> sentences = ea.sentences;

      for (SentenceTone s in sentences) {
        for (IndividualTone t in s.tones) {
          Emotion e = t.emotion;
          double intensity = e.intensity;
          switch (e.runtimeType) {
            case Anger:
              angerAccumulator += intensity;
              break;
            case Fear:
              fearAccumulator += intensity;
              break;
            case Joy:
              joyAccumulator += intensity;
              break;
            case Sadness:
              sadnessAccumulator += intensity;
              break;
            case Analytical:
              analyticalAccumulator += intensity;
              break;
            case Tentative:
              tentativeAccumulator += intensity;
              break;
            case Confident:
              confidentAccumulator += intensity;
              break;
            default:
              break;
          }
        }
      }
    } else {
      print('got here');
      DocumentTone docTone = ea.docTone;
      for (IndividualTone t in docTone.tones) {
        Emotion e = t.emotion;
        double intensity = e.intensity;
        switch (e.runtimeType) {
          case Anger:
            angerAccumulator += intensity;
            break;
          case Fear:
            fearAccumulator += intensity;
            break;
          case Joy:
            joyAccumulator += intensity;
            break;
          case Sadness:
            sadnessAccumulator += intensity;
            break;
          case Analytical:
            analyticalAccumulator += intensity;
            break;
          case Tentative:
            tentativeAccumulator += intensity;
            break;
          case Confident:
            confidentAccumulator += intensity;
            break;
          default:
            break;
        }
      }
    }

    return EmotionSet(
      analyticalIntensity: analyticalAccumulator,
      angerIntensity: angerAccumulator,
      joyIntensity: joyAccumulator,
      fearIntensity: fearAccumulator,
      confidentIntensity: confidentAccumulator,
      tentativeIntensity: tentativeAccumulator,
      sadnessIntensity: sadnessAccumulator,
    );
  }

  double maxValue() {
    List<double> intensities = list.map((e) => e.intensity).toList();
    return intensities.reduce(max);
  }
}


class EmotionalAnalysis {
  List<SentenceTone> sentences;
  DocumentTone docTone;

  EmotionalAnalysis({this.docTone, this.sentences});

  factory EmotionalAnalysis.fromJson(Map<String, dynamic> json) {
    var docTonesJson = json['document_tone'];

    var tempDocTone = DocumentTone.fromJson(docTonesJson);

    var sentencesTonesJson = json['sentences_tone'] as List;

    if (sentencesTonesJson != null) {
      List<SentenceTone> tempSentences = sentencesTonesJson
          .map<SentenceTone>((json) => SentenceTone.fromJson(json))
          .toList();
      return EmotionalAnalysis(docTone: tempDocTone, sentences: tempSentences);
    }
    return EmotionalAnalysis(docTone: tempDocTone);
  }

  @override
  String toString() {
    return docTone.toString() + '\n' + sentences.toString();
  }
}

class DocumentTone {
  List<IndividualTone> tones;

  DocumentTone({this.tones});

  factory DocumentTone.fromJson(Map<String, dynamic> json) {
    var tonesJson = json['tones'] as List;

    List<IndividualTone> tempTones = tonesJson
        .map<IndividualTone>((json) => IndividualTone.fromJson(json))
        .toList();

    return DocumentTone(tones: tempTones);
  }

  @override
  String toString() {
    String s = '';
    for (IndividualTone t in tones) {
      s += t.toString() + '\n';
    }
    return 'doc tone: \n' + s;
  }
}

class SentenceTone {
  int sentenceId;
  String text;
  List<IndividualTone> tones;

  SentenceTone({this.sentenceId, this.text, this.tones});

  factory SentenceTone.fromJson(Map<String, dynamic> json) {
    var tonesJson = json['tones'] as List;

    List<IndividualTone> tempTones = tonesJson
        .map<IndividualTone>((json) => IndividualTone.fromJson(json))
        .toList();

    return SentenceTone(
        sentenceId: json['sentence_id'], text: json['text'], tones: tempTones);
  }

  @override
  String toString() {
    String s = '';
    for (IndividualTone t in tones) {
      s += t.toString() + '\n';
    }
    return 'sentence id: $sentenceId. text: $text\n $s';
  }
}

class IndividualTone {
  final String toneId;
  final double intensity;

  Emotion emotion;

  IndividualTone({this.toneId, this.intensity}) {
    switch (toneId) {
      case 'sadness':
        emotion = Sadness(intensity);
        break;
      case 'analytical':
        emotion = Analytical(intensity);
        break;
      case 'joy':
        emotion = Joy(intensity);
        break;
      case 'anger':
        emotion = Anger(intensity);
        break;
      case 'confident':
        emotion = Confident(intensity);
        break;
      case 'fear':
        emotion = Fear(intensity);
        break;
      case 'tentative':
        emotion = Tentative(intensity);
        break;
      default:
        emotion = Anger(-1);
    }
  }

  factory IndividualTone.fromJson(Map<String, dynamic> json) {
    return IndividualTone(toneId: json['tone_id'], intensity: json['score']);
  }

  @override
  String toString() {
    return '====== ${emotion.name} ${emotion.intensity}';
  }
}
