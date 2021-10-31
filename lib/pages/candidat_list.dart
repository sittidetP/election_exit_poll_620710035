import 'package:election_exit_poll_620710035/models/api_result.dart';
import 'package:election_exit_poll_620710035/models/candidate_Item.dart';
import 'package:election_exit_poll_620710035/pages/candidate_result.dart';
import 'package:election_exit_poll_620710035/services/api.dart';
import 'package:flutter/material.dart';

class CandidateList extends StatefulWidget {
  static const String routeName = '/candidateList';

  const CandidateList({Key? key}) : super(key: key);

  @override
  _CandidateListState createState() => _CandidateListState();
}

class _CandidateListState extends State<CandidateList> {
  late Future<List<CandidateItem>> _futurecandidateList;

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
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover)),
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Image(image: AssetImage('assets/images/vote_hand.png'),fit: BoxFit.contain,width: 100.0,height: 100.0,),
                Text('EXIT POLL', style: TextStyle(fontSize: 20.0, color: Colors.grey),),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('เลือกตั้ง อบต.', style: TextStyle(fontSize: 25.0, color: Colors.white),),
                ),
                Text('รายชื่อผู้สมัครรับเลือกตั้ง', style: TextStyle(fontSize: 16.0, color: Colors.white),),
                Text('นายกองค์การบริหารส่วนตำบลเขาพระ', style: TextStyle(fontSize: 16.0, color: Colors.white),),
                Text('อำเภอเมืองนครนายก จังหวัดนครนายก', style: TextStyle(fontSize: 16.0, color: Colors.white),),
              ],
            ),
          ),
          Container(
            child: FutureBuilder<List<CandidateItem>>(
              future: _futurecandidateList,
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
                          onTap: () => _handleClickItem(item),
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
                                        fontSize: 25.0,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${item.title} ${item.fullName}',
                                        style: TextStyle(fontSize: 20.0),
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
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, CandidateResult.routeName);
                    },
                    child: Text(
                      "ดูผล",
                      style: TextStyle(fontSize: 20.0),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  _handleClickItem(CandidateItem item) async {
    var listNum = await _submitCandidate(item.number);
    _showMaterialDialog("SUCCESS", "บันทึกข้อมูลสำเร็จ ${listNum.toString()}");
  }

  _submitCandidate(int number) async {
    var num = await Api().submit('exit_poll', {'candidateNumber': number});
    return num;
  }

  Future<List<CandidateItem>> _loadCandidate() async {
    List list = await Api().fetch('exit_poll');
    var candidateList =
        list.map((item) => CandidateItem.fromJson(item)).toList();
    return candidateList;
  }

  @override
  void initState() {
    super.initState();

    _futurecandidateList = _loadCandidate();
    /*
    _loadCandidate().then((list) {
      _candidateList = list;
    });
     */
  }
}
/*
return Container(
      child: _candidateList == null
          ? SizedBox.shrink()
          : Container(
              decoration: const BoxDecoration(color: Colors.lightBlue),
              child: ListView.builder(
                itemCount: _candidateList.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = _candidateList[index];
                  return Card(
                    child: InkWell(
                      onTap: () => _handleClickItem(item),
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
                                children: [
                                  Text(
                                    '${item.title} ${item.fullName}',
                                    style: TextStyle(fontSize: 20.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(onPressed: (){}, child: Text("ดูผล"))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
 */
