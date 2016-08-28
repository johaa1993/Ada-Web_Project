with Ada.Characters.Latin_1;

package body HTTP_Sockets is

   function Is_Terminated (Item : String; Terminator : String) return Boolean is
      Result : Boolean;
      pragma Assert (Item'Length >= Terminator'Length, "Reason: Item'Length is less than Terminator'Length");
      subtype R is Integer range Item'Last - Terminator'Length + 1 .. Item'Last;
   begin
      Result := Item (R) = Terminator;
      return Result;
   end;

   function Is_Terminated (Item : Parseable_Buffer; Terminator : String) return Boolean is
   begin
      pragma Assert (Item.Last <= Item.Data'Last, "Reason: Item.Last = " & Item.Last'Img & " to large.");
      return Is_Terminated (Item.Data (Item.Data'First .. Item.Last), Terminator);
   end;

   procedure Receive (Node : Socket; Item : in out Parseable_Buffer) is
      use Ada.Characters.Latin_1;
      Count : Integer;
   begin
      Receive (Node, Item.Data (Item.Last + 1 .. Item.Data'Last), Count);
      Item.Last := Item.Last + Count;
      Item.Receive_Count := Item.Receive_Count + 1;
      Item.End_Of_Data := Is_Terminated (Item, CR & LF & CR & LF);
   end;


   procedure Receive (Item : in out Client) is
      use Ada.Characters.Latin_1;
      Count : Integer;
   begin
      Receive (Item.Node, Get_Free_Space (Item.Data), Count);
      Decrease_Free_Space (Item.Data, Count);
      Item.Receive_Count := Item.Receive_Count + 1;
      Item.End_Of_Data := Is_Terminated (Get (Item.Data), CR & LF & CR & LF);
   end;



   function Parse_Any (Source : in out Parseable_Buffer; Pattern : String) return String is
   begin
      pragma Assert (Source.Valid = True);
      Parse_Find_Inclusive_Interval (Source.Data (Source.Data'First .. Source.Last), " ", Source.Section);
      if Source.Section.B > Source.Last then
         Source.Valid := False;
         return "";
      else
         Source.Valid := True;
         return Source.Data (Source.Section.A .. Source.Section.B - Pattern'Length);
      end if;
   end Parse_Any;

   function Parse_Method (Source : in out Parseable_Buffer) return String is
      R : String := Parse_Any (Source, " ");
   begin
      return R;
   end;

   function Parse_URI (Source : in out Parseable_Buffer) return String is
      R : String := Parse_Any (Source, " ");
   begin
      return R;
   end;

   function Parse_HTTP_Version (Source : in out Parseable_Buffer) return String is
      use Ada.Characters.Latin_1;
      R : String := Parse_Any (Source, CR & LF);
   begin
      return R;
   end;


   function Parse_Field_Name (Source : in out Parseable_Buffer) return String is
      use Ada.Characters.Latin_1;
      R : String := Parse_Any (Source, ": ");
   begin
      return R;
   end;

   function Parse_Field_Value (Source : in out Parseable_Buffer) return String is
      use Ada.Characters.Latin_1;
      R : String := Parse_Any (Source, CR & LF);
   begin
      return R;
   end;

end HTTP_Sockets;
