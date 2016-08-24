package body Sockets is

   procedure Receive (Node : Socket; Buffer : out String; Count : out Integer) is
   begin
      Count := Integer (recv (To_C (Node), Buffer'Address, Buffer'Length, 0));
      if Count < 0 then
         raise Program_Error with "recv() < 0";
      end if;
      null;
   end;

   procedure Receive (Node : Socket; Item : in out Parseable_Buffer) is
      Count : Integer;
   begin
      Receive (Node, Item.Data (Item.Last + 1 .. Item.Data'Last), Count);
      Item.Last := Item.Last + Count;
      Item.Number_Of_Receive := Item.Number_Of_Receive + 1;
   end;

   function Is_Terminated (Item : Parseable_Buffer; Terminator : String) return Boolean is
      Result : Boolean;
   begin
      Result := Item.Data (Item.Last - Terminator'Length + 1 .. Item.Data'Last) = Terminator;
      return Result;
   end;



end Sockets;
