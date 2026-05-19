module final_filter(
    input wire clk,
    input wire reset,
    output wire signed [15:0] lpf_out,
    output wire signed [15:0] hpf_out,
    output wire signed [15:0] bpf_out,
    output wire signed [15:0] bsf_out
);

    parameter word_size_in  = 8;  
    parameter word_size_out = 16; 
    parameter ADDR_WIDTH    = 10;

    reg [ADDR_WIDTH-1:0] address;

    always @(posedge clk or posedge reset) begin
        if (reset)
            address <= 0;
        else
            address <= address + 1;   
    end

    wire [7:0] rom_data;

    ROM_SONG1 rom_inst (
        .clk(clk),
        .address(address),
        .data(rom_data)
    );

    wire signed [15:0] rom_data_s = {{8{rom_data[7]}}, rom_data};

    wire signed [15:0] filtered_lpf_data;
    wire signed [15:0] filtered_hpf_data;

    LPF lpf_inst(
        .Data_out(filtered_lpf_data),
        .Data_in(rom_data_s),
        .clk(clk),
        .rst(reset)
    );

    HPF hpf_inst(
        .Data_out(filtered_hpf_data),
        .Data_in(rom_data_s),
        .clk(clk),
        .rst(reset)
    );
    
     wire [word_size_out-1:0] data_lp = filtered_lpf_data; 
     wire [word_size_out-1:0] data_hp = filtered_hpf_data;    
       
     HPF  bpf(filtered_bpf_data,
                             data_lp,
                             clk,
                             reset);
                             
      
    assign filtered_bsf_data = data_lp + data_hp;

      
        vio_0 VIO1(
.clk(clk),
.probe_in0(ROM_Data),
.probe_in1(filtered_lpf_data),
.probe_in2(filtered_hpf_data),
.probe_in3(filtered_bpf_data),
.probe_in4(filtered_bsf_data)
);

ila_1 ILA1(
.clk(clk),
.probe0(ROM_Data),
.probe1(address),
.probe2(filtered_lpf_data),
.probe3(filtered_hpf_data),
.probe4(filtered_bpf_data),
.probe5(filtered_bsf_data)
);

endmodule
