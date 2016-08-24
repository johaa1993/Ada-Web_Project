with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
with Ada.Strings.Fixed;
with Sockets;

package body HTTP is

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

   function Is_Request (Item : Parseable_Buffer) return Boolean is
   begin
      return Is_Terminated (Item, CR & LF & CR & LF);
   end;

   function Parse_Method (Source : String) return Methods.Method  is
   begin
      if Source'Length = 3 then
         if Source = "GET" then
            return Methods.Get;
         end if;
      end if;
      return Methods.Unknown;
   end Parse_Method;

   function Parse_Method (Source : in out Parseable_Buffer) return Methods.Method  is
      First : Integer := Source.First + 1;
   begin
      loop
         Source.First := Source.First + 1;
         exit when Source.First = Source.Last;
         exit when Source.Data (Source.First) = ' ';
      end loop;
      -- (- 1) to exlude the ' ' character.
      return Parse_Method (Source.Data (First .. Source.First - 1));
   end;

   function Parse_URI (Source : in out Parseable_Buffer) return String is
      First : Integer := Source.First + 1;
   begin
      loop
         Source.First := Source.First + 1;
         exit when Source.First = Source.Last;
         exit when Source.Data (Source.First) = ' ';
      end loop;
      -- (- 1) to exlude the ' ' character.
      return Source.Data (First .. Source.First - 1);
   end;

end HTTP;
