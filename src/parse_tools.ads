with Drake.References.Strings; use Drake.References.Strings;

package Parse_Tools is

   type Iterator is private;
   function Init (Source : String) return Iterator;
   procedure Parse (I : in out Iterator; Source : String; Pattern : String);
   function Get_Reference (I : Iterator; Source : aliased in out String) return Slicing.Reference_Type;
   function Get (I : Iterator; Source : String) return String;
   function End_Of_Line (I : Iterator; Source : String) return Boolean;

private

   type Iterator is record
      A : Integer;
      B : Integer;
   end record;

end Parse_Tools;
