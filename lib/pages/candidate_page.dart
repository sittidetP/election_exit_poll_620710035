import 'package:election_exit_poll_620710035/pages/candidat_list.dart';
import 'package:flutter/material.dart';

class CandidatePage extends StatefulWidget {
  static const String routeName = '/candidatePage';

  const CandidatePage({Key? key}) : super(key: key);

  @override
  _CandidatePageState createState() => _CandidatePageState();
}

class _CandidatePageState extends State<CandidatePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.lightBlue),
      child: Column(
        children: [
          CandidateList(),
        ],
      ),
    );
  }
}
