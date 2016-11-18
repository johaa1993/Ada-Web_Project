with Ada.Streams;
with Interfaces;
with Interfaces.C;
with System;
with Ada.Text_IO;
with Ada.Unchecked_Conversion;

package body String_Buffers.Sockets is

   procedure Receive (Node : Socket; Item : out Buffer; Count : out Integer) is
      subtype int is Interfaces.C.int;
      function recv (sockfd : int; buf : Address; len : int; flags : int) return int with
        Import,
        Convention => Stdcall,
        External_Name => "recv";
      function To_C (Node : Socket) return int is (int (GNAT.Sockets.To_C (Node)));
   begin
      Count := Integer (recv (To_C (Node), Get_Free_Space_Address (Item), int (Get_Free_Space_Length (Item)), 0));
      pragma Assert (Count >= 0, "Count > 0 = false");
   end;

   procedure Receive (Node : Socket; Item : in out Buffer) is
      Count : Natural;
   begin
      pragma Assert (Get_Free_Space_Length (Item) > 0, "No space!");
      Receive (Node, Item, Count);
      Decrease_Free_Space (Item, Count);
      Ada.Text_IO.Put_Line ("Free_Space_Length " & Get_Free_Space_Length (Item)'Img);
   end;

end String_Buffers.Sockets;
