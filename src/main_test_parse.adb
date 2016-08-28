with Parse_Tools;
with Ada.Characters.Latin_1;
with Ada.Text_IO;

procedure Main_Test_Parse is
   use Parse_Tools;
   use Ada.Characters.Latin_1;
   use Ada.Text_IO;

   --B : Boolean;
   Test : String := "GET#/index.html#HTTP/1.1" & CR & LF & "Host: /index.html" & CR & LF & CR & LF;
   P : Integer := Test'First - 1;
   A, B : Integer;
begin

   B := Test'First - 1;

   Parse_Find_Inclusive_Interval (Test, "#", A, B);
   Put_Line (Test (A .. B));
   Parse_Find_Inclusive_Interval (Test, "+", A, B);
   pragma Assert (B in Test'Range, Test'Last'Img & B'Img);
   Put_Line (Test (A .. B));

   --Put_Line (Parse_Find_Inclusive (Test (P + 1 .. Test'Last), "#", P));
   --Put_Line (Parse_Find_Inclusive (Test (P + 1 .. Test'Last), "#", P));

end;
