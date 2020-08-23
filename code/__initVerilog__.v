module GOL;
 
  parameter ROWS = 10;
  parameter COLS = 10;
  integer cnt=0;
  integer count;
  integer x,y;
 
  reg [COLS:1] matrix[1:ROWS];
  integer clk=1;
 
  initial begin
    for(y=1;y<=ROWS;y=y+1)
      matrix[y]=0;
    matrix[1][3:1]   = 3'b111;
    matrix[2][3:1]   = 3'b111;
    matrix[3][3:1]   = 3'b111;
    matrix[4][3:1]   = 3'b111;
    matrix[5][3:1]   = 3'b111;
    matrix[6][3:1]   = 3'b111;
    repeat(3) #10 clk = ~clk;
  end
 
  initial begin
    $display("  Generation %0d\n ",cnt);
    for(y=1;y<=ROWS;y=y+1)
      $display( "  %b", matrix[y] );
   
  end
 
  always @(negedge clk) begin
    for(y=1;y<=ROWS;y=y+1)
      begin
        for(x=1;x<=COLS;x=x+1)
          begin
            count=0;
            if (matrix[y-1][x-1] == 0 || matrix[y-1][x-1] == 1)
              count = count + matrix[y-1][x-1];
            if (matrix[y-1][x] == 0 || matrix[y-1][x] == 1)
              count = count + matrix[y-1][x];
            if (matrix[y-1][x+1] == 0 || matrix[y-1][x+1] == 1)
              count = count + matrix[y-1][x+1];
            if (matrix[y][x-1] == 0 || matrix[y][x-1] == 1)
              count = count + matrix[y][x-1];
            if (matrix[y][x+1] == 0 || matrix[y][x+1] == 1)
              count = count + matrix[y][x+1];
            if (matrix[y+1][x-1] == 0 || matrix[y+1][x-1] == 1)
              count = count + matrix[y+1][x-1];
            if (matrix[y+1][x] == 0 || matrix[y+1][x] == 1)
              count = count + matrix[y+1][x];
            if (matrix[y+1][x+1] == 0 || matrix[y+1][x+1] == 1)
              count = count + matrix[y+1][x+1];
            if (count == 3 && matrix[y][x]==1'b0 ) matrix[y][x] <= 1'b1;
            else if ((count < 2 || count > 3) &&  matrix[y][x]==1'b1 )  matrix[y][x] <= 1'b0;
    end
  end
  end
 
  always @(posedge clk) begin
    $display("\n*****************\n");
    cnt=cnt+1;
    $display("  Generation %0d\n",cnt);
    for(y=1;y<=ROWS;y=y+1)
      $display( "  %b", matrix[y] );
  end
 
endmodule
