with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;

package body HTTP is

   procedure Read_Line (Stream : not null access Ada.Streams.Root_Stream_Type'Class; Item : out String; P : in out Natural) is
   begin
      loop
         Character'Read (Stream, Item (P));
         if Item (P) = CR then
            P := P + 1;
            Character'Read (Stream, Item (P));
            if Item (P) = LF then
               exit;
            end if;
         else
            P := P + 1;
         end if;
      end loop;
   end;

   procedure Read_Line (Stream : not null access Ada.Streams.Root_Stream_Type'Class; Item : out String) is
      P : Integer;
   begin
      P := Item'First;
      Read_Line (Stream, Item, P);
   end;

   procedure Read_Part (Stream : not null access Ada.Streams.Root_Stream_Type'Class; Item : out String; P : in out Natural) is
   begin
      loop
         Character'Read (Stream, Item (P));
         if Item (P) = ' ' then
            exit;
         end if;
         P := P + 1;
      end loop;
   end;

   procedure Read_Part (Stream : not null access Ada.Streams.Root_Stream_Type'Class; Item : out String) is
      P : Integer;
   begin
      P := Item'First;
      Read_Part (Stream, Item, P);
   end;

   function Read_Method (Stream : not null access Ada.Streams.Root_Stream_Type'Class) return Methods.Method is
      Method_Raw : String (1 .. Methods.Method'Width);
      P : Integer;
   begin
      P := Method_Raw'First;
      Read_Part (Stream, Method_Raw, P);
      P := P - 1;
      if P = 3 and then Method_Raw (Method_Raw'First .. P) = "GET" then
         return Methods.Get;
      elsif P = 4 and then Method_Raw (Method_Raw'First .. P) = "POST" then
         return Methods.Post;
      else
         return Methods.Unknown;
      end if;
   end;

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



   procedure Read_Request_Line (Stream : not null access Ada.Streams.Root_Stream_Type'Class; R : out Request_Line) is
   begin
      Read_Part (Stream, R.Method_Text);
      Read_Part (Stream, R.URI_Text);
      Read_Line (Stream, R.HTTP_Version_Text);
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
