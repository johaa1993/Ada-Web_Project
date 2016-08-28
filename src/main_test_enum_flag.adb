with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main_Test_Enum_Flag is
   type Flag is mod 2 ** 4;
   package IO is new Ada.Text_IO.Modular_IO (Flag); use IO;
   type T is (Flag_1, Flag_2, Flag_3);
   for T use (2#0001#, 2#0010#, 2#1000#);
   for T'Size use Flag'Size;
   function Bitwise (Item : T) return Flag is
   begin
      return Flag (Item'Enum_Rep);
   end;
begin

   Put (Bitwise (Flag_1) or Bitwise (Flag_2) or Bitwise (Flag_3), 4, 2);

   null;
end;
