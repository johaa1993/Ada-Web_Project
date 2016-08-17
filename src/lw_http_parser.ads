with GNAT.Sockets;

package LW_HTTP_Parser is

   subtype Stream_Access is GNAT.Sockets.Stream_Access;

   procedure Read_Until (Stream : Stream_Access; C : Character; Last : in out Integer; Item : out String);

end;
