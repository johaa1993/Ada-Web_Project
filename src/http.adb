with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
with Ada.Strings.Fixed;
with LW_HTTP_Parser;

package body HTTP is

   procedure Put (R : Request_Line) is
      use Ada.Text_IO;
   begin
      Put ("Method (");
      Put (R.Method_Text);
      Put (")");
      New_Line;

      Put ("URI (");
      Put (R.URI_Text);
      Put (")");
      New_Line;

      Put ("HTTP (");
      Put (R.HTTP_Version_Text);
      Put (")");
      New_Line;
   end;

   procedure Read_Request_Line (Stream : Stream_Access; R : out Request_Line) is
      use Ada.Characters.Latin_1;
      Last : Integer;
   begin
      Last := 0;
      LW_HTTP_Parser.Read_Until (Stream, Space, Last, R.Method_Text);
      Last := 0;
      LW_HTTP_Parser.Read_Until (Stream, Space, Last, R.URI_Text);
      Last := 0;
      LW_HTTP_Parser.Read_Until (Stream, CR, Last, R.HTTP_Version_Text);
      LW_HTTP_Parser.Read_Until (Stream, LF, Last, R.HTTP_Version_Text);
      -- TODO add error handling
   end;

   procedure Read_File (Filename : String; Item : out String) is
      use Ada.Text_IO;
      use Ada.Text_IO.Text_Streams;
      F : File_Type;
   begin
      Open (F, In_File, Filename);
      for I in Item'Range loop
         Item (I) := Character'Input (Stream (F));
         exit when End_Of_File (F);
      end loop;
      Close (F);
   end;

end HTTP;
