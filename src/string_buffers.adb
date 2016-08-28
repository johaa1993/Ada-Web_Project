package body String_Buffers is

   function Is_Full (Container : Buffer) return Boolean is
   begin
      return Container.Last >= Container.Data'Last;
   end;

   function Is_Empty (Container : Buffer) return Boolean is
   begin
      return Container.Last = 0;
   end;

   function Is_Fitting (Container : Buffer; Item : String) return Boolean is
   begin
      return Container.Data'Last - Container.Last >= Item'Length;
   end;

--     procedure Insert (Container : in out String; Item : String) is
--        pragma Assert (Item'Length > Container'Length, "Item is larger than container.");
--        pragma Assert (Item'First in Container'Range, "Item'First is not in Container'Range.");
--        pragma Assert (Item'Last in Container'Range, "Item'Last is not in Container'Range.");
--     begin
--        Container (Item'Range) := Item;
--     end;

   procedure Append (Container : in out Buffer; Item : String) is
      subtype Data_Index is Positive range Container.Data'First .. Container.Data'Last;
      pragma Assert (Is_Fitting (Container, Item), "Reason: External. Container is too small.");
      subtype Item_Index is Data_Index range Container.Last + 1 .. Container.Last + Item'Length;
      pragma Assert (Container.Data (Item_Index)'Length = Item'Length, "Reason: Internal problem. Item_Index'Length /= Item'Length");
   begin
      Container.Data (Item_Index) := Item;
      Container.Last := Item_Index'Last;
   end;

   function Get (Item : Buffer) return Accessor is
   begin
      return Accessor'(Data => Item.Data (Item.Data'First .. Item.Last)'Unrestricted_Access);
   end;

   function Get_Free_Space (Item : Buffer) return Accessor is
   begin
      return Accessor'(Data => Item.Data (Item.Last + 1 .. Item.Data'Last)'Unrestricted_Access);
   end;

   procedure Decrease_Free_Space (Item : in out Buffer; Count : Natural) is
   begin
      Item.Last := Item.Last + Count;
   end;

end String_Buffers;
