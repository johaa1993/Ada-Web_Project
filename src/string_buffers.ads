with Drake.References.Strings; use Drake.References.Strings;

package String_Buffers is

   type Buffer (Size : Natural) is private;
   type String_Access is access all String;

   procedure Append (Container : in out Buffer; Item : String);

   function Is_Fitting (Container : Buffer; Item : String) return Boolean;
   function Is_Full (Container : Buffer) return Boolean;
   function Is_Empty (Container : Buffer) return Boolean;

   function Get_Occupied_Space_Reference (Item : in out Buffer) return String_Access;
   function Get_Free_Space_Reference (Item : in out Buffer) return String_Access;

   function Get_Occupied_Space (Item : Buffer) return String;
   function Get_Free_Space (Item : Buffer) return String;

   procedure Decrease_Free_Space (Item : in out Buffer; Count : Natural);


private

   type Buffer (Size : Natural) is record
      Data : aliased String (1 .. Size);
      Last : Natural := 0;
   end record;

end;
