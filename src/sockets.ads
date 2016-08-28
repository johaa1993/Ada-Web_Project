with GNAT.Sockets;
with Interfaces.C;
with System;
with Ada.Unchecked_Conversion;

package Sockets is

   use Interfaces.C;
   use System;

   subtype Socket is GNAT.Sockets.Socket_Type;
   function To_C is new Ada.Unchecked_Conversion (Socket, int);

   function recv (sockfd : int; buf : Address; len : int; flags : int) return int with
     Import,
     Convention => Stdcall,
     External_Name => "recv";

   procedure Receive (Node : Socket; Buffer : out String; Count : out Integer);

end Sockets;
