import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaginationButtons extends StatelessWidget {
  final VoidCallback? onNextPressed;
  final VoidCallback? onPreviousPressed;
  final int currentPage;
  final int pagesAmount;

  const PaginationButtons({
    super.key,
    this.onNextPressed,
    this.onPreviousPressed,
    required this.currentPage,
    required this.pagesAmount,
  });

  @override
  Widget build(BuildContext context) {
    ColorFilter? clearFilter =
        const ColorFilter.mode(Colors.white, BlendMode.clear);

    ColorFilter? disabledPrevBtnFilter = currentPage == 1 ? clearFilter : null;

    ColorFilter? disabledNextBtnFilter =
        currentPage == pagesAmount ? clearFilter : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: currentPage == 1 ? null : onPreviousPressed,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(1 / 2),
            child: SvgPicture.asset('assets/icons/arrow.svg',
                width: 50, height: 50, colorFilter: disabledPrevBtnFilter),
          ),
        ),
        const SizedBox(width: 15.0),
        Text(
          "${currentPage.toString()}/$pagesAmount",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 15.0),
        GestureDetector(
          onTap: currentPage == pagesAmount ? null : onNextPressed,
          child: SvgPicture.asset(
            'assets/icons/arrow.svg',
            width: 50,
            height: 50,
            colorFilter: disabledNextBtnFilter,
          ),
        ),
      ],
    );
  }
}
