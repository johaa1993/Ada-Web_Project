with Ada.Unchecked_Conversion;
with System;
package body Drake.References is
   pragma Suppress (All_Checks);

   package body Generic_Slicing is

      function Constant_Slice (Item : aliased Array_Type; First : Index_Type; Last : Index_Type'Base) return Constant_Reference_Type is
      begin
         return Result : Constant_Reference_Type := (Element => Item'Access, First => First, Last => Last) do
            declare
               type Repr is record
                  Data : System.Address;
                  Constraints : System.Address;
               end record with Suppress_Initialization;
               R : Repr;
               for R'Address use Result.Element'Address;
            begin
               R.Data := Item (First)'Address;
               R.Constraints := Result.First'Address;
            end;
         end return;
      end Constant_Slice;

      function Slice (Item : aliased in out Array_Type; First : Index_Type; Last : Index_Type'Base) return Reference_Type is
         type Constant_Slice_Type is access function (Item : aliased Array_Type; First : Index_Type; Last : Index_Type'Base) return Constant_Reference_Type;
         type Variable_Slice_Type is access function (Item : aliased in out Array_Type; First : Index_Type; Last : Index_Type'Base) return Reference_Type;
         function Cast is new Ada.Unchecked_Conversion (Constant_Slice_Type, Variable_Slice_Type);
      begin
         return Cast (Constant_Slice'Access) (Item, First, Last);
      end Slice;

   end Generic_Slicing;

end Drake.References;
