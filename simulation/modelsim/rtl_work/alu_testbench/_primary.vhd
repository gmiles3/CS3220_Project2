library verilog;
use verilog.vl_types.all;
entity alu_testbench is
    generic(
        ADD             : integer := 0;
        SUB             : integer := 1;
        \AND\           : integer := 2;
        \OR\            : integer := 3;
        \XOR\           : integer := 4;
        \NAND\          : integer := 5;
        \NOR\           : integer := 6;
        \XNOR\          : integer := 7;
        MVHI            : integer := 8
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADD : constant is 1;
    attribute mti_svvh_generic_type of SUB : constant is 1;
    attribute mti_svvh_generic_type of \AND\ : constant is 1;
    attribute mti_svvh_generic_type of \OR\ : constant is 1;
    attribute mti_svvh_generic_type of \XOR\ : constant is 1;
    attribute mti_svvh_generic_type of \NAND\ : constant is 1;
    attribute mti_svvh_generic_type of \NOR\ : constant is 1;
    attribute mti_svvh_generic_type of \XNOR\ : constant is 1;
    attribute mti_svvh_generic_type of MVHI : constant is 1;
end alu_testbench;
