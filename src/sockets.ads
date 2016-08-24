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

   type Parseable_Buffer (Size : Natural) is record
      Data : String (1 .. Size);
      First : Integer := 0;
      Last : Integer := 0;
      Number_Of_Receive : Natural := 0;
   end record;

   procedure Receive (Node : Socket; Item : in out Parseable_Buffer);

   function Is_Terminated (Item : Parseable_Buffer; Terminator : String) return Boolean;

end Sockets;
