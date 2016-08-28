package Parse_Tools is

   type Interval is record
      A : Integer;
      B : Integer;
   end record;

   function Init_Interval (Source : String) return Interval;

   function Parse_Find_Inclusive (Source : String; Pattern : String) return Integer;
   procedure Parse_Find_Inclusive_Interval (Source : String; Pattern : String; A : out Integer; B : in out Integer);
   procedure Parse_Find_Inclusive_Interval (Source : String; Pattern : String; I : in out Interval);

end Parse_Tools;
