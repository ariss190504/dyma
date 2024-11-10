import 'package:flutter/material.dart';

Future<String?> askModal(BuildContext context, String question){
  return Navigator.push(context, PageRouteBuilder(pageBuilder: (context, _, __ ){
    return AskModal(question: question);
  }, opaque: false));
}

class AskModal extends StatelessWidget {
  final String question;

  AskModal({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      child: Card(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(question),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: (){
                      Navigator.pop(context, 'ok');
                    },
                    child: Text('ok'),

                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context, 'annuler');
                      },
                      child: Text('annnuler')
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
