import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/card_model.dart';
import 'dart:convert';
import '../helpers/card_colors.dart';

class CardListBloc{

  BehaviorSubject<List<CardResults>> _cardsCollection = BehaviorSubject<List<CardResults>>();

  List<CardResults> _cardResults;

  //retrieve data of stream 
  Stream<List<CardResults>> get cardList => _cardsCollection.stream;

  void initialData() async{
    var initialData  = await rootBundle.loadString('data/initialData.json');
    var decodeJson = jsonDecode(initialData);
    _cardResults = CardModel.fromJson(decodeJson).results;

    for(var i=0; i < _cardResults.length; i++){
      _cardResults[i].cardColor = CardColor.baseColors[i];
    }

    _cardsCollection.sink.add(_cardResults);
  }

  CardListBloc(){
    initialData();
  }

  void dispose(){
    _cardsCollection.close();
  }
}

final cardListBloc = CardListBloc();



