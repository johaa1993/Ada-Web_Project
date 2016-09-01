with Ada.Streams;
with Interfaces;
with Interfaces.C;
with System;
with Ada.Text_IO;

package body String_Buffers.Sockets is


   procedure Receive (Node : Socket; Buffer : out String; Count : out Integer) is
      use Interfaces.C;
      use System;
      use GNAT.Sockets;
      function recv (sockfd : int; buf : Address; len : int; flags : int) return int with
        Import,
        Convention => Stdcall,
        External_Name => "recv";
   begin
      Count := Integer (recv (int (To_C (Node)), Buffer'Address, Buffer'Length, 0));
      pragma Assert (Count >= 0, "Count > 0 = false");
   end;


   procedure Receive (Node : Socket; Container : in out Buffer) is
      Count : Natural;
   begin
      Receive (Node, Get_Free_Space_Reference (Container).all, Count);
      Decrease_Free_Space (Container, Count);
   end;

end String_Buffers.Sockets;
