with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;

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

   function Convert (Source : String) return Methods.Method  is
   begin
      if Source'Length = 3 then
         if Source = "GET" then
            return Methods.Get;
         end if;
      end if;
      return Methods.Unknown;
   end;

end HTTP;
