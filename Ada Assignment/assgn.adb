with Ada.Text_IO; use Ada.Text_IO;

package body Assgn is 

   --initialize first array (My_Array) with random binary values
   procedure Init_Array (Arr: in out BINARY_ARRAY) 
    is
    begin
        Arr(16) := BINARY_NUMBER(1);
        for I in 1..15 loop
            Arr(I) := BINARY_NUMBER(0);
        end loop;
    end Init_Array;

   procedure Reverse_Bin_Arr (Arr : in out BINARY_ARRAY) 
    is
        NewArr : BINARY_ARRAY;
        index  : INTEGER;
    
    begin
        for I in 1..16 loop
            index := abs(I-17);
            NewArr(I) := Arr(index);
        end loop;

        for I in 1..16 loop
            Arr(I) := NewArr(I);
        end loop;
    end Reverse_Bin_Arr;
   
   procedure Print_Bin_Arr (Arr : in BINARY_ARRAY)
    is
    begin
        for I in 1..16 loop
            Put(BINARY_NUMBER'Image (Arr(I)));
        end loop;
        New_Line;
    end Print_Bin_Arr;

   --Convert Integer to Binary Array
   function Int_To_Bin(Num : in INTEGER) return BINARY_ARRAY
    is
        Arr : BINARY_ARRAY;
        int : INTEGER;

    begin
        int := Num;
        for I in reverse 1..16 loop
            Arr(I) := int mod 2;
            int := int/2;
        end loop;

    return Arr;
    end Int_To_Bin;

   --convert binary number to integer
   function Bin_To_Int (Arr : in BINARY_ARRAY) return INTEGER
    is
        int    : INTEGER;
        revArr : BINARY_ARRAY;
        retval : INTEGER;

    begin
        retval := 0;
        int := 0;
        revArr := Arr;
        Reverse_Bin_Arr(revArr);        

        for I in 0..15 loop
            int := 2**I * revArr(I+1);
            retval := retval + int;
        end loop;

    return retval;
    end Bin_To_Int;

   --overloaded + operator to add two BINARY_ARRAY types together
   function "+" (Left, Right : in BINARY_ARRAY) return BINARY_ARRAY
    is
        sum    : INTEGER;
        carry  : INTEGER;
        retval : BINARY_ARRAY;

    begin
        sum   := 0;
        carry := 0;

        for I in reverse 1..16 loop
            sum := Left(I) + Right(I) + carry;
            retval(I) := sum mod 2;
            
            if sum > 1 then
                carry := 1;
            else
                carry := 0;
            end if;
        end loop;
        return retval;
    end "+";

   --overloaded + operator to add an INTEGER type and a BINARY_ARRAY type together
   function "+" (Left : in INTEGER;
                 Right : in BINARY_ARRAY) return BINARY_ARRAY
    is
        LeftArr : BINARY_ARRAY;
        retval  : BINARY_ARRAY;

    begin
        LeftArr := Int_To_Bin(Left);
        retval := LeftArr + Right;
        
        return retval;
    end "+";

   --overloaded - operator to subtract one BINARY_ARRAY type from another			 
   function "-" (Left, Right : in BINARY_ARRAY) return BINARY_ARRAY
    is
        RightComplement : BINARY_ARRAY;
        retval : BINARY_ARRAY;
        index  : INTEGER;
    
    begin
        -- Flip binary number and add one.
        for I in 1..16 loop
            RightComplement(I) := (Right(I) + 1) mod 2;
        end loop;
        RightComplement := INTEGER(1) + RightComplement;

        -- Add binary numbers.
        retval := RightComplement + Left;

        return retval;
    end "-";

   --overloaded - operator to subtract a BINARY_ARRAY type from an INTEGER type
   function "-" (Left : in Integer;
                 Right : in BINARY_ARRAY) return BINARY_ARRAY
    is
        LeftArr : BINARY_ARRAY;
        retval  : BINARY_ARRAY;

    begin
        LeftArr := Int_To_Bin(Left);
        retval := LeftArr - Right;

        return retval;
    end "-";

end Assgn;
