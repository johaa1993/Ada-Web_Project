with Ada.Unchecked_Conversion;

package body String_Buffers is

   function Get_Free_Space_Index_First (Item : Buffer) return Natural is            (Item.Last + 1);
   function Get_Free_Space_Index_Last (Item : Buffer) return Natural is             (Item.Data'Last);
   function Get_Free_Space_Length (Item : Buffer) return Natural is                 (Item.Data (Get_Free_Space_Index_First (Item) .. Get_Free_Space_Index_Last (Item))'Length);
   function Get_Free_Space_Access (Item : in out Buffer) return String_Access is    (Item.Data (Get_Free_Space_Index_First (Item) .. Get_Free_Space_Index_Last (Item))'Unrestricted_Access);
   function Get_Free_Space (Item : Buffer) return String is                         (Item.Data (Get_Free_Space_Index_First (Item) .. Get_Free_Space_Index_Last (Item)));
   function Get_Free_Space_Address (Item : in out Buffer) return Address is         (Item.Data (Get_Free_Space_Index_First (Item))'Address);

   function Get_Occupied_Space_Index_First (Item : Buffer) return Natural is            (Item.Data'First);
   function Get_Occupied_Space_Index_Last (Item : Buffer) return Natural is             (Item.Last);
   function Get_Occupied_Space_Length (Item : Buffer) return Natural is                 (Item.Data (Get_Occupied_Space_Index_First (Item) .. Get_Occupied_Space_Index_Last (Item))'Length);
   function Get_Occupied_Space_Access (Item : in out Buffer) return String_Access is    (Item.Data (Get_Occupied_Space_Index_First (Item) .. Get_Occupied_Space_Index_Last (Item))'Unrestricted_Access);
   function Get_Occupied_Space (Item : Buffer) return String is                         (Item.Data (Get_Occupied_Space_Index_First (Item) .. Get_Occupied_Space_Index_Last (Item)));
   function Get_Occupied_Space_Address (Item : in out Buffer) return Address is         (Item.Data (Get_Occupied_Space_Index_First (Item))'Address);

   function Is_Full (Container : Buffer) return Boolean is (Container.Last >= Container.Data'Last);
   function Is_Empty (Container : Buffer) return Boolean is (Container.Last = 0);
   function Is_Fitting (Container : Buffer; Item : String) return Boolean is (Container.Data'Last - Container.Last >= Item'Length);

   procedure Append (Container : in out Buffer; Item : String) is
      subtype Data_Index is Positive range Container.Data'First .. Container.Data'Last;
      pragma Assert (Is_Fitting (Container, Item), "Reason: External. Container is too small.");
      subtype Item_Index is Data_Index range Container.Last + 1 .. Container.Last + Item'Length;
      pragma Assert (Container.Data (Item_Index)'Length = Item'Length, "Reason: Internal problem. Item_Index'Length /= Item'Length");
   begin
      Container.Data (Item_Index) := Item;
      Container.Last := Item_Index'Last;
   end;

   procedure Decrease_Free_Space (Item : in out Buffer; Count : Natural) is
   begin
      Item.Last := Item.Last + Count;
   end;

end String_Buffers;
