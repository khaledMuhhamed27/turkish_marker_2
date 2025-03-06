import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final IconData myLiftIcon;
  final bool myRightButton;
  final VoidCallback onLeftIconTap;
  final VoidCallback? onRightIconTap;
  final String titleScreen;

  const CustomAppBar({
    super.key,
    required this.myLiftIcon,
    required this.myRightButton,
    required this.onLeftIconTap,
    required this.titleScreen,
    this.onRightIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                onTap: onLeftIconTap,
                child: _buildIconButton(myLiftIcon, context),
              ),
            ),
            // i want use theme here
            Text(titleScreen, style: Theme.of(context).textTheme.titleLarge),
            myRightButton
                ? Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: GestureDetector(
                      onTap: onRightIconTap,
                      child: _buildIconButton(Icons.search, context),
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          width: 1,
          color: Theme.of(context).canvasColor,
        ),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 0.5,
              blurRadius: 5)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: Theme.of(context).iconTheme.color, size: 20),
    );
  }
}
