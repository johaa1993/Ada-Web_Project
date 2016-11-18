with GNAT.Sockets;

package String_Buffers.Sockets is

   subtype Socket is GNAT.Sockets.Socket_Type;

   procedure Receive (Node : Socket; Item : in out Buffer);

end;
