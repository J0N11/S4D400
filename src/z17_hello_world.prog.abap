*&---------------------------------------------------------------------*
*& Report z17_hello_world
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_hello_world.
PARAMETERS: p_op TYPE STRING.
PARAMETERS: p_num1 TYPE I.
PARAMETERS: p_num2 TYPE I.
DATA p_result TYPE INT8.

IF p_op = '+'.
p_result = p_num1 + p_num2.
ELSEIF p_op = '-'.
p_result = p_num1 - p_num2.
ELSEIF p_op = '*'.
p_result = p_num1 * p_num2.
ELSEIF p_op = '/'.
IF p_num2 = '0'. WRITE 'Durch 0 teilen ist nicht möglich'.
ELSE.
p_result = p_num1 / p_num2.
ENDIF.
ELSEIF p_op = '^'.
IF p_num2 = 0.
p_result = 1.
ELSEIF p_num2 = 1.
p_result = p_num1.
ELSEIF p_num2 >= 1.
p_result = p_num1.
DO p_num2 - 1 TIMES.
p_result *= p_num1.
ENDDO.
ENDIF.
ELSEIF p_op = '%'.
DATA l_result TYPE s4d400_percentage.
CALL FUNCTION 'S4D400_CALCULATE_PERCENTAGE'
    EXPORTING
        iv_int1 = p_num1
        iv_int2 = p_num2
    IMPORTING
        ev_result = l_result.
WRITE l_result.
ENDIF.

WRITE p_result.
