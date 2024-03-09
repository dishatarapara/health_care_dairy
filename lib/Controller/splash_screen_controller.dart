import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  List<OnboardingContents> contents = [
    OnboardingContents(
      title: "Need A Doctor",
      image: "assets/images/one_image.jpg",
      desc: "Lorem ipsum dolor sit amet, \n consectetur adipiscing elit, sed do \n eiusmod tempor incididunt ut",
    ),
    OnboardingContents(
      title: "Health Advice",
      image: "assets/images/second_image.jpg",
      desc: "Lorem ipsum dolor sit amet, \n consectetur adipiscing elit, sed do \n eiusmod tempor",
    ),
    OnboardingContents(
      title: "Medicine",
      image: "assets/images/third_image.jpg",
      desc: "Lorem ipsum dolor sit amet, \n consectetur adipiscing elit, sed do \n eiusmod",
    ),
  ];
}

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({required this.title, required this.image, required this.desc});

}