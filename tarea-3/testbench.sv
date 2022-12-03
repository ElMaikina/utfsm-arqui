// Code your testbench here
// or browse Examples
module test();
 
  logic [7:0] A,B,salida,flags;
  logic [2:0] opcode;
 
  // Las funciones implementadas dentro del ALU
  // El número de la operación sigue aquel indicado
  // en el enunciado de la Tarea
  
  // Instancia al ALU
  ALU alu(A,B,opcode,salida,flags);
  
  initial begin
    A = 8'b0000_1111; 
    B = 8'b1000_0000; 
    opcode = 3'b100; #10;
    
    // Imprime el resultado por pantalla
    $display("\nTarea 3: SystemVerilog\n");
    $display("	Entrada A: %b",A);
    $display("	Entrada B: %b",B);
    $display("	Operacion: %b",opcode);
    $display("	Resultado: %b",salida);
    $display("	Flags: %b",flags);
    $display("\n");
  end
 
endmodule
