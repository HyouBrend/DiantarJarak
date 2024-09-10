import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';

class PagingHistory extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  PagingHistory({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  Widget _buildPageButton(int page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {
          print('Navigating to page: $page'); // Debugging line
          onPageChanged(page);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: CustomColorPalette.buttonTextColor,
          backgroundColor: page == currentPage
              ? CustomColorPalette.buttonColor
              : CustomColorPalette.BgBorder,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size(40, 40), // Set the minimum size
        ),
        child: Text(page.toString()),
      ),
    );
  }

  Widget _buildPageNavigationButton(String text, int? page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: page != null
            ? () {
                print('Navigating to page: $page'); // Debugging line
                onPageChanged(page);
              }
            : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: CustomColorPalette.buttonTextColor,
          backgroundColor: CustomColorPalette.buttonColor,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size(60, 40),
        ),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pageButtons = [];

    if (currentPage > 1) {
      pageButtons
          .add(_buildPageNavigationButton("« Sebelumnya", currentPage - 1));
    }

    pageButtons.add(_buildPageButton(1));
    if (currentPage > 3) {
      pageButtons.add(Text("..."));
    }

    if (currentPage > 2) {
      pageButtons.add(_buildPageButton(currentPage - 1));
    }
    if (currentPage > 1 && currentPage < totalPages) {
      pageButtons.add(_buildPageButton(currentPage));
    }
    if (currentPage < totalPages - 1) {
      pageButtons.add(_buildPageButton(currentPage + 1));
    }

    if (currentPage < totalPages) {
      pageButtons
          .add(_buildPageNavigationButton("Berikutnya »", currentPage + 1));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pageButtons,
    );
  }
}
