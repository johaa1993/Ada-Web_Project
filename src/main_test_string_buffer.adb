with Ada.Text_IO; use Ada.Text_IO;
with String_Buffers; use String_Buffers;

procedure Main_Test_String_Buffer is
   Container : Buffer (10);
begin

   loop
      Put_Line ("Is_Full:     " & Is_Full (Container)'Img);
      Put_Line ("Is_Empty:    " & Is_Empty (Container)'Img);
      Put_Line ("Last:        " & Container.Last'Img);
      New_Line;
      Put_Line ("Contains:    ");
      Put_Line (Container.Data);
      New_Line;
      Put_Line ("Free_Space:    ");
      Put_Line (Get_Free_Space (Container));
      New_Line;
      Put_Line ("Occupied_Space:    ");
      Put_Line (Get_Occupied_Space (Container));

      New_Line (3);
      Put ("Enter: ");
      declare
         Line : String := Get_Line;
      begin
         exit when Line'Length = 1 and then Line (Line'First .. Line'First) = "q";
         Put_Line ("Is_Fitting:   " & Is_Fitting (Container, Line)'Img);
         if True or Is_Fitting (Container, Line) then
            Append (Container, Line);
         end if;
      end;



   end loop;


end;
