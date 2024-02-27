import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/news_app/business/business_screen.dart';
import 'package:news_app/modules/news_app/science/science_screen.dart';
import 'package:news_app/modules/news_app/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  // Initialization Object From Me !!
static NewsCubit get(context) => BlocProvider.of(context);

int currentIndex=0;

List<BottomNavigationBarItem> bottomItems=[
  BottomNavigationBarItem(
      icon:Icon(Icons.business_outlined),
    label: 'Business'
  ),
  BottomNavigationBarItem(
      icon:Icon(Icons.sports_baseball),
    label: 'Sports'
  ),
  BottomNavigationBarItem(
      icon:Icon(Icons.science_rounded),
    label: 'Science'
  ),
];

List<Widget> screens=[
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),
];

void changeBottomNavBar(int index){
  currentIndex = index;
  if(index  == 1)
    getSports();
  if(index ==2)
    getScience();
  emit(NewsBottomNavState());
}

List<dynamic> business=[];

void  getBusiness()
{
  emit(NewsGetBusinessLoadingState());
  DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'d505e1ca8327496abef9ad9555b02c90'
      }
  ).then((value) {
    business = value.data['articles'];
    emit(NewsGetBusinessSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(NewsGetBusinessErrorState(error.toString()));
  });
}

  List<dynamic> sports=[];

  void  getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length ==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sport',
            'apiKey':'d505e1ca8327496abef9ad9555b02c90'
          }
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      NewsGetSportsSuccessState();
    }


  }



  List<dynamic> science=[];

  void  getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length == 0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'d505e1ca8327496abef9ad9555b02c90'
          }
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      NewsGetScienceSuccessState();
    }

  }



  List<dynamic> search=[];

  void  getSearch(String value)
  {
    emit(NewsGetScienceLoadingState());
    search = [];

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'d505e1ca8327496abef9ad9555b02c90'
        }
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });

  }
}