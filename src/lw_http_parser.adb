with Ada.Characters.Latin_1;

package body LW_HTTP_Parser is

   function Read_Next (Stream : Stream_Access; Last : in out Integer; Item : out String) return Character is
   begin
      Last := Last + 1;
      Character'Read (Stream, Item (Last));
      return Item (Last);
   end;

   procedure Read_Until (Stream : Stream_Access; C : Character; Last : in out Integer; Item : out String) is
   begin
      loop
         exit when Last >= Item'Last;
         exit when Read_Next (Stream, Last, Item) = C;
      end loop;
   end;

   function Read_Terminator (Stream : Stream_Access; Last : in out Integer; Item : out String) return Boolean is
      use Ada.Characters.Latin_1;
   begin
      if Last < Item'Last and then Read_Next (Stream, Last, Item) = CR then
         if Last < Item'Last and then Read_Next (Stream, Last, Item) = LF then
            return True;
         end if;
      end if;
      return False;
   end;

   function Read_Find_Fieldname (Stream : Stream_Access; Keyword : String; Last : in out Integer; Item : out String) return Boolean is
   begin
      loop
         Read_Until (Stream, ':', Last, Item);
         if Item (Item'First .. Last - 1) = Keyword then
            return True;
         else
            return False;
         end if;
      end loop;
   end;

end;
