library verilog;
use verilog.vl_types.all;
entity DPRF is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        we              : in     vl_logic;
        regsel_dest     : in     vl_logic_vector(3 downto 0);
        regsel_source0  : in     vl_logic_vector(3 downto 0);
        regsel_source1  : in     vl_logic_vector(3 downto 0);
        datain          : in     vl_logic_vector(31 downto 0);
        dataout0        : out    vl_logic_vector(31 downto 0);
        dataout1        : out    vl_logic_vector(31 downto 0)
    );
end DPRF;
