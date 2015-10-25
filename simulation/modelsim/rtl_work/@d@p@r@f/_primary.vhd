library verilog;
use verilog.vl_types.all;
entity DPRF is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enWrite         : in     vl_logic;
        selRegWrite     : in     vl_logic_vector(3 downto 0);
        selRegRead1     : in     vl_logic_vector(3 downto 0);
        selRegRead2     : in     vl_logic_vector(3 downto 0);
        writeData       : in     vl_logic_vector(31 downto 0);
        dataout1        : out    vl_logic_vector(31 downto 0);
        dataout2        : out    vl_logic_vector(31 downto 0)
    );
end DPRF;
