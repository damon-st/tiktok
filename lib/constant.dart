//COLORS
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/controllers/auth_controller.dart';
import 'package:tiktok/views/screnns/add_video_screen.dart';
import 'package:tiktok/views/screnns/profile_screnn.dart';
import 'package:tiktok/views/screnns/search_screen.dart';
import 'package:tiktok/views/screnns/video_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//CONTROLLERS

var authController = AuthController.i;

//PAGES
List pages = [
  const VideoScreen(),
  const SearchScreen(),
  const AddVideoScreen(),
  Text("Message"),
  ProfileScreen(id: authController.user.uid),
];
