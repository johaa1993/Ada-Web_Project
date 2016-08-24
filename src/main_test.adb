with GNAT.Sockets;
with Ada.Text_IO;
with Ada.Streams;
with Sockets;
with HTTP;

procedure Main_Test is
   use Ada.Text_IO;
   use GNAT.Sockets;
   use Ada.Streams;
   Write_Set : Socket_Set_Type;
   Read_Set : Socket_Set_Type;
   Status : Selector_Status;
   Selector : Selector_Type;
   Server_Socket : Socket_Type;
   Client_Socket : Socket_Type;
   Client_Address : Sock_Addr_Type;
   Request_No_Block : Request_Type := (Non_Blocking_IO, True);
   Client_Data : Sockets.Parseable_Buffer (5000);
   C : Character;
begin
   Initialize;
   Empty (Write_Set);
   Empty (Read_Set);

   -- Server config
   Create_Socket (Server_Socket);
   Set_Socket_Option (Server_Socket, Socket_Level, (Reuse_Address, True));
   Bind_Socket (Server_Socket, (Family => Family_Inet, Addr => Any_Inet_Addr, Port => 8000));
   Listen_Socket (Server_Socket);
   Create_Selector (Selector);

   Accept_Socket (Server_Socket, Client_Socket, Client_Address);
   Put_Line ("Client connected from " & Image (Client_Address));
   Control_Socket (Client_Socket, Request_No_Block);

   loop
      Get_Immediate (C);
      Put_Line (C'Img);

      Set (Read_Set, Client_Socket);
      Check_Selector (Selector, Read_Set, Write_Set, Status);
      Put_Line ("Status " & Status'Img);
      Empty (Read_Set);

      Sockets.Receive (Client_Socket, Client_Data);
      Put_Line ("Last " & Client_Data.Last'Img);
      Put_Line ("Buffer ");
      Put (Client_Data.Data (Client_Data.Data'First .. Client_Data.Last));
      New_Line;

      Put_Line ("Method: " & HTTP.Parse_Method (Client_Data)'Img);
      Put_Line ("URI: " & HTTP.Parse_URI (Client_Data));

      exit when C = 'q';
   end loop;




end;
