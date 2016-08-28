with Ada.Text_IO; use Ada.Text_IO;
with String_Buffers; use String_Buffers;

procedure Main_Test_String_Buffer is
   Container : Buffer (10);
begin

   loop
      New_Line (3);
      Put_Line ("Is_Full:     " & Is_Full (Container)'Img);
      Put_Line ("Is_Empty:    " & Is_Empty (Container)'Img);
      Put_Line ("Last:        " & Container.Last'Img);
      Put_Line ("Contains:    ");
      Put_Line (Container.Data);
      Put_Line (Container.Data (Container.Data'First .. Container.Last));
      Put_Line (Get (Container));
      declare
         Line : String := Get_Line;
      begin
         exit when Line'Length = 1 and then Line (Line'First .. Line'First) = "q";
         Put_Line ("Is_Fitting:   " & Is_Fitting (Container, Line)'Img);
         if True or Is_Fitting (Container, Line) then
            Put_Line ("Appending:    ");
            Put_Line (Line);
            Append (Container, Line);
         end if;
      end;
   end loop;

end;
