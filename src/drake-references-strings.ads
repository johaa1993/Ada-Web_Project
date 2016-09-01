pragma License (Unrestricted);

package Drake.References.Strings is

   pragma Pure;

   type Constant_Reference_Type (Element : not null access constant String) is null record with Implicit_Dereference => Element;
   pragma Suppress_Initialization (Constant_Reference_Type);

   type Reference_Type (Element : not null access String) is null record with Implicit_Dereference => Element;
   pragma Suppress_Initialization (Reference_Type);

   package Slicing is new Generic_Slicing (Positive, Character, String);

end;
