
import 'package:papyrus/utilities/brain.dart';

void main(){
  Brain b = Brain();
  print(b);
  for (int i = 0; i < 10; i++){
    b.create(i.toString());
  }
  print(b);
}