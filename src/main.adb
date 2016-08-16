with Ada.Text_IO;
with Ada.IO_Exceptions;
with GNAT.Sockets;
with Ada.Characters.Latin_1;
with Ada.Streams;
with HTTP;
with WS;
with Ada.Strings.Fixed;

procedure Main is
   use GNAT.Sockets;
   use Ada.Text_IO;
   use Ada.Characters.Latin_1;

   procedure Handle_Client (S : Socket_Type; C : Stream_Access) is
      Response : String (1 .. 1000) := (others => NUL);
      Req : HTTP.Request_Line;
   begin
      New_Line;
      HTTP.Read_Request_Line (C, Req);
      HTTP.Put (Req);
      New_Line;

      HTTP.Read_File ("test", Response);
      String'Write (C, Response);
      Shutdown_Socket (S, Shut_Write); --Send FIN
   end;

   Receiver   : Socket_Type;
   Connection : Socket_Type;
   Client     : Sock_Addr_Type;
   Channel    : Stream_Access;
begin
   Initialize;

   -- Server config
   Create_Socket (Receiver);
   Set_Socket_Option (Receiver, Socket_Level, (Name => Reuse_Address, Enabled => True));
   Bind_Socket (Receiver, (Family => Family_Inet, Addr => Any_Inet_Addr, Port => 80));
   Listen_Socket (Receiver);

   loop
      Accept_Socket (Receiver, Connection, Client);
      Put_Line ("Client connected from " & Image (Client));
      Channel := Stream (Connection);
      Handle_Client (Connection, Channel);
      Close_Socket (Connection);
   end loop;

   Finalize;
end;
