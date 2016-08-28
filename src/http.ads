with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with HTTP_Sockets; use HTTP_Sockets;
with Parse_Tools; use Parse_Tools;

package HTTP is

   End_Of_Line_Seq : constant String := CR & LF;

   package Methods is
      type Method is (Option, Get, Head, Post, Put, Delete, Trace, Connect, Unknown);
   end;

   procedure Read_File (Filename : String; Item : out String);

   function Convert (Source : String) return Methods.Method;


end HTTP;
