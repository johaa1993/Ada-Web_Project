with Ada.Characters.Latin_1;
with Ada.Strings.Fixed;
with Ada.Streams;
with GNAT.Sockets;

package HTTP is

   use Ada.Characters.Latin_1;

   --type Stream_Access is access all Ada.Streams.Root_Stream_Type'Class;
   subtype Stream_Access is GNAT.Sockets.Stream_Access;

   End_Of_Line_Seq : constant String := CR & LF;

   package Methods is
      type Method is (Option, Get, Head, Post, Put, Delete, Trace, Connect, Unknown);
   end;

   subtype Method_String is String (1 .. Methods.Method'Width);
   subtype URI_String is String (1 .. 100);
   subtype HTTP_Version_String is String (1 .. 40);

   type Request_Line is record
      Method_Text : Method_String := (others => NUL);
      URI_Text : URI_String := (others => NUL);
      HTTP_Version_Text : HTTP_Version_String := (others => ':');
   end record;

   procedure Read_Request_Line (Stream : Stream_Access; R : out Request_Line);
   procedure Put (R : Request_Line);

   procedure Read_File (Filename : String; Item : out String);

end HTTP;
