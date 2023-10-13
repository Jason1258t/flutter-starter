part of 'utils.dart';

class AppTypography {
  static const TextStyle _font = TextStyle(fontFamily: 'VTBGroup');

  static final font16w400  =_font.copyWith(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final fon12w400 = _font.copyWith(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static final font32w600 = _font.copyWith(
    color: AppColors.primary,
    fontSize: 32,
    fontWeight: FontWeight.w600
  );
}