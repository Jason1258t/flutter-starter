part of 'routes_cubit.dart';

@immutable
abstract class RoutesState {}

class RoutesInitial extends RoutesState {}

class RoutesLoadingState extends RoutesState {}

class RoutesFoundedState extends RoutesState {}