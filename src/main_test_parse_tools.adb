with Ada.Text_IO; use Ada.Text_IO;
with Parse_Tools; use Parse_Tools;

procedure Main_Test_Parse_Tools is

   A : aliased String := "Hello,:,Character,:,Goes,:,Bananas";
   I : Iterator := Init (A);
   C : Character;

   procedure F (Item : out String) is
   begin
      Put_Line ("L: " & Item'Length'Img);
      Item (Item'Last - 2 .. Item'Last) := (others => '#');
   end F;

begin

   loop
      Get_Immediate (C);
      exit when C = 'q';

      Parse (I, A, ",:,");
      F (Get_Reference (I, A));
      exit when End_Of_Line (I, A);
      Put_Line (Get (I, A));

   end loop;

end;
