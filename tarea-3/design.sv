// Code your design here

// La ALU definida como sale en el enunciado
// con los mismos nombres para los parametros

module ALU(input logic [7:0] A,B,
           input logic [2:0] opcode,
           output logic [7:0] salida,
           output logic [7:0] flags);
  
  // El valor de la unidad de control maneja las
  // operaciones a realizar
  
  always @(*) begin
  
    case(opcode)
      
      // Suma Simple
      // Pasa a B a Complemento de Dos y
      // luego lo resta a A
      3'b000: begin
        salida = A - (~B+1);
      end
      
      // Resta Simple
      // Pasa a B a Complemento de Dos y
      // luego lo suma a A
      3'b001: begin
        salida = A + (~B+1);
      end
      
      // Suma Positiva
      // Suma los dos numeros en forma
      // Signo Magnitud
      3'b010: begin
      		salida = A + B;
      end
      
      // Resta Positiva
      // Resta los dos numeros en forma
      // Signo Magnitud
      3'b011: begin
      		salida = A - B;
      end
      
      // Rotacion Izquierda
      // Desplaza B veces a A a la izquierda, 
      // si se sale del arreglo aparece por 
      // la derecha
      3'b100: begin
      		salida = (A << B) | (A >> (7-B));
      end
      
      // Rotacion Derecha
      // Desplaza B veces a A a la derecha, 
      // si se sale del arreglo aparece por 
      // la izquierda
      3'b101: begin
      		salida = (A >> B) | (A << (7-B));
      end
      
      // Duplicacion
      // Desplaza B veces a A a la izquierda
      3'b110: begin
      		salida = A << B;
      end
      
      // Division
      // Desplaza B veces a A a la derecha
      3'b111: begin
      		salida = A >> B;
      end
      
      // Si el caso es invalido retorna cero
      default: salida = 8'b0000_0000;
   	endcase
    
    assign flags = {( salida >= 255)  ? 1'b1 : 1'b0,
                    (salida == 0) ? 1'b1 : 1'b0, 
                    1'b0, 
                    ( (A + B > 255) | (A - B < 255) ) ? 1'b1 : 1'b0, 
                    (A > B) ? 1'b1 : 1'b0, 
                    (A == B) ? 1'b1 : 1'b0, 
                    (salida % 2) ? 1'b1 : 1'b0, 
                    (salida == 15 | salida == 51 | salida == 60 | salida == 85 | salida == 170 | salida == 195 | salida == 204 | salida == 240 ) ? 1'b1 : 1'b0};
  end
endmodule
