// Tiny Tapeout Compatible Verilog
`timescale 1ns / 1ps

module tt_um_mark28277 (
    input wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input wire           ena,
    input wire           clk,
    input wire           rst_n
);

    // Input interface for Tiny Tapeout I/O
    wire reset;
    assign reset = ~rst_n;

    // Neural network input (8-bit for Tiny Tapeout)
    wire [7:0] input_data;
    assign input_data = ui_in;

    // Conv2d Layer 0
    wire [7:0] conv_0_out;
    conv2d_layer conv_inst_0 (
        .clk(clk),
        .reset(reset),
        .input_data(input_data),
        .output_data(conv_0_out)
    );

    // ReLU Layer 1
    wire [7:0] relu_1_out;
    relu_layer relu_inst_1 (
        .clk(clk),
        .reset(reset),
        .input_data(conv_0_out),
        .output_data(relu_1_out)
    );

    // MaxPool2d Layer 2
    wire [7:0] maxpool_2_out;
    maxpool_layer maxpool_inst_2 (
        .clk(clk),
        .reset(reset),
        .input_data(relu_1_out),
        .output_data(maxpool_2_out)
    );

    // Conv2d Layer 3
    wire [7:0] conv_3_out;
    conv2d_layer conv_inst_3 (
        .clk(clk),
        .reset(reset),
        .input_data(maxpool_2_out),
        .output_data(conv_3_out)
    );

    // ReLU Layer 4
    wire [7:0] relu_4_out;
    relu_layer relu_inst_4 (
        .clk(clk),
        .reset(reset),
        .input_data(conv_3_out),
        .output_data(relu_4_out)
    );

    // MaxPool2d Layer 5
    wire [7:0] maxpool_5_out;
    maxpool_layer maxpool_inst_5 (
        .clk(clk),
        .reset(reset),
        .input_data(relu_4_out),
        .output_data(maxpool_5_out)
    );

    // Conv2d Layer 6
    wire [7:0] conv_6_out;
    conv2d_layer conv_inst_6 (
        .clk(clk),
        .reset(reset),
        .input_data(maxpool_5_out),
        .output_data(conv_6_out)
    );

    // ReLU Layer 7
    wire [7:0] relu_7_out;
    relu_layer relu_inst_7 (
        .clk(clk),
        .reset(reset),
        .input_data(conv_6_out),
        .output_data(relu_7_out)
    );

    // MaxPool2d Layer 8
    wire [7:0] maxpool_8_out;
    maxpool_layer maxpool_inst_8 (
        .clk(clk),
        .reset(reset),
        .input_data(relu_7_out),
        .output_data(maxpool_8_out)
    );

    // Linear Layer 9
    wire [7:0] linear_9_out;
    linear_layer linear_inst_9 (
        .clk(clk),
        .reset(reset),
        .input_data(maxpool_8_out),
        .output_data(linear_9_out)
    );

    // Final output signal
    wire [7:0] final_output;
    assign final_output = linear_9_out;

    // Output interface for Tiny Tapeout I/O
    reg [7:0] uo_out_reg;
    reg [7:0] uio_out_reg;
    reg [7:0] uio_oe_reg;

    always @(posedge clk) begin
        if (reset) begin
            uo_out_reg <= 8'b0;
            uio_out_reg <= 8'b0;
            uio_oe_reg <= 8'b0;
        end else if (ena) begin
            // Output final result to dedicated output
            uo_out_reg <= final_output;
            // Output inverted result to bidirectional output
            uio_out_reg <= ~final_output;
            // Set all IOs as outputs
            uio_oe_reg <= 8'hFF;
        end
    end

    assign uo_out = uo_out_reg;
    assign uio_out = uio_out_reg;
    assign uio_oe = uio_oe_reg;

endmodule

// Conv2d Layer for Tiny Tapeout
module conv2d_layer (
    input wire clk,
    input wire reset,
    input wire [7:0] input_data,
    output wire [7:0] output_data
);

    // convolution for Tiny Tapeout
    reg [7:0] output_reg;

    always @(posedge clk) begin
        if (reset) begin
            output_reg <= 8'b0;
        end else begin
            // convolution operation
            output_reg <= input_data + 8'h10;
        end
    end

    assign output_data = output_reg;

endmodule

// Linear Layer for Tiny Tapeout
module linear_layer (
    input wire clk,
    input wire reset,
    input wire [7:0] input_data,
    output wire [7:0] output_data
);

    // linear layer for Tiny Tapeout
    reg [7:0] output_reg;

    always @(posedge clk) begin
        if (reset) begin
            output_reg <= 8'b0;
        end else begin
            // linear operation
            output_reg <= input_data + 8'h20;
        end
    end

    assign output_data = output_reg;

endmodule

// ReLU Layer for Tiny Tapeout
module relu_layer (
    input wire clk,
    input wire reset,
    input wire [7:0] input_data,
    output wire [7:0] output_data
);

    // ReLU for Tiny Tapeout
    reg [7:0] output_reg;

    always @(posedge clk) begin
        if (reset) begin
            output_reg <= 8'b0;
        end else begin
            // ReLU operation
            if (input_data[7] == 1'b0) begin
                output_reg <= input_data;
            end else begin
                output_reg <= 8'b0;
            end
        end
    end

    assign output_data = output_reg;

endmodule

// MaxPool Layer for Tiny Tapeout
module maxpool_layer (
    input wire clk,
    input wire reset,
    input wire [7:0] input_data,
    output wire [7:0] output_data
);

    // maxpool for Tiny Tapeout
    reg [7:0] output_reg;

    always @(posedge clk) begin
        if (reset) begin
            output_reg <= 8'b0;
        end else begin
            // maxpool operation
            output_reg <= input_data;
        end
    end

    assign output_data = output_reg;

endmodule
