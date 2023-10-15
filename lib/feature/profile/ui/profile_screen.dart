import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';
import 'package:starter/widgets/containers/office_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Карта',
              style: AppTypography.font20w600,
            ),
            Image.asset(
              'assets/images/VTB_logo-white_ru.png',
              height: 25,
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 13, 20, 0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 29,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 220,
                    child: Text(
                      'User',
                      style: AppTypography.font20w600
                          .copyWith(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.exit_to_app_outlined,
                        color: Colors.red,
                        size: 32,
                      ))
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Здесь будут ваши тзбранные отделения',
                  style: AppTypography.font16w400.copyWith(color: Colors.black),
                ),
              ),
            ),
            SliverList.builder(itemBuilder: (context, index) {
              return const OfficeContainer();
            }, itemCount: 2,)
          ],
        ),
      ),
    );
  }
}
