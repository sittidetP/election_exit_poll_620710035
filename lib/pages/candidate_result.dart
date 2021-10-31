import 'package:election_exit_poll_620710035/models/candidate_result_item.dart';
import 'package:election_exit_poll_620710035/services/api.dart';
import 'package:flutter/material.dart';

class CandidateResult extends StatefulWidget {
  static const String routeName = '/candidateResult';

  const CandidateResult({Key? key}) : super(key: key);

  @override
  _CandidateResultState createState() => _CandidateResultState();
}

class _CandidateResultState extends State<CandidateResult> {
  late Future<List<CandidateResultItem>> _futureCandidateResultList;

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText2),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: const DecorationImage(
              image: const AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover)),
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/images/vote_hand.png'),
                  fit: BoxFit.contain,
                  width: 100.0,
                  height: 100.0,
                ),
                Text(
                  'EXIT POLL',
                  style: TextStyle(fontSize: 20.0, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'RESULT',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: FutureBuilder<List<CandidateResultItem>>(
              future: _futureCandidateResultList,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 300.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = snapshot.data![index];
                      return Card(
                        child: InkWell(
                          child: Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 40.0,
                                color: Colors.lightGreen,
                                child: Center(
                                  child: Text(
                                    item.number.toString(),
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${item.title} ${item.fullName}',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          '${item.score}',
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  _handleClickItem(CandidateResultItem item) async {
    var listNum = await _submitCandidate(item.number);
    _showMaterialDialog("SUCCESS", "บันทึกข้อมูลสำเร็จ ${listNum.toString()}");
  }

  _submitCandidate(int number) async {
    var num = await Api().submit('exit_poll', {'candidateNumber': number});
    return num;
  }

  Future<List<CandidateResultItem>> _loadCandidate() async {
    List list = await Api().fetch('exit_poll/result');
    var candidateList =
        list.map((item) => CandidateResultItem.fromJson(item)).toList();
    return candidateList;
  }

  @override
  void initState() {
    super.initState();

    _futureCandidateResultList = _loadCandidate();
    /*
    _loadCandidate().then((list) {
      _candidateList = list;
    });
     */
  }
}
