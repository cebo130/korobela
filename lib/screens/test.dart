import 'package:flutter/material.dart';

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  List<Widget> _cardList = [];
  List<String> check = ['Widget1','Widget2','Widget3','Widget4'];
  TextEditingController note = TextEditingController();
  String word = "";
  int num = 1;
  bool validate = false;
  void _addCardWidget() {
    setState(() {
      //_cardList.add(_card());
      _cardList.add(more());
    });
  }
  int a = 0;
  void _removeShit(int index){
    setState(() {
    _cardList.removeAt(index);
      //check.removeAt(0);
    });
  }
  void incShit(){
    setState(() {
      a++;
      num++;
    });
  }
  Widget more(){
    return GestureDetector(
      child: Row(
        children: [
          Text('$num.'),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
              //width: 200,
                child: Text(note.text,maxLines: 7,)
            ),
          ),
        ],
      ),
      onTap: (){
        print('pressed');
       // String word+num = note.text;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Details(notes: word,)),//*****************************problem
        );
      },
    );
  }
  Widget _card() {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 5, left: 8, right: 8),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.orangeAccent[100],
      ),
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(
                  "https://i.pinimg.com/originals/71/83/70/7183704aac01413c86805c19c1586e2b.jpg"),
            ),
          ),
          title: Text(
            'widget $a',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.deepPurple),
          ),
          subtitle: Text(
            'Freedom Fighter',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
          ),
          trailing: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            /*child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 1,
                    ),

                  ],
                ),
              ),
            ),*/
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepPurple,
      appBar: AppBar(
        title: Text('Basic Notes App'),
        centerTitle: true,
        actions: [
          /*IconButton(
              icon: Icon(
                Icons.delete,
              ),
              onPressed: (){
               // _removeShit();
                //incShit();
              }
          )*/
        ],
      ),
      body: Column(
        children: [
          Container(
            //height: 80,
            margin: EdgeInsets.only(top: 5, left: 8, right: 8),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.orangeAccent[100],
            ),
              child: Column(
                children: [
                  TextField(
                    controller: note,
                      //onChanged: (v) => note.text = v,
                      decoration: InputDecoration(
                        labelText: 'Name the Pup',
                        errorText: validate ? 'Please type something man...' : null,
                      ),
                  ),
                  IconButton(
                    icon: Icon(Icons.check_circle),
                    onPressed: (){
                      setState(() {
                        if(note.text.isEmpty){

                          validate=true;
                        }else{
                          validate=false;
                          _addCardWidget();
                          incShit();
                          note.text='';
                        }
                        //note.text.isEmpty ? _validate = true : _validate = false;
                      });

                    },
                  ),
                ],
              ),
          ),
          SizedBox(height: 10,),
           Expanded(
            child: Container(
              color: Colors.deepPurple,
              //height: 600,
              child: ListView.builder(
                  itemCount: _cardList.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      child: Container(
                        height: 80,
                        margin: EdgeInsets.only(top: 5, left: 8, right: 8),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.orangeAccent[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 20,),
                            Container(width: 100,child: _cardList[index]),
                            Spacer(),
                            //SizedBox(width: 20,),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                ),
                                onPressed: (){
                                  _removeShit(index);
                                }
                            )
                          ],
                        ),
                      ),
                      onTap: (){
                        print('Not thats cool');

                      },
                    );

                  }),
            ),
          ),
        ],
      ),
      floatingActionButton:  FloatingActionButton(
        backgroundColor: Colors.pink,
          child: Icon(Icons.check_circle,color: Colors.green,),
          tooltip: 'Add',
          onPressed: (){
            setState(() {
              if(note.text.isEmpty){

                validate=true;
              }else{
                validate=false;
                _addCardWidget();
                incShit();
                note.text='';
              }
              //note.text.isEmpty ? _validate = true : _validate = false;
            });
          }

      ) ,
    );
  }
}

class Details extends StatelessWidget {
  final String notes;
  const Details({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(notes),
      ),
    );
  }
}
