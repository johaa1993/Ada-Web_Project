with Ada.Characters.Latin_1;
with Ada.Strings.Fixed;
with Ada.Streams;
with Sockets;


package HTTP is

   use Ada.Characters.Latin_1;
   use Ada.Streams;
   use Sockets;

   End_Of_Line_Seq : constant String := CR & LF;

   package Methods is
      type Method is (Option, Get, Head, Post, Put, Delete, Trace, Connect, Unknown);
   end;

   procedure Read_File (Filename : String; Item : out String);

   function Parse_Method (Source : in out Parseable_Buffer) return Methods.Method;
   function Parse_URI (Source : in out Parseable_Buffer) return String;

end HTTP;
