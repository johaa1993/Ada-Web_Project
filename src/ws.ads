with Ada.Characters.Latin_1;

package WS is

   use Ada.Characters.Latin_1;

   Header : String :=
     "HTTP/1.1 101 Switching Protocols" & CR&LF &
     "Upgrade: websocket" & CR&LF &
     "Connection: Upgrade" & CR&LF &
     "Sec-WebSocket-Accept: {0}" & CR&LF&CR&LF;

end WS;
