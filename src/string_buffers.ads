

package String_Buffers is



   type Buffer (Size : Natural) is record
      Data : String (1 .. Size);
      Last : Natural := 0;
   end record;

   procedure Append (Container : in out Buffer; Item : String);

   function Is_Fitting (Container : Buffer; Item : String) return Boolean;
   function Is_Full (Container : Buffer) return Boolean;
   function Is_Empty (Container : Buffer) return Boolean;

   type Accessor (Data : access String) is limited private with Implicit_Dereference => Data;
   function Get (Item : Buffer) return Accessor;
   function Get_Free_Space (Item : Buffer) return Accessor;
   procedure Decrease_Free_Space (Item : in out Buffer; Count : Natural);

private
   type Accessor (Data : access String) is null record;


end;
