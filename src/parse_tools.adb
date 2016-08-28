

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

   procedure Parse_Find_Inclusive_Interval (Source : String; Pattern : String; A : out Integer; B : in out Integer) is
   begin
      A := B + 1;
      B := Parse_Find_Inclusive (Source (A .. Source'Last), Pattern);
   end;

   function Init_Interval (Source : String) return Interval is
   begin
      return (Source'First, Source'First - 1);
   end;


   procedure Parse_Find_Inclusive_Interval (Source : String; Pattern : String; I : in out Interval) is
   begin
      Parse_Find_Inclusive_Interval (Source, Pattern, I.A, I.B);
   end;

end Parse_Tools;
