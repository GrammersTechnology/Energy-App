import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/themes/colors.dart';
import 'package:demo/features/Saving%20Tips/controller/saving_tips_controller.dart';
import 'package:demo/utils/const/widgets/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/savinr_tips_model.dart';

class TipsScreen extends ConsumerWidget {
  TipsScreen({super.key});
  List<SavingTips> data = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   savingTipsRepository.getTips();
    // });
    final savingTipsRepository = ref.watch(savingTipsRepositeryProvider);

    // ref.watch(savingTipsProvider);

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(
            'Savings Tips',
            style: GoogleFonts.montserrat(
                fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => savingTipsRepository.getTips(),
          child: FutureBuilder(
              future: savingTipsRepository.getTips(),
              initialData: data,
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapShot.hasError) {
                  return const InternetChecking();
                } else if (snapShot.hasData) {
                  data = snapShot.data ?? [];
                  return SafeArea(
                      child: data.isNotEmpty
                          ? ListView.separated(
                              padding: const EdgeInsets.all(10),
                              separatorBuilder: (context, index) {
                                return vSpaceRegular;
                              },
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.all(8),
                                    // height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8, top: 8),
                                          child: Text(
                                            data[index].savingstips,
                                            style: GoogleFonts.nunitoSans(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                              })
                          : const Center(child: Text("Saving Tips is Empty")));
                }
                return const SizedBox();
              }),
        ));
  }
}
