import 'package:flutter/material.dart';

abstract class DrawerStates {}

class InitialDrawerState extends DrawerStates {}

class ChangeCategoryValueState extends DrawerStates {}

class ChangePriceRangeValueState extends DrawerStates {}

class ChangeOrderByValueState extends DrawerStates {}

class LoadingCategoriesState extends DrawerStates {}

class LoadedCategoriesState extends DrawerStates {}

class ErrorDrawerState extends DrawerStates {}
