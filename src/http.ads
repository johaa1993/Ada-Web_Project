with Ada.Characters.Latin_1;
with Ada.Strings.Fixed;
with Ada.Streams;

package HTTP is

   use Ada.Characters.Latin_1;

   End_Of_Line_Seq : constant String := CR & LF;

   package Methods is
      type Method is (Option, Get, Head, Post, Put, Delete, Trace, Connect, Unknown);
   end;

   subtype Method_String is String (1 .. Methods.Method'Width);
   subtype URI_String is String (1 .. 100);
   subtype HTTP_Version_String is String (1 .. 100);

   type Request_Line is record
      Method_Text : Method_String := (others => NUL);
      URI_Text : URI_String := (others => NUL);
      HTTP_Version_Text : HTTP_Version_String := (others => NUL);
   end record;

   procedure Read_Line (Stream : not null access Ada.Streams.Root_Stream_Type'Class; Item : out String; P : in out Natural);
   procedure Read_Request_Line (Stream : not null access Ada.Streams.Root_Stream_Type'Class; R : out Request_Line);
   procedure Put (R : Request_Line);

   procedure Read_File (Filename : String; Item : out String);

end HTTP;
