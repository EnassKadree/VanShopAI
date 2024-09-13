part of 'generate_pdf_cubit.dart';

sealed class GeneratePdfState {}

final class GeneratePdfInitial extends GeneratePdfState {}


final class GeneratePDFLoading extends GeneratePdfState {}
final class GeneratePDFFailure extends GeneratePdfState {}
final class GeneratePDFSuccess extends GeneratePdfState {}
