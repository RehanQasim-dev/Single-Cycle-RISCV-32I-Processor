`include "RISC_V.sv"

module RISC_V_tb;
  logic rst, clk;
  RISC_V RISC_R_instance (
      .clk(clk),
      .rst(rst)
  );

  //clock generation
  localparam CLK_PERIOD = 2;
  initial begin
    clk = 0;
    forever begin
      #(CLK_PERIOD / 2);
      clk = ~clk;
    end
  end
  //Testbench

  initial begin
    rst = 1;
    @(posedge clk);
    rst = 0;
    repeat (1000) @(posedge clk);
    $finish;
  end

  //Monitor values at posedge
  always @(posedge clk) begin
    $display("PC=%d x3=%h wdata=%h mem=%h", RISC_R_instance.data_path_instance.PC,
             RISC_R_instance.data_path_instance.Regfile_instance.mem[3],
             RISC_R_instance.data_path_instance.wdata,
             RISC_R_instance.data_path_instance.data_mem_instance.mem[0]);
  end
  initial begin
    $dumpfile("RISC_R_dump.vcd");
    $dumpvars;
  end
endmodule
