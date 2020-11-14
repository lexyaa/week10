`timescale    1ns/1ns

module tb;

parameter            tCK = 1000/10   ;   // 10MHz Clock

reg                  CLK             ;

initial              CLK = 1'b0      ;
always   #(tCK/2)    CLK = ~CLK      ;

wire     [51:0]      DO              ;

reg                  NWRT            ;
reg                  NCE             ;
reg      [5:0]       RA              ;
reg      [1:0]       CA              ;
reg      [51:0]      DI              ;

rflp256x52mx4        dut(
                    .NWRT   (NWRT   ),
                    .DI     (DI     ),
                    .RA     (RA     ),
                    .CA     (CA     ),
                    .NCE    (NCE    ),
                    .CLK    (CLK    ),
                    .DO     (DO     ));

initial begin
    #(2*tCK)
        memWrite(   6'd0,    2'd0,   52'd0   );
        memWrite(   6'd1,    2'd0,   52'd1   );
        memWrite(   6'd2,    2'd0,   52'd100 );
        memWrite(   6'd3,    2'd0,   52'd99  );
        memWrite(   6'd4,    2'd0,   52'd54  );
        memWrite(   6'd5,    2'd0,   52'd16  );
        memWrite(   6'd6,    2'd0,   52'd11  );
        memWrite(   6'd7,    2'd0,   52'd50  );
        memWrite(   6'd8,    2'd0,   52'd8   );
        memWrite(   6'd9,    2'd0,   52'd7   );
        memWrite(   6'd10,   2'd0,   52'd6   );
        memWrite(   6'd11,   2'd0,   52'd5   );
        memWrite(   6'd12,   2'd0,   52'd4   );
        memWrite(   6'd13,   2'd0,   52'd3   );
        memWrite(   6'd14,   2'd0,   52'd2   );
        memWrite(   6'd15,   2'd0,   52'd1   );
        memRead (   6'd0,    2'd0            );
        memRead (   6'd1,    2'd0            );
        memRead (   6'd2,    2'd0            );
        memRead (   6'd3,    2'd0            );
        memRead (   6'd4,    2'd0            );
        memRead (   6'd5,    2'd0            );
        memRead (   6'd6,    2'd0            );
        memRead (   6'd7,    2'd0            );
        memRead (   6'd8,    2'd0            );
        memRead (   6'd9,    2'd0            );
        memRead (   6'd10,   2'd0            );
        memRead (   6'd11,   2'd0            );
        memRead (   6'd12,   2'd0            );
        memRead (   6'd13,   2'd0            );
        memRead (   6'd14,   2'd0            );
        memRead (   6'd15,   2'd0            );
    #(10*tCK)    $finish;
end

task    memWrite;
    input   [5:0]   tiRA         ;
    input   [1:0]   tiCA         ;
    input   [51:0]  tiDI         ;
    begin
        NCE    = 1'b0  ;
        NWRT   = 1'b0  ;
        $display ("%g Memory WR w/ addr(%d/%d), data(%d)", $time, tiRA, tiCA, tiDI);
        @(negedge CLK) begin
            RA = tiRA  ;
            CA = tiCA  ;
            DI = tiDI  ;
        end    
    end
endtask

task    memRead;
    input   [5:0]   tiRA         ;
    input   [1:0]   tiCA         ;
    begin
        NCE    = 1'b0  ;
        NWRT   = 1'b1  ;
        $display ("%g Memory WR w/ addr(%d/%d)", $time, tiRA, tiCA);
        @(posedge CLK) begin
            RA = tiRA  ;
            CA = tiCA  ;
        end    
    end
endtask

endmodule
