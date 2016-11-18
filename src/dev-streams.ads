with Ada.Streams; use Ada.Streams;

package Dev.Streams is

   procedure Read (Stream : not null access Root_Stream_Type'Class; Buffer : in out Stream_Element_Array);

end Dev.Streams;
