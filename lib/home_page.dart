import 'package:api_testing/api_wrapper/api_wrapper.dart';
import 'package:api_testing/model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> data = [];
  final _controller = ScrollController();
  int page = 1;
  int limit = 10;

  Future getData() async {
    var fetchData = await ApiWrapper.getTodoList(limit, page);
    if (fetchData != null) {
      var tempData = List.from(data);
      tempData.addAll(fetchData);
      data = List.from(tempData);
    }
    setState(() {
      page++;
    });
  }

  Future getMoreData() async {
    var fetchData = await ApiWrapper.getTodoList(limit, page);
    if (fetchData != null) {
      var tempData = List.from(data);
      tempData.addAll(fetchData);
      data = List.from(tempData);
    }
    setState(() {
      page++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
    setScrollController();
  }

  setScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: listView(),
    );
  }

  Widget listView() {
    return ListView.separated(
      controller: _controller,
      shrinkWrap: true,
      itemCount: data.length + 1,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return data.length != index
            ? Column(
                children: [
                  Text(data[index].id.toString()),
                  const SizedBox(height: 10),
                  Text(data[index].body.toString()),
                ],
              )
            : const Center(child: CircularProgressIndicator());
      },
      separatorBuilder: (context, index) {
        return const Divider(color: Colors.black);
      },
    );
  }
}
