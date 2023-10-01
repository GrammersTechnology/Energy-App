import 'package:demo/const/space_helper.dart';
import 'package:demo/const/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../provider.dart';
import '../controller/saving_tips_controller.dart';

class TipsScreen extends ConsumerWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Savings Tips',
          style:
              GoogleFonts.montserrat(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref.read(saningTipsRepositeryProvider).getTips();
          // controller.getTips(context),
        },
        child: SafeArea(
            child: ref.watch(savingTipsProvider).when(
          data: (data) {
            return data.isEmpty
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
                              borderRadius: BorderRadius.circular(15)),
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
                : Text(" nodata");
          },
          error: (error, stackTrace) {
            return Center(
              child: Text("Something wrong"),
            );
          },
          loading: () {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )),
      ),
    );
  }
}
