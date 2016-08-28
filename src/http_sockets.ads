with Parse_Tools;
with Sockets;
with String_Buffers; use String_Buffers;

package HTTP_Sockets is

   use Parse_Tools;
   use Sockets;

   type Client (Size : Natural) is record
      Node : Socket;
      Data : String_Buffers.Buffer (Size);
      Receive_Count : Natural := 0;
      End_Of_Data : Boolean := False;
   end record;

   type Parseable_Buffer (Size : Natural) is record
      Data : String (1 .. Size);
      Last : Natural := 0;
      Section : Interval := (1, 0);
      Receive_Count : Natural := 0;
      End_Of_Data : Boolean := False;
      Valid : Boolean := True;
   end record;

   --procedure Accept_Client ();
   procedure Receive (Node : Socket; Item : in out Parseable_Buffer);



   function Parse_Method (Source : in out Parseable_Buffer) return String;
   function Parse_URI (Source : in out Parseable_Buffer) return String;
   function Parse_HTTP_Version (Source : in out Parseable_Buffer) return String;
   function Parse_Field_Name (Source : in out Parseable_Buffer) return String;
   function Parse_Field_Value (Source : in out Parseable_Buffer) return String;


end HTTP_Sockets;
