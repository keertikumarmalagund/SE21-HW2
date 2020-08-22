module GOL;
 
  parameter ROWS = 10;
  parameter COLS = 10;
  bit cnt=0;
  int count;
 
  bit [COLS:1] matrix[1:ROWS];
  bit clk=1;
 
  initial begin
    matrix[1][3:1]   = 3'b111;
    matrix[2][3:1]   = 3'b111;
    matrix[3][3:1]   = 3'b111;
    matrix[4][3:1]   = 3'b111;
    matrix[5][3:1]   = 3'b111;
    matrix[6][3:1]   = 3'b111;
    repeat(3) #10 clk = ~clk;
  end
 
  initial begin
    $display("  Generation-%b\n ",cnt);
   foreach (matrix[y]) $display( "  %b", matrix[y] );
   
  end
 
  always @(negedge clk) begin
    for(int y=1;y<=ROWS;y++)
      begin
        for(int x=1;x<=COLS;x++)
          begin
         count = $countones({ matrix[y-1][x-1+:3], matrix[y][x-1], matrix[y] [x+1], matrix[y+1][x-1+:3] });
            if (count == 3 && matrix[y][x]==1'b0 ) matrix[y][x] <= 1'b1;
            else if ((count < 2 || count > 3) &&  matrix[y][x]==1'b1 )  matrix[y][x] <= 1'b0;
    end
  end
  end
 
  always @(posedge clk) begin
    $display("\n*****************\n");
    $display("  Generation-%b\n",++cnt);
    foreach (matrix[y]) $display( "  %b", matrix[y] );
  end
 
endmodule
