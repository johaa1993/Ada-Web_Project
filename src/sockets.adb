package body Sockets is

   procedure Receive (Node : Socket; Buffer : out String; Count : out Integer) is
   begin
      Count := Integer (recv (To_C (Node), Buffer'Address, Buffer'Length, 0));
      if Count < 0 then
         raise Program_Error with "recv() < 0";
      end if;
      null;
   end;



end Sockets;
