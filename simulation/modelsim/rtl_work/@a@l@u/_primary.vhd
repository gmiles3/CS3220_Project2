library verilog;
use verilog.vl_types.all;
entity ALU is
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
    port(
        clk             : in     vl_logic;
        opsel           : in     vl_logic_vector(3 downto 0);
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
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
end ALU;
