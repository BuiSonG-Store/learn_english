import 'package:flutter/material.dart';
import 'package:learn_english/provider/rank_provider.dart';
import 'package:learn_english/view/screens/rank/widget/item_rank.dart';
import 'package:learn_english/view/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({Key? key}) : super(key: key);

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  bool _runFirst = true;

  @override
  Widget build(BuildContext context) {
    if(_runFirst){
      _runFirst = false;
      Provider.of<RankProvider>(context).getDataRank();
    }
    return Consumer<RankProvider>(builder: (context, provider, widget) {
      return Scaffold(
          body: Column(
            children: [
              const CustomAppbar(
                title: 'Chart rankings',
                haveIcon1: false,
                haveIcon2: false,
                haveIconPop: false,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.rankModel?.top10User?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ItemRank(
                      model: provider.rankModel?.top10User?[index],
                    );
                  },
                ),
              )
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              color: Theme.of(context).backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(-1, -1), // Shadow position
                ),
              ],
            ),
            height: 120,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  'Your rank',
                  style: Theme.of(context).textTheme.headline6,
                ),
                ItemRank(
                  model: provider.rankModel?.currentUserScore,
                )
              ],
            ),
          ));
    });
  }
}
