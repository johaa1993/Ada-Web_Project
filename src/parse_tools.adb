

package body Parse_Tools is

   -- If Pattern is found in Source: return last index of the discovery.
   -- If Pattern is not found in Source: return > Source'Last.
   function Parse_Find_Inclusive (Source : String; Pattern : String) return Integer is
      P : Integer := Source'First;
      K : Integer := Pattern'First;
   begin
      loop
         pragma Assert (K in Pattern'Range, K'Img);
         if P > Source'Last then
            exit;
         elsif Source (P) = Pattern (K) then
            if K = Pattern'Last then
               exit;
            else
               K := K + 1;
            end if;
         else
            K := Pattern'First;
         end if;
         P := P + 1;
      end loop;
      return P;
   end;

   procedure Parse_AB (Source : String; Pattern : String; A : out Integer; B : in out Integer) is
   begin
      A := B + 1;
      B := Parse_Find_Inclusive (Source (A .. Source'Last), Pattern);
   end;

   function Init (Source : String) return Iterator is
   begin
      return (Source'First, Source'First - 1);
   end;

   procedure Parse (I : in out Iterator; Source : String; Pattern : String) is
   begin
      Parse_AB (Source, Pattern, I.A, I.B);
   end;

   function Get_Reference (I : Iterator; Source : aliased in out String) return Slicing.Reference_Type is
   begin
      return Slicing.Slice (Source, I.A, I.B);
   end;

   function Get (I : Iterator; Source : String) return String is
   begin
      return Source (I.A .. I.B);
   end;

   function End_Of_Line (I : Iterator; Source : String) return Boolean is
   begin
      return I.B > Source'Last;
   end;

end Parse_Tools;
